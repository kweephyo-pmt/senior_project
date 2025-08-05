<!-- role-setup.vue -->
<template>
  <div class="min-h-screen bg-gray-100 py-4 flex flex-col justify-center relative overflow-hidden">
    <!-- Background pattern -->
    <div class="absolute inset-0 bg-[url('data:image/svg+xml,%3Csvg%20width%3D%2230%22%20height%3D%2230%22%20viewBox%3D%220%200%2030%2030%22%20fill%3D%22none%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Cpath%20d%3D%22M1.22676%200C1.91374%200%202.45351%200.539773%202.45351%201.22676C2.45351%201.91374%201.91374%202.45351%201.22676%202.45351C0.539773%202.45351%200%201.91374%200%201.22676C0%200.539773%200.539773%200%201.22676%200Z%22%20fill%3D%22rgba(0%2C61%2C124%2C0.07)%22%2F%3E%3C%2Fsvg%3E')] opacity-40"></div>
    <div class="relative py-3 sm:max-w-xl sm:mx-auto z-10">
      <!-- MFU Logo and Title -->
      <div class="text-center mb-4 animate-fade-in">
        <MFULogo class="w-20 h-20 mx-auto mb-3 text-[#003D7C] transform hover:scale-105 transition-transform duration-300" />
        <h1 class="text-[#003D7C] text-2xl font-semibold bg-clip-text text-transparent bg-gradient-to-r from-[#003D7C] to-[#0056b3]">Mae Fah Luang University</h1>
        <p class="text-gray-600 mt-2 font-medium">School of Management</p>
      </div>

      <!-- Main Card -->
      <div class="relative px-4 py-6 bg-white/95 backdrop-blur-sm mx-8 md:mx-0 shadow-2xl rounded-2xl sm:p-8 transform hover:shadow-3xl transition-all duration-300 border border-gray-100">
        <div class="max-w-md mx-auto">
          <!-- User Profile Card -->
          <div class="mb-6 bg-gradient-to-r from-[#003D7C]/5 to-[#0056b3]/5 rounded-xl p-4 border border-[#003D7C]/10">
            <div class="flex items-start space-x-4">
              <div class="relative flex-shrink-0">
                <img 
                  :src="photoURL"
                  :alt="auth.currentUser?.displayName || 'User'"
                  class="w-12 h-12 rounded-full object-cover ring-4 ring-white shadow-lg transition-transform hover:scale-105 duration-300"
                  @error="handleImageError"
                />
                <div class="absolute -bottom-1 -right-1 bg-green-500 w-4 h-4 rounded-full border-2 border-white shadow-sm">
                  <span class="absolute inset-0 animate-ping bg-green-400 rounded-full opacity-75"></span>
                </div>
              </div>
              <div class="flex-1">
                <div class="flex items-center justify-between">
                  <div>
                    <h3 class="font-medium text-gray-900 flex items-center space-x-2">
                      <span>{{ auth.currentUser?.displayName }}</span>
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                      </svg>
                    </h3>
                    <p class="text-sm text-gray-500 flex items-center space-x-2">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                      </svg>
                      <span>{{ auth.currentUser?.email }}</span>
                    </p>
                  </div>
                  <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                    Online
                  </span>
                </div>
                <div class="mt-3 text-sm text-gray-500 border-t border-gray-100 pt-3">
                  <p>Complete your profile setup by selecting your role and verifying your credentials.</p>
                </div>
              </div>
            </div>
          </div>
          <!-- Card Header -->
          <div class="text-center mb-6">
            <h2 class="text-2xl font-bold bg-gradient-to-r from-[#003D7C] to-[#0056b3] bg-clip-text text-transparent">Role Setup</h2>
            <p class="text-gray-600 mt-2 max-w-sm mx-auto">
              Welcome! Please select your role and verify your credentials to continue.
            </p>
          </div>

          <div class="space-y-6">

              <!-- Role Selection -->
              <div class="mb-4">
                <label class="flex items-center space-x-2 text-sm font-semibold text-gray-700 mb-2">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[#003D7C]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2" />
                  </svg>
                  <span>Select Your Role</span>
                </label>
                <div class="relative">
                  <select
                    v-model="selectedRole"
                    class="appearance-none block w-full px-4 py-3 text-base border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#003D7C] focus:border-transparent transition duration-150 ease-in-out bg-gray-50 hover:bg-white"
                  >
                    <option value="" disabled>Choose your role</option>
                    <option v-for="role in roles" :key="role" :value="role" class="py-2">
                      {{ role.charAt(0).toUpperCase() + role.slice(1) }}
                    </option>
                  </select>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                      <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                    </svg>
                  </div>
                </div>
              </div>

              <!-- Password Input -->
              <div class="mb-4">
                <label class="flex items-center space-x-2 text-sm font-semibold text-gray-700 mb-2">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[#003D7C]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                  <span>Role Password</span>
                </label>
                <div class="relative">
                  <div class="relative">
                    <input
                      v-model="password"
                      :type="showPassword ? 'text' : 'password'"
                      class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-md text-sm shadow-sm placeholder-gray-400
                        focus:outline-none focus:border-[#003D7C] focus:ring-1 focus:ring-[#003D7C]
                        disabled:bg-gray-50 disabled:text-gray-500 disabled:border-gray-200 disabled:shadow-none
                        pr-10
                      "
                      placeholder="Enter role password"
                      required
                    />
                    <button
                      type="button"
                      @click="showPassword = !showPassword"
                      class="absolute right-0 top-1/2 -translate-y-1/2 pr-3 flex items-center text-gray-400 hover:text-gray-600 transition-colors"
                    >
                      <svg
                        v-if="showPassword"
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                      >
                        <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                        <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
                      </svg>
                      <svg
                        v-else
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                      >
                        <path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd" />
                        <path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z" />
                      </svg>
                    </button>
                  </div>
                </div>
              </div>

              <!-- Error Message -->
              <div v-if="error" class="mb-6">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded">
                  <div class="flex items-center">
                    <div class="flex-shrink-0">
                      <svg class="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                      </svg>
                    </div>
                    <div class="ml-3">
                      <p class="text-sm text-red-700">{{ error }}</p>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Submit Button -->
              <div class="pt-4 space-y-4">
                <button
                  @click="verifyAndSetupRole"
                  class="group w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-gradient-to-r from-[#003D7C] to-[#0056b3] hover:from-[#004a96] hover:to-[#006bd6] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#003D7C] transition-all duration-300 transform hover:translate-y-[-1px]"
                  :disabled="loading"
                >
                  <svg
                    v-if="loading"
                    class="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      class="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      stroke-width="4"
                    />
                    <path
                      class="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    />
                  </svg>
                  <span class="flex items-center">
                    {{ loading ? 'Setting up...' : 'Complete Setup' }}
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-2 transform group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
                    </svg>
                  </span>
                </button>
                <button
                  @click="cancelSetup"
                  class="mt-4 w-full flex justify-center py-3 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#003D7C] transition-all duration-300 transform hover:translate-y-[-1px]"
                  :disabled="loading"
                >
                  <span class="flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Cancel
                  </span>
                </button>
              </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getFirestore, doc, getDoc, setDoc, updateDoc } from 'firebase/firestore'
import { getAuth, signOut } from 'firebase/auth'
import type { UserRole } from '~/types/auth'
import type { UserRoleData } from '~/types/auth'
import { useAlert } from '~/composables/useAlert'
import { roleRoutes, getClientIP } from '~/composables/useFirebaseAuth'
import MFULogo from '~/components/mfulogo.vue'

const route = useRoute()
const router = useRouter()
const { showAlert } = useAlert()
const auth = getAuth()

// Compute standardized photo URL with fallback
const photoURL = computed(() => {
  // Priority 1: User's photoURL from Firebase Auth
  if (auth.currentUser?.photoURL) {
    return auth.currentUser.photoURL
  }
  // Priority 2: Generate fallback avatar
  const displayName = auth.currentUser?.displayName || 'User'
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
})

// Handle image loading errors by falling back to generated avatar
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  const displayName = auth.currentUser?.displayName || 'User'
  const fallbackURL = `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
  
  // Only change if it's not already the fallback URL to prevent infinite loops
  if (img.src !== fallbackURL) {
    img.src = fallbackURL
  }
}

// Route guard setup
onMounted(async () => {
  const currentUser = auth.currentUser
  
  // If not logged in, redirect to home
  if (!currentUser) {
    showAlert('error', 'Unauthorized', 'Please sign in first')
    router.push('/')
    return
  }

  // If no email in query params, redirect to home
  if (!route.query.email) {
    showAlert('error', 'Invalid Access', 'Missing email parameter')
    router.push('/')
    return
  }

  // If query email doesn't match current user's email, redirect to home
  if (route.query.email !== currentUser.email) {
    showAlert('error', 'Unauthorized', 'Email mismatch')
    router.push('/')
    return
  }

  // Check if user already has a role
  const db = getFirestore()
  const userDoc = await getDoc(doc(db, 'users', currentUser.email))
  const userData = userDoc.data()

  if (userData?.role) {
    showAlert('info', 'Role Already Set', 'You already have a role assigned')
    router.push(`/${userData.role}/dashboard`)
    return
  }
})

const email = route.query.email as string
const roles = ['admin', 'dean', 'lecturer'] as const
const selectedRole = ref<UserRole>()
const password = ref('')
const showPassword = ref(false)
const error = ref('')
const loading = ref(false)

const cancelSetup = async () => {
  const { showAlert } = useAlert()
  try {
    const auth = getAuth()
    // Clear any existing error messages
    error.value = ''
    loading.value = false
    
    // Reset form
    selectedRole.value = undefined
    password.value = ''
    
    // Sign out and redirect
    await signOut(auth)
    showAlert('info', 'Setup Cancelled', 'Role setup was cancelled. You have been signed out.')
    router.push('/')
  } catch (error) {
    console.error('Error during sign out:', error)
    showAlert('error', 'Error', 'Failed to sign out')
  }
}

const verifyAndSetupRole = async () => {
  if (!selectedRole.value || !password.value) return
  
  loading.value = true
  error.value = ''
  
  try {
    loading.value = true
    error.value = ''

    // Get current user data
    const auth = getAuth()
    const currentUser = auth.currentUser
    if (!currentUser) throw new Error('No authenticated user')

    // Get Firestore instance
    const db = getFirestore()

    // Verify role password
    const rolePasswordsDoc = await getDoc(doc(db, 'rolePasswords', 'passwords'))
    const rolePasswords = rolePasswordsDoc.data()

    // Check if this is first time setup for this role
    if (!rolePasswords || !rolePasswords[selectedRole.value]) {
      console.log('First time setup for role:', selectedRole.value)
      // Set up role password
      const updatedPasswords = {
        ...rolePasswords,
        [selectedRole.value]: password.value
      }
      await setDoc(doc(db, 'rolePasswords', 'passwords'), updatedPasswords)
    } else if (rolePasswords[selectedRole.value] !== password.value) {
      error.value = 'Invalid role password'
      loading.value = false
      return
    }

    // Create user document with complete data
    const userData: UserRoleData = {
      email,
      displayName: currentUser.displayName || undefined,
      photoURL: currentUser.photoURL || undefined,
      role: selectedRole.value,
      verified: true as const,
      createdAt: new Date(),
      isActive: true,
      lastLogin: new Date().toISOString(),
      lastLoginIP: await getClientIP()
    }
    console.log('Creating user data with role:', userData)
    await setDoc(doc(db, 'users', email), userData)

    showAlert('success', 'Success', 'Role setup completed successfully')
    router.push(roleRoutes[selectedRole.value].default)
  } catch (err) {
    console.error('Role setup error:', err)
    error.value = 'An error occurred during role setup'
  } finally {
    loading.value = false
  }
}
</script>
