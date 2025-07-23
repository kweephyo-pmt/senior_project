<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Header -->
    <header class="bg-gradient-to-r from-[#0f2c52] to-[#156b8e] shadow-lg sticky top-0 z-30">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
          <!-- Logo and Title -->
          <div class="flex items-center">
            <div class="py-6">
              <div class="flex items-center justify-center">
                <mfulogo />
                <div class="w-0.5 h-10 bg-white mx-3"></div>
                <div>
                  <h2 class="text-xl font-bold text-white mb-1">SoM.BI</h2>
                  <div class="w-full h-0.5 bg-white mb-1"></div>
                  <p class="text-xs text-white">School of Management</p>
                </div>
              </div>
            </div>
            <div class="w-px h-10 mx-4 px-10"></div>
            <div>
              <h1 class="text-2xl font-bold text-white">Faculty Analytics Dashboard</h1>
              <p class="text-sm text-white/80">Faculty Performance Overview</p>
            </div>
          </div>

          <!-- Right Section -->
          <div class="flex items-center space-x-6">
            <!-- Academic Year -->
            <div class="flex items-center space-x-2">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white/90" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>
              <span class="text-white font-medium">Academic Year 2025</span>
            </div>

            <!-- User Profile -->
            <div class="relative">
              <button @click="toggleDropdown" class="flex items-center space-x-3 bg-white/10 p-2 rounded-full">
                <div class="w-10 h-10 rounded-full bg-white overflow-hidden relative">
                  <div class="w-full h-full flex items-center justify-center bg-gray-100"
                    :class="{ 'hidden': showImage }">
                    <span class="text-xl font-semibold text-gray-500">{{ (userData?.displayName ||
                      'U')?.[0]?.toUpperCase() }}</span>
                  </div>
                  <img v-show="showImage" :src="userData?.photoURL || user?.photoURL"
                    :alt="userData?.displayName || 'User'" class="w-full h-full object-cover absolute inset-0"
                    @error="handleImageError" @load="handleImageLoad" />
                </div>
                <span class="text-white font-semibold pr-2">{{ userData?.displayName || 'User' }}</span>
              </button>

              <!-- Dropdown Menu -->
              <transition enter-active-class="transition ease-out duration-100"
                enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95">
                <div v-if="dropdownOpen"
                  class="origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5 focus:outline-none">
                  <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Your Profile</a>
                  <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
                  <button @click="logout"
                    class="w-full text-left block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Logout</button>
                </div>
              </transition>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main>
      <slot />
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { useFirebaseAuth } from '~/composables/useFirebaseAuth'
import { doc, getDoc, getFirestore } from 'firebase/firestore'
import mfulogo from '@/components/mfulogo.vue'

const { user, logout } = useFirebaseAuth()
const userData = ref<any>(null)
const showImage = ref(false)
const dropdownOpen = ref(false)

const toggleDropdown = () => {
  dropdownOpen.value = !dropdownOpen.value
}

// Handle image load errors
const handleImageError = () => {
  showImage.value = false
}

// Handle successful image load
const handleImageLoad = () => {
  showImage.value = true
}

async function fetchUserData() {
  if (user.value?.email) {
    const userDoc = await getDoc(doc(getFirestore(), 'users', user.value.email))
    if (userDoc.exists()) {
      userData.value = userDoc.data()
    }
  }
}

onMounted(fetchUserData)

// Watch for changes in user authentication
watch(() => user.value?.email, fetchUserData)
</script>
