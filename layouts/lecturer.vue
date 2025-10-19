<template>
  <div class="min-h-screen flex">
    <!-- Sidebar -->
    <aside class="w-64 bg-gradient-to-b from-[#18345c] via-[#17688f] to-[#137b97] text-white flex-col sticky top-0 h-screen hidden md:flex">
      <!-- Logo Section -->
      <div class="px-8 py-6">
        <div class="flex items-center justify-center">
          <mfulogo/>
          <div class="w-0.5 h-10 bg-[#FFFFFF] mx-3"></div>
          <div>
            <h2 class="text-xl font-bold text-white mb-1">SoM.BI</h2>
            <div class="w-full h-0.5 bg-[#FFFFFF] mb-1"></div>
            <p class="text-xs text-white">School of Management</p>
          </div>
        </div>
      </div>
      <!-- Navigation Menu -->
      <nav class="flex-1 px-4 py-6">
        <ul class="space-y-1">
          <li>
            <NuxtLink to="/lecturer/dashboard" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/lecturer/dashboard' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
              Profile
            </NuxtLink>
          </li>
          <li>
            <NuxtLink to="/lecturer/kpi-overview" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/lecturer/kpi-overview' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
              KPI
            </NuxtLink>
          </li>
          <li>
            <NuxtLink to="/lecturer/budget" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/lecturer/budget' }">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              Budget
            </NuxtLink>
          </li>
        </ul>
      </nav>
      <!-- User Profile at Bottom -->
      <div class="p-4 border-t border-[#035e80] flex items-center">
        <div v-if="initialLoading" class="w-10 h-10 rounded-full bg-gray-300 mr-3 animate-pulse"></div>
        <div v-else class="w-10 h-10 rounded-full bg-white overflow-hidden mr-3 relative">
          <div class="w-full h-full flex items-center justify-center bg-gray-100" :class="{ 'hidden': showImage }">
            <span class="text-xl font-semibold text-gray-500">{{ (userData?.displayName || user?.displayName || 'U')?.[0]?.toUpperCase() }}</span>
          </div>
          <img 
            v-show="showImage"
            :src="photoURL" 
            :alt="userData?.displayName || user?.displayName || 'User'" 
            class="w-full h-full object-cover absolute inset-0" 
            @error="handleImageError"
            @load="handleImageLoad"
          />
        </div>
        <div v-if="initialLoading" class="animate-pulse">
          <div class="h-4 bg-gray-300 rounded w-24 mb-1"></div>
          <div class="h-3 bg-gray-300 rounded w-16"></div>
        </div>
        <div v-else>
          <p class="text-sm font-medium text-white">{{ userData?.displayName || user?.displayName || 'User' }}</p>
          <p class="text-xs text-[#7fc6de]/80">Lecturer</p>
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
      class="fixed inset-0 bg-black bg-opacity-50 transition-opacity md:hidden z-[55]"
      @click="showSidebar = false"
      aria-hidden="true"
    ></div>

    <!-- Mobile Sidebar -->
    <aside 
      class="fixed inset-y-0 left-0 bg-gradient-to-b from-[#18345c] via-[#17688f] to-[#137b97] shadow-2xl w-[280px] z-[60] flex flex-col md:hidden transform transition-transform duration-300 ease-in-out"
      :class="showSidebar ? 'translate-x-0' : '-translate-x-full'"
      aria-label="Mobile sidebar"
    >
      <!-- Mobile Sidebar Header -->
      <div class="sticky top-0 z-20 flex flex-col">
        <!-- Logo Section -->
        <div class="px-5 py-5 border-b border-white/10">
          <div class="flex items-center">
            <mfulogo class="w-10 h-10"/>
            <div class="w-0.5 h-10 bg-white/30 mx-3"></div>
            <div>
              <h2 class="text-xl font-bold text-white">SoM.BI</h2>
              <div class="w-full h-0.5 bg-white/30 my-1"></div>
              <p class="text-xs text-white/80">School of Management</p>
            </div>
          </div>
        </div>
      </div>
      <nav class="flex-1 px-5 py-6 overflow-y-auto">
        <ul class="space-y-1">
          <li v-for="(item, index) in menuItems" :key="index">
            <NuxtLink 
              :to="item.path" 
              @click="showSidebar = false" 
              class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-lg transition-all duration-200 group"
              :class="{ 'bg-[#035475] shadow-lg': $route.path === item.path }"
            >
              <component 
                :is="item.icon" 
                class="h-5 w-5 mr-3 transition-transform duration-200 group-hover:scale-110" 
                :fill="'none'" 
                :viewBox="'0 0 24 24'" 
                :stroke="'currentColor'"
              />
              <span class="font-medium">{{ item.label }}</span>
            </NuxtLink>
          </li>
        </ul>
      </nav>
      <!-- User Profile at Bottom -->
      <div class="sticky bottom-0 border-t border-[#035e80]">
        <div class="p-4 flex items-center">
          <div v-if="initialLoading" class="w-10 h-10 rounded-full bg-white/20 animate-pulse mr-3"></div>
          <div v-else class="w-10 h-10 rounded-full bg-white overflow-hidden mr-3 relative ring-2 ring-white/20">
            <div class="w-full h-full flex items-center justify-center bg-gray-100" :class="{ 'hidden': showImage }">
              <span class="text-xl font-semibold text-gray-500">{{ (userData?.displayName || user?.displayName || 'U')?.[0]?.toUpperCase() }}</span>
            </div>
            <img 
              v-show="showImage"
              :src="photoURL" 
              :alt="userData?.displayName || user?.displayName || 'User'" 
              class="w-full h-full object-cover absolute inset-0"
              @error="handleImageError"
              @load="handleImageLoad"
            />
          </div>
          <div v-if="initialLoading" class="flex-1 animate-pulse">
            <div class="h-4 bg-white/20 rounded w-24 mb-2"></div>
            <div class="h-3 bg-white/20 rounded w-16"></div>
          </div>
          <div v-else class="flex-1 min-w-0">
            <p class="text-sm font-semibold text-white truncate">{{ userData?.displayName || user?.displayName || 'User' }}</p>
            <p class="text-xs text-white/70">Lecturer</p>
          </div>
          <button 
            @click="logout" 
            class="ml-2 p-2 text-white/70 hover:text-white hover:bg-white/10 rounded-lg transition-all duration-200"
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
    <div class="flex-1 bg-gray-50 min-h-screen flex flex-col">
      <!-- Mobile menu button -->
      <div class="md:hidden sticky top-0 z-40 bg-white p-3 sm:p-4 shadow-sm">
        <button @click="showSidebar = !showSidebar" class="text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2" aria-label="Toggle sidebar">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
      </div>
      <!-- Page Content -->
      <slot />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, computed } from 'vue'
import { useFirebaseAuth } from '~/composables/useFirebaseAuth'

// Menu items for mobile navigation
const menuItems = [
  {
    path: '/lecturer/dashboard',
    label: 'Profile',
    icon: 'svg-user'
  },
  {
    path: '/lecturer/kpi-overview',
    label: 'KPI',
    icon: 'svg-kpi'
  },
  {
    path: '/lecturer/budget',
    label: 'Budget',
    icon: 'svg-budget'
  }
]

// Define SVG components for icons
type IconType = 'svg-user' | 'svg-kpi' | 'svg-budget'

const icons: Record<IconType, () => string> = {
  'svg-user': () => `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
  </svg>`,
  'svg-kpi': () => `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
  </svg>`,
  'svg-budget': () => `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
  </svg>`
}

// Register SVG components
Object.entries(icons).forEach(([key, icon]) => {
  const component = {
    name: key as IconType,
    template: icon(),
    props: {
      fill: { type: String, default: 'none' },
      viewBox: { type: String, default: '0 0 24 24' },
      stroke: { type: String, default: 'currentColor' }
    }
  }
  defineComponent(component)
})
import { doc, getDoc, getFirestore } from 'firebase/firestore'
import mfulogo from '@/components/mfulogo.vue'

const { user, logout } = useFirebaseAuth()
const showSidebar = ref(false)
const userData = ref<any>(null)
const showImage = ref(false)

// Initial loading state to prevent flash of fallback content
const initialLoading = ref(true)

// Handle image load errors by falling back to generated avatar
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  const displayName = userData.value?.displayName || user.value?.displayName || 'User'
  const fallbackURL = `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
  
  // Only change if it's not already the fallback URL to prevent infinite loops
  if (img.src !== fallbackURL) {
    img.src = fallbackURL
    showImage.value = true // Show the fallback image
  } else {
    showImage.value = false // Hide if even fallback fails
  }
}

// Handle successful image load
const handleImageLoad = () => {
  showImage.value = true
}

// Compute standardized photo URL
const photoURL = computed(() => {
  // Priority 1: User's photoURL from Firebase Auth
  if (user.value?.photoURL) {
    return user.value.photoURL
  }
  // Priority 2: User data photoURL from Firestore
  if (userData.value?.photoURL) {
    return userData.value.photoURL
  }
  // Priority 3: Generate fallback avatar
  const displayName = userData.value?.displayName || user.value?.displayName || 'User'
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
})

async function fetchUserData() {
  if (user.value?.email) {
    try {
      const userDoc = await getDoc(doc(getFirestore(), 'users', user.value.email))
      if (userDoc.exists()) {
        userData.value = userDoc.data()
      }
    } catch (error) {
      console.error('Error fetching user data:', error)
    } finally {
      // Set initial loading to false after user data fetch completes (or fails)
      initialLoading.value = false
    }
  } else {
    // If no user email, still set loading to false to show fallback content
    initialLoading.value = false
  }
}

onMounted(fetchUserData)

// Watch for changes in user authentication
watch(() => user.value?.email, fetchUserData)
</script>
