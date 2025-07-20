import { initializeApp } from 'firebase/app'
import { getAuth, setPersistence, browserLocalPersistence } from 'firebase/auth'

export default defineNuxtPlugin(async (nuxtApp) => {
  const config = {
    // Replace with your Firebase config
    apiKey: "AIzaSyAm7B_bdMezQ-rqFjScE593hGGCVBa7VZ0",
    authDomain: "curriculum-statistics.firebaseapp.com",
    projectId: "curriculum-statistics",
    storageBucket: "curriculum-statistics.appspot.com",
    messagingSenderId: "51782680110",
    appId: "1:51782680110:web:6bc2a46eb9f791892a29bf"
  }

  // Initialize Firebase
  const app = initializeApp(config)
  const auth = getAuth(app)

  // Enable auth persistence
  await setPersistence(auth, browserLocalPersistence)
})