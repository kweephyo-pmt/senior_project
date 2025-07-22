<template>
  <div class="min-h-screen flex">
    <!-- Desktop Sidebar -->
    <aside class="w-64 bg-gradient-to-b from-[#18345c] via-[#17688f] to-[#137b97] text-white flex-col sticky top-0 h-screen hidden md:flex">
      <!-- Logo Section -->
      <div class="px-8 py-6">
        <div class="flex items-center justify-center">
          <mfulogo/>
          <div class="w-0.5 h-10 bg-white mx-3"></div>
          <div>
            <h2 class="text-xl font-bold text-white mb-1">SoM.BI</h2>
            <div class="w-full h-0.5 bg-white mb-1"></div>
            <p class="text-xs text-white">School of Management</p>
          </div>
        </div>
      </div>

      <!-- Navigation Menu -->
      <nav class="flex-1 px-4 py-4 overflow-y-auto">
        <ul class="space-y-0.5">
          <li>
            <NuxtLink to="/admin/dashboard" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/dashboard' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
              </svg>
              Dashboard
            </NuxtLink>
          </li>
          <li>
            <NuxtLink to="/admin/users" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/users' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
              </svg>
              Users Management
            </NuxtLink>
          </li>
          <li>
            <NuxtLink to="/admin/profile" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/profile' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
              Profile
            </NuxtLink>
          </li>
          <li>
            <NuxtLink to="/admin/budget" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/budget' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              Budget
            </NuxtLink>
          </li>
        </ul>
      </nav>

      <!-- User Profile at Bottom -->
      <div class="p-4 border-t border-[#035e80] flex items-center">
        <div class="w-10 h-10 rounded-full bg-white overflow-hidden mr-3 relative">
          <div class="w-full h-full flex items-center justify-center bg-gray-100" :class="{ 'hidden': showImage }">
            <span class="text-xl font-semibold text-gray-500">{{ (userData?.displayName || 'U')?.[0]?.toUpperCase() }}</span>
          </div>
          <img 
            v-show="showImage"
            :src="userData?.photoURL || user?.photoURL" 
            :alt="userData?.displayName || 'User'" 
            class="w-full h-full object-cover absolute inset-0" 
            @error="handleImageError"
            @load="handleImageLoad"
          />
        </div>
        <div>
          <p class="text-sm font-medium text-white">{{ userData?.displayName || 'User' }}</p>
          <p class="text-xs text-[#7fc6de]/80">Administrator</p>
        </div>
        <button 
          @click="logout" 
          class="ml-auto text-white/70 hover:text-white hover:bg-white/10 p-2 rounded-lg transition-colors"
          aria-label="Logout"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </button>
      </div>
    </aside>

    <!-- Mobile Sidebar Overlay -->
    <div 
      v-if="showSidebar" 
      class="fixed inset-0 bg-black bg-opacity-50 transition-opacity md:hidden z-40"
      @click="showSidebar = false"
      aria-hidden="true"
    ></div>

    <!-- Mobile Sidebar -->
    <aside 
      class="fixed inset-y-0 left-0 bg-gradient-to-b from-[#18345c] via-[#17688f] to-[#1597bb] shadow-2xl w-[280px] z-50 flex flex-col md:hidden transform transition-transform duration-300 ease-in-out"
      :class="showSidebar ? 'translate-x-0' : '-translate-x-full'"
      aria-label="Mobile sidebar"
    >
      <!-- Mobile Sidebar Header -->
      <div class="sticky top-0 z-20 flex flex-col bg-[#18466d] shadow-lg">
        <!-- Top Bar -->
        <div class="flex items-center justify-between px-4 py-2">
          <h2 class="text-lg font-semibold text-white">Menu</h2>
          <button 
            @click="showSidebar = false"
            class="p-2 text-white hover:bg-white/10 rounded-lg transition-colors"
            aria-label="Close sidebar"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        
        <!-- Logo Section -->
        <div class="px-4 py-3 border-t border-white/10">
          <div class="flex items-center space-x-3">
            <div class="flex items-center">
              <mfulogo class="w-8 h-8"/>
              <div class="w-0.5 h-8 bg-[#FFFFFF]/50 mx-3"></div>
              <div>
                <h2 class="text-lg font-bold text-white mb-1">SoM.BI</h2>
                <div class="w-full h-0.5 bg-[#FFFFFF]/50 mb-1"></div>
                <p class="text-xs text-white/90">School of Management</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Mobile Navigation Menu -->
      <nav class="flex-1 px-4 py-6">
        <ul class="space-y-1">
          <li>
            <NuxtLink 
              to="/admin/dashboard" 
              @click="showSidebar = false"
              class="flex items-center px-3 py-2.5 text-white/90 hover:text-white hover:bg-[#035e80]/50 rounded-lg transition-all duration-200" 
              :class="{ 'bg-[#035475]/60 text-white shadow-sm': $route.path === '/admin/dashboard' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
              </svg>
              Dashboard
            </NuxtLink>
          </li>
          <li>
            <NuxtLink 
              to="/admin/users" 
              @click="showSidebar = false"
              class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" 
              :class="{ 'bg-[#035475]': $route.path === '/admin/users' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
              </svg>
              Users Management
            </NuxtLink>
          </li>
          <li>
            <NuxtLink 
              to="/admin/profile" 
              @click="showSidebar = false"
              class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" 
              :class="{ 'bg-[#035475]': $route.path === '/admin/profile' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
              Profile
            </NuxtLink>
          </li>
          <li>
            <NuxtLink 
              to="/admin/budget" 
              @click="showSidebar = false"
              class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" 
              :class="{ 'bg-[#035475]': $route.path === '/admin/budget' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              Budget
            </NuxtLink>
          </li>
        </ul>
      </nav>

      <!-- Mobile User Profile at Bottom -->
      <div class="sticky bottom-0 bg-[#18345c]/90 backdrop-blur-sm border-t border-[#035e80]/30 pt-3 pb-4 px-4">
        <div class="flex items-center p-2 rounded-xl bg-white/5">
          <div class="w-10 h-10 rounded-full ring-2 ring-white/10 overflow-hidden mr-3 shadow-lg">
            <img 
              :src="photoURL" 
              :alt="userData?.displayName || 'User'" 
              class="w-full h-full object-cover" 
            />
          </div>
          <div class="flex-1 min-w-0">
            <p class="text-sm font-medium text-white truncate">{{ userData?.displayName || 'User' }}</p>
            <p class="text-xs text-[#7fc6de]/80">Administrator</p>
          </div>
          <button 
            @click="logout" 
            class="ml-2 p-2 text-white/70 hover:text-white hover:bg-white/10 rounded-lg transition-colors" 
            aria-label="Logout"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
          </button>
        </div>
      </div>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 bg-gray-50">
      <!-- Mobile Header -->
      <div class="md:hidden sticky top-0 z-50 bg-white p-4 shadow-sm">
        <button @click="showSidebar = !showSidebar" class="text-blue-700 focus:outline-none" aria-label="Toggle sidebar">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
      <slot />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, computed } from 'vue'
import { useFirebaseAuth } from '~/composables/useFirebaseAuth'
import { doc, getDoc, getFirestore } from 'firebase/firestore'
import mfulogo from '@/components/mfulogo.vue'

const { user, logout } = useFirebaseAuth()
const showSidebar = ref(false)
const userData = ref<any>(null)
const showImage = ref(false)

// Handle image load errors
const handleImageError = () => {
  showImage.value = false
}

// Handle successful image load
const handleImageLoad = () => {
  showImage.value = true
}

// Compute photo URL
const photoURL = computed(() => {
  return user.value?.photoURL || `https://ui-avatars.com/api/?name=${encodeURIComponent(userData.value?.displayName || 'User')}`
})

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
