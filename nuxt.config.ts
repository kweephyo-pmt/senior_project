// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  runtimeConfig: {
    public: {
      apiBaseUrl: process.env.VITE_API_BASE_URL,
      apiUsername: process.env.VITE_API_USERNAME,
      apiPassword: process.env.VITE_API_PASSWORD,
      evaluateId: process.env.VITE_EVALUATE_ID,
      apiLang: process.env.VITE_API_LANG,
      staffCodeUndergraduate: process.env.VITE_STAFF_CODE_UNDERGRADUATE,
      staffCodeGraduate: process.env.VITE_STAFF_CODE_GRADUATE,
      // Firebase configuration
      firebaseApiKey: process.env.FIREBASE_API_KEY,
      firebaseAuthDomain: process.env.FIREBASE_AUTH_DOMAIN,
      firebaseProjectId: process.env.FIREBASE_PROJECT_ID,
      firebaseStorageBucket: process.env.FIREBASE_STORAGE_BUCKET,
      firebaseMessagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
      firebaseAppId: process.env.FIREBASE_APP_ID
    }
  },
  modules: ['@nuxtjs/tailwindcss'],
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  nitro: {
    preset: 'node-server',
    experimental: {
      wasm: true
    }
  },
  ssr: true,
  router: {
    options: {
      strict: false
    }
  }
})
