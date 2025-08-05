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
                <path d="M12 14l9-5-9-5-9 5 9 5z" />
                <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
              </svg>
              Faculties
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

          <!-- Profile and Budget visible only when on /admin/profile OR /admin/budget -->
          <template v-if="$route.path === '/admin/profile' || $route.path === '/admin/budget'">
            <li>
              <NuxtLink to="/admin/profile" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/profile' }">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                Profile
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/admin/budget" class="flex items-center px-4 py-3 text-white hover:bg-[#035e80] rounded-md transition-colors" :class="{ 'bg-[#035475]': $route.path === '/admin/budget' }">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Budget
              </NuxtLink>
            </li>
          </template>
        </ul>
      </nav>

      <!-- User Profile at Bottom -->
      <div class="p-4 border-t border-[#035e80] flex items-center">
        <div class="w-10 h-10 rounded-full bg-white overflow-hidden mr-3 relative">
          <div class="w-full h-full flex items-center justify-center bg-gray-100" :class="{ 'hidden': showImage }">
            <span class="text-xl font-semibold text-gray-500">{{ (userData?.displayName || 'U')?.[0]?.toUpperCase() }}</span>
          </div>
          <img
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
                <path d="M12 14l9-5-9-5-9 5 9 5z" />
                <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
              </svg>
              Faculties
            </NuxtLink>
          </li>
          <li>
            <NuxtLink
              to="/admin/users"
              @click="showSidebar = false"
              class="flex items-center px-3 py-2.5 text-white/90 hover:text-white hover:bg-[#035e80]/50 rounded-lg transition-all duration-200"
              :class="{ 'bg-[#035475]/60 text-white shadow-sm': $route.path === '/admin/users' }"
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
              class="flex items-center px-3 py-2.5 text-white/90 hover:text-white hover:bg-[#035e80]/50 rounded-lg transition-all duration-200"
              :class="{ 'bg-[#035475]/60 text-white shadow-sm': $route.path === '/admin/profile' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
              Profile
            </NuxtLink>
          </li>
          <li>
            <NuxtLink
              to="/admin/budget"
              @click="showSidebar = false"
              class="flex items-center px-3 py-2.5 text-white/90 hover:text-white hover:bg-[#035e80]/50 rounded-lg transition-all duration-200"
              :class="{ 'bg-[#035475]/60 text-white shadow-sm': $route.path === '/admin/budget' }"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
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
import mfulogo from '@/components/mfulogo.vue'
import { doc, getDoc, getFirestore } from 'firebase/firestore'
import { computed, onMounted, ref, watch } from 'vue'
import { useFirebaseAuth } from '~/composables/useFirebaseAuth'

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