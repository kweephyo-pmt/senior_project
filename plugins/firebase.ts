import { initializeApp, getApps, getApp } from 'firebase/app'
import { getAuth, setPersistence, browserLocalPersistence } from 'firebase/auth'
import { getFirestore } from 'firebase/firestore'

export default defineNuxtPlugin(async (nuxtApp) => {
  const runtimeConfig = useRuntimeConfig()
  
  // Firebase configuration from runtime config with fallbacks
  const config = {
    apiKey: runtimeConfig.public.firebaseApiKey || "AIzaSyAm7B_bdMezQ-rqFjScE593hGGCVBa7VZ0",
    authDomain: runtimeConfig.public.firebaseAuthDomain || "curriculum-statistics.firebaseapp.com",
    projectId: runtimeConfig.public.firebaseProjectId || "curriculum-statistics",
    storageBucket: runtimeConfig.public.firebaseStorageBucket || "curriculum-statistics.firebasestorage.app",
    messagingSenderId: runtimeConfig.public.firebaseMessagingSenderId || "51782680110",
    appId: runtimeConfig.public.firebaseAppId || "1:51782680110:web:6bc2a46eb9f791892a29bf"
  }

  try {
    // Check if Firebase app already exists
    let app
    if (getApps().length === 0) {
      // Initialize Firebase only if no app exists
      app = initializeApp(config)
      console.log('Firebase initialized successfully')
    } else {
      // Use existing Firebase app
      app = getApp()
      console.log('Using existing Firebase app')
    }

    // Initialize Firebase services
    const auth = getAuth(app)
    const db = getFirestore(app)

    // Enable auth persistence
    await setPersistence(auth, browserLocalPersistence)
    
    return {
      provide: {
        firebase: {
          app,
          auth,
          db
        }
      }
    }
  } catch (error) {
    console.error('Firebase initialization error:', error)
    throw error
  }
})