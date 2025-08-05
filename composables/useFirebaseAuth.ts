import { ref, onMounted } from 'vue'
import { getAuth, onAuthStateChanged, signOut, type User, GoogleAuthProvider, signInWithPopup, type AuthError } from 'firebase/auth'
import { getFirestore, doc, getDoc, setDoc, collection } from 'firebase/firestore'
import { useRouter } from 'vue-router'
import { useAlert } from './useAlert'
import type { UserRoleData } from '~/types/auth'

// Check if email is from MFU
const isMFUEmail = (email: string): boolean => {
  const mfuDomains = ['@mfu.ac.th', '@lamduan.mfu.ac.th']
  return mfuDomains.some(domain => email.toLowerCase().endsWith(domain))
}

// Define role-based route configuration
export const roleRoutes = {
  admin: {
    prefix: '/admin',
    default: '/admin/dashboard'
  },
  dean: {
    prefix: '/dean',
    default: '/dean/dashboard'
  },
  lecturer: {
    prefix: '/lecturer',
    default: '/lecturer/dashboard'
  }
} as const

type AppUserRole = keyof typeof roleRoutes

// Helper to get default path for a role
export const getDefaultPath = (role: AppUserRole): string => {
  return roleRoutes[role].default
}

// Standardize Google profile photo URL
export const standardizePhotoURL = (url: string | null | undefined): string | undefined => {
  if (!url) return undefined
  // Remove any existing size parameters
  const baseUrl = url.split('=')[0]
  // Add standard size (96px) and circular crop
  return `${baseUrl}=s96-c`
}

// Generate default avatar URL
const getDefaultAvatarURL = (displayName: string) => {
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName || 'User')}&background=random`
}

// Get cached photo URL from localStorage
const getCachedPhotoURL = (email: string): string | null => {
  const cached = localStorage.getItem(`avatar_${email}`)
  if (cached) {
    try {
      const { url, timestamp } = JSON.parse(cached)
      // Cache for 24 hours
      if (Date.now() - timestamp < 24 * 60 * 60 * 1000) {
        return url
      }
    } catch (e) {
      localStorage.removeItem(`avatar_${email}`)
    }
  }
  return null
}

// Cache photo URL in localStorage
const cachePhotoURL = (email: string, url: string) => {
  localStorage.setItem(`avatar_${email}`, JSON.stringify({
    url,
    timestamp: Date.now()
  }))
}

// Get user data from Firestore
const getUserData = async (email: string): Promise<UserRoleData | null> => {
  const db = getFirestore()
  const userDoc = await getDoc(doc(db, 'users', email))
  const userData = userDoc.data() as UserRoleData | undefined
  
  if (userData) {
    // Check cache first
    const cachedURL = getCachedPhotoURL(email)
    if (cachedURL) {
      userData.photoURL = cachedURL
      return userData
    }

    // If no photoURL exists, create and store a default avatar
    if (!userData.photoURL && userData.displayName) {
      userData.photoURL = getDefaultAvatarURL(userData.displayName)
      // Update Firestore with the default avatar
      await setDoc(doc(db, 'users', email), { photoURL: userData.photoURL }, { merge: true })
    } else if (userData.photoURL) {
      // Standardize Google photo URL if it exists
      userData.photoURL = standardizePhotoURL(userData.photoURL)
    }

    // Cache the final URL
    if (userData.photoURL) {
      cachePhotoURL(email, userData.photoURL)
    }
  }
  
  console.log('User data from Firestore:', userData)
  return userData || null
}


// Helper function to get client IP
export const getClientIP = async (): Promise<string> => {
  try {
    const response = await fetch('https://api.ipify.org?format=json')
    const data = await response.json()
    return data.ip
  } catch (error) {
    console.error('Failed to get client IP:', error)
    return 'unknown'
  }
}

export function useFirebaseAuth() {
  const router = useRouter()
  const auth = getAuth()
  const { showAlert } = useAlert()
  const user = useState<User | null>('user', () => null)
  const isLoading = useState<boolean>('isLoading', () => true)
  const loginAttempts = useState<{ [key: string]: { count: number; lastAttempt: number } }>('loginAttempts', () => ({}))

  // Rate limiting function
  const checkRateLimit = (email: string): boolean => {
    const now = Date.now()
    const attempts = loginAttempts.value[email] || { count: 0, lastAttempt: 0 }
    
    // Reset counter if last attempt was more than 15 minutes ago
    if (now - attempts.lastAttempt > 15 * 60 * 1000) {
      attempts.count = 0
    }
    
    // Allow max 5 attempts within 15 minutes
    if (attempts.count >= 5) {
      return false
    }
    
    attempts.count++
    attempts.lastAttempt = now
    loginAttempts.value[email] = attempts
    
    return true
  }

  // Helper function to handle user authentication state
  const handleUserAuthState = async (currentUser: User | null, showWelcome = false) => {
    if (!currentUser) {
      router.push('/')
      return
    }

    const email = currentUser.email
    if (!email) {
      router.push('/')
      return
    }

    const userData = await getUserData(email)
    // Only log on first check or when userData changes
    if (!user.value || user.value.email !== email) {
      console.log('Auth state changed:', { email, hasUserData: !!userData })
    }
    
    // Ensure user object has the correct photo URL
    if (userData?.photoURL && currentUser) {
      // Create a new user object with the photo URL from Firestore
      const updatedUser = {
        ...currentUser,
        photoURL: userData.photoURL,
        displayName: userData.displayName || currentUser.displayName
      } as User
      user.value = updatedUser
    } else {
      user.value = currentUser
    }

    // Check if user is deactivated
    if (userData?.isActive === false) {
      console.log('User is deactivated:', email)
      showAlert('error', 'Account Deactivated', 'Your account has been deactivated. Please contact the administrator.')
      await signOut(auth)
      router.push('/')
      return
    }

    // If no user data, redirect to role setup
    if (!userData) {
      console.log('No user data found, redirecting to role setup')
      const currentPath = router.currentRoute.value.path
      if (!currentPath.startsWith('/auth/role-setup')) {
        router.push({ 
          path: '/auth/role-setup',
          query: { email }
        })
      }
      return
    }

    // Show welcome message if requested
    if (showWelcome) {
      showAlert('success', 'Welcome Back!', `You are signed in as ${userData.role}`)
      await new Promise(resolve => setTimeout(resolve, 500))
    }

    // Handle routing based on role
    if (userData.role) {
      const currentPath = router.currentRoute.value.path
      const userRole = userData.role as AppUserRole

      // Always redirect from index page to dashboard
      if (currentPath === '/') {
        const redirectPath = roleRoutes[userRole].default
        router.push(redirectPath)
        return
      }

      // Check if current path is accessible
      const hasAccess = await canAccessRoute(currentPath)
      if (!hasAccess) {
        if (currentPath.startsWith('/auth/')) {
          router.push(roleRoutes[userRole].default)
        } else {
          showAlert('error', 'Access Denied', 'You do not have permission to access this page')
          router.push('/unauthorized')
        }
      } else {
        localStorage.setItem('lastPath', currentPath)
      }
    }
  }

  // Function to check if a route is accessible for a role
  const canAccessRoute = async (path: string): Promise<boolean> => {
    if (!user.value?.email) return false

    const userData = await getUserData(user.value.email)
    const role = userData?.role as keyof typeof roleRoutes | undefined

    if (!role) return false

    return path === '/' || 
           path === '/unauthorized' || 
           path.startsWith('/auth/') || 
           path.startsWith(roleRoutes[role].prefix)
  }

  // Add debouncing to prevent excessive auth state checks
  let authStateTimeout: NodeJS.Timeout | null = null
  
  onMounted(() => {
    const unsubscribe = onAuthStateChanged(auth, async (currentUser) => {
      // Clear any pending timeout
      if (authStateTimeout) {
        clearTimeout(authStateTimeout)
      }
      
      // Debounce auth state changes
      authStateTimeout = setTimeout(async () => {
        user.value = currentUser
        isLoading.value = false
        await handleUserAuthState(currentUser)
      }, 100) // 100ms debounce
    })

    return () => {
      if (authStateTimeout) {
        clearTimeout(authStateTimeout)
      }
      unsubscribe()
    }
  })

  const logout = async () => {
    try {
      await signOut(auth)
      showAlert('info', 'Goodbye!', 'You have been successfully signed out')
      router.push('/')
    } catch (error) {
      console.error('Logout error:', error)
      showAlert('error', 'Error', 'Failed to sign out. Please try again.')
    }
  }

  const signInWithGoogle = async () => {
    try {
      const provider = new GoogleAuthProvider()
      provider.addScope('profile')
      provider.addScope('email')
      
      // Enforce MFU domain and additional security parameters
      provider.setCustomParameters({
        hd: 'mfu.ac.th',
        prompt: 'select_account',
        // Add additional security parameters
        auth_type: 'reauthenticate'
      })
      
      const result = await signInWithPopup(auth, provider)
      const email = result.user.email?.toLowerCase()
      
      if (!email) {
        showAlert('error', 'Sign In Failed', 'No email found in your Google account')
        await signOut(auth)
        return
      }

      // Check rate limit
      if (!checkRateLimit(email)) {
        showAlert('error', 'Too Many Attempts', 'Too many sign in attempts. Please try again in 15 minutes.')
        await signOut(auth)
        return
      }

      if (!isMFUEmail(email)) {
        showAlert('error', 'Unauthorized', 'Please sign in with your MFU email address (@mfu.ac.th or @lamduan.mfu.ac.th)')
        await signOut(auth)
        return
      }
      
      // Check if user is deactivated before proceeding
      const db = getFirestore()
      const userDoc = await getDoc(doc(db, 'users', email))
      const userData = userDoc.data() as UserRoleData | undefined
      

      
      if (!userData) {
        // New user - redirect to role setup
        router.push(`/auth/role-setup?email=${encodeURIComponent(email)}`)
        return
      }

      if (userData.isActive === false) {
        showAlert('error', 'Account Deactivated', 'Your account has been deactivated. Please contact the administrator.')
        await signOut(auth)
        return
      }

      // Verify email verification status
      if (!result.user.emailVerified) {
        showAlert('error', 'Email Not Verified', 'Please verify your email address before signing in.')
        await signOut(auth)
        return
      }
      
      // Handle profile photo URL properly
      let finalPhotoURL = userData?.photoURL
      
      // Priority 1: Use Google profile photo from sign-in result
      if (result.user.photoURL) {
        const standardizedGooglePhoto = standardizePhotoURL(result.user.photoURL)
        finalPhotoURL = standardizedGooglePhoto
        // Cache the Google photo URL
        if (standardizedGooglePhoto) {
          cachePhotoURL(email, standardizedGooglePhoto)
        }
      }
      // Priority 2: Use cached photo URL
      else if (!finalPhotoURL) {
        const cachedPhoto = getCachedPhotoURL(email)
        if (cachedPhoto) {
          finalPhotoURL = cachedPhoto
        }
      }
      // Priority 3: Generate default avatar if no photo available
      if (!finalPhotoURL) {
        finalPhotoURL = getDefaultAvatarURL(userData?.displayName || result.user.displayName || 'User')
      }
      
      // Update Firestore with the final photo URL
      await setDoc(doc(db, 'users', email), { 
        photoURL: finalPhotoURL,
        displayName: userData?.displayName || result.user.displayName || 'User'
      }, { merge: true })

      // Update last login timestamp
      await setDoc(doc(db, 'users', email), { 
        lastLogin: new Date().toISOString(),
        lastLoginIP: await getClientIP() // You'll need to implement this function
      }, { merge: true })

      await handleUserAuthState(result.user, true)
    } catch (error) {
      const authError = error as AuthError
      let errorMessage = 'An error occurred during sign in'
      
      switch (authError.code) {
        case 'auth/popup-closed-by-user':
          errorMessage = 'Sign in was cancelled'
          break
        case 'auth/popup-blocked':
          errorMessage = 'Sign in popup was blocked. Please allow popups for this site'
          break
        case 'auth/cancelled-popup-request':
          errorMessage = 'Another sign in attempt is in progress'
          break
        case 'auth/network-request-failed':
          errorMessage = 'Network error. Please check your internet connection'
          break
        case 'auth/account-exists-with-different-credential':
          errorMessage = 'An account already exists with this email address'
          break
        case 'auth/too-many-requests':
          errorMessage = 'Too many sign in attempts. Please try again later'
          break
      }
      
      showAlert('error', 'Sign In Failed', errorMessage)
      console.error('Sign in error:', authError)
    }
  }

  return {
    user,
    isLoading,
    logout,
    signInWithGoogle
  }
}
