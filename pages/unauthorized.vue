<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center px-4">
    <div class="max-w-lg w-full bg-white rounded-lg shadow-md p-8 text-center">
      <div class="mb-6">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-red-500 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
        </svg>
      </div>
      <h1 class="text-2xl font-bold text-gray-900 mb-4">Unauthorized Access</h1>
      <p class="text-gray-600 mb-6">
        You don't have permission to access this page. Please contact your administrator if you believe this is an error.
      </p>
      <div class="flex justify-center space-x-4">
        <button @click="goBack" class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300 transition-colors">
          Go Back
        </button>
        <button @click="goHome" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition-colors">
          Go to Home
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const router = useRouter()

const goBack = () => {
  router.back()
}

const goHome = () => {
  navigateTo('/')
}
</script>
