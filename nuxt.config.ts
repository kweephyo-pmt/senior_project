// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  app: {
    head: {
      title: 'SOM-BI',
      meta: [
        // Basic meta tags
        { name: 'description', content: 'Comprehensive faculty performance management system for Mae Fah Luang University School of Management. Track KPIs, budgets, teaching performance, and research activities.' },
        { name: 'keywords', content: 'faculty performance, KPI tracking, budget management, teaching evaluation, research management, Mae Fah Luang University' },
        { name: 'author', content: 'Mae Fah Luang University School of Management' },
        
        // Open Graph / Facebook Meta Tags
        { property: 'og:url', content: 'https://app.som-bi.work.gd' },
        { property: 'og:type', content: 'website' },
        { property: 'og:title', content: 'SOM-BI - Faculty Performance Management System' },
        { property: 'og:description', content: 'Comprehensive faculty performance management system for Mae Fah Luang University School of Management. Track KPIs, budgets, teaching performance, and research activities.' },
        { property: 'og:image', content: 'https://app.som-bi.work.gd/images/preview-1200x630.jpg' },
        { property: 'og:image:width', content: '1200' },
        { property: 'og:image:height', content: '630' },
        { property: 'og:image:alt', content: 'SOM-BI Faculty Performance Management Dashboard' },
        { property: 'og:site_name', content: 'SOM-BI' },
        { property: 'og:locale', content: 'en_US' },
        
        // Twitter Meta Tags
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:url', content: 'https://app.som-bi.work.gd' },
        { name: 'twitter:title', content: 'SOM-BI - Faculty Performance Management System' },
        { name: 'twitter:description', content: 'Comprehensive faculty performance management system for Mae Fah Luang University School of Management. Track KPIs, budgets, teaching performance, and research activities.' },
        { name: 'twitter:image', content: 'https://app.som-bi.work.gd/images/preview-1200x630.jpg' },
        { name: 'twitter:image:alt', content: 'SOM-BI Faculty Performance Management Dashboard' },
        
        // Additional SEO meta tags
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'robots', content: 'index, follow' },
        { name: 'theme-color', content: '#1e40af' }
      ],
      link: [
        { rel: 'canonical', href: 'https://app.som-bi.work.gd' },
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  },
  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_BACKEND_API_URL || process.env.BACKEND_API_URL,
      apiBaseUrl: process.env.VITE_API_BASE_URL,
      apiUsername: process.env.VITE_API_USERNAME,
      apiPassword: process.env.VITE_API_PASSWORD,
      evaluateId: process.env.VITE_EVALUATE_ID,
      apiLang: process.env.VITE_API_LANG,
      staffCodeUndergraduate: process.env.VITE_STAFF_CODE_UNDERGRADUATE,
      staffCodeGraduate: process.env.VITE_STAFF_CODE_GRADUATE,
      // Firebase configuration - using NUXT_PUBLIC_ prefix for client-side access
      firebaseApiKey: process.env.NUXT_PUBLIC_FIREBASE_API_KEY || process.env.FIREBASE_API_KEY,
      firebaseAuthDomain: process.env.NUXT_PUBLIC_FIREBASE_AUTH_DOMAIN || process.env.FIREBASE_AUTH_DOMAIN,
      firebaseProjectId: process.env.NUXT_PUBLIC_FIREBASE_PROJECT_ID || process.env.FIREBASE_PROJECT_ID,
      firebaseStorageBucket: process.env.NUXT_PUBLIC_FIREBASE_STORAGE_BUCKET || process.env.FIREBASE_STORAGE_BUCKET,
      firebaseMessagingSenderId: process.env.NUXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID || process.env.FIREBASE_MESSAGING_SENDER_ID,
      firebaseAppId: process.env.NUXT_PUBLIC_FIREBASE_APP_ID || process.env.FIREBASE_APP_ID
    }
  },
  modules: ['@nuxtjs/tailwindcss'],
  compatibilityDate: '2024-11-01',
  devtools: { enabled: true },
  nitro: {
    preset: 'node-server',
    experimental: {
      wasm: true
    },
    devProxy: {
      '/api': {
        target: 'https://senior-project-backend-51782680110.asia-southeast1.run.app',
        changeOrigin: true
      }
    }
  },
  vite: {
    server: {
      cors: {
        origin: true,
        credentials: true
      }
    }
  },
  ssr: true,
  router: {
    options: {
      strict: false
    }
  }
})
