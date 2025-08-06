<template>
  <!-- Overview Banner with background image -->
  <div class="relative h-32 sm:h-40 md:h-48 lg:h-56 overflow-hidden">
    <div class="absolute inset-0">
      <img :src="bgImage" alt="Background" class="w-full h-full object-cover opacity-60" />
    </div>
    <div class="absolute inset-0 bg-black/30"></div>
    <div class="relative container mx-auto px-3 sm:px-4 md:px-6 lg:px-20 pt-4 sm:pt-6 lg:pt-8 z-10">
      <h1 class="text-2xl sm:text-4xl md:text-5xl lg:text-6xl xl:text-[82px] font-bold text-[#1D3555] leading-tight">Overview</h1>
      <h2 class="text-sm sm:text-lg md:text-xl lg:text-2xl text-[#1D3555] px-0 sm:px-1.5 mt-1">Welcome back, {{ user?.displayName || 'User' }}</h2>
    </div>
  </div>

  <!-- Content Area -->
  <div class="px-3 sm:px-4 md:px-6 py-4 sm:py-6 md:py-8 max-w-7xl mx-auto min-h-[calc(100vh-14rem)]">
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Education & Research Area -->
      <div class="sm:col-span-2 md:col-span-2 lg:col-span-1">
        <div class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6 mb-4 sm:mb-6">
          <h3 class="text-xl font-bold text-gray-800 mb-3 border-b pb-2">Education</h3>
          <div v-if="initialLoading || educationLoading" class="space-y-4">
            <div v-for="i in 3" :key="i" class="animate-pulse">
              <div class="flex items-start space-x-4">
                <div class="w-3 h-3 rounded-full bg-gray-200 mt-2"></div>
                <div class="flex-1 space-y-2">
                  <div class="h-5 bg-gray-200 rounded w-16"></div>
                  <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                  <div class="h-3 bg-gray-200 rounded w-1/2"></div>
                </div>
              </div>
            </div>
          </div>
          <div v-else-if="!initialLoading && education && education.length > 0">
            <ul class="space-y-3">
              <li v-for="(edu, idx) in education" :key="idx" class="relative pl-8">
                <span class="absolute left-0 top-1.5 w-3 h-3 rounded-full bg-blue-500"></span>
                <div class="flex flex-col">
                  <span class="font-bold text-lg text-gray-900">{{ edu.year }}</span>
                  <span class="font-semibold text-gray-800">{{ edu.degree }}</span>
                  <span class="text-gray-600 text-sm">{{ edu.institution }}</span>
                </div>
              </li>
            </ul>
          </div>
          <div v-else class="text-center py-8">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
            </svg>
            <h3 class="mt-2 text-sm font-medium text-gray-900">No education data</h3>
            <p class="mt-1 text-sm text-gray-500">Education information will appear here when available.</p>
          </div>
        </div>
        <div class="bg-white rounded-xl shadow p-4">
          <h3 class="text-xl font-bold text-gray-800 mb-3 border-b pb-2">Research Areas</h3>
          <div v-if="initialLoading || researchLoading" class="space-y-3">
            <div v-for="i in 4" :key="i" class="animate-pulse">
              <div class="flex items-start gap-3">
                <div class="w-2 h-2 rounded-full bg-gray-200 mt-2 flex-shrink-0"></div>
                <div class="h-4 bg-gray-200 rounded flex-1"></div>
              </div>
            </div>
          </div>
          <div v-else-if="!initialLoading && researchAreas && researchAreas.length > 0" class="space-y-3">
            <div v-for="(area, idx) in researchAreas" :key="idx" class="flex items-start gap-3">
              <span class="inline-block w-2 h-2 rounded-full bg-blue-500 mt-2 flex-shrink-0"></span>
              <span class="text-gray-700 text-base leading-relaxed">{{ area }}</span>
            </div>
          </div>
          <div v-else class="text-center py-8">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
            </svg>
            <h3 class="mt-2 text-sm font-medium text-gray-900">No research areas</h3>
            <p class="mt-1 text-sm text-gray-500">Research areas will appear here when available.</p>
          </div>
        </div>
      </div>
      <!-- Contact & Publications -->
      <div class="sm:col-span-2 md:col-span-2 lg:col-span-2 flex flex-col gap-4">
        <!-- Contact Card -->
        <div class="bg-white rounded-xl shadow p-4 mb-3">
          <div v-if="initialLoading || profileLoading" class="animate-pulse">
            <div class="flex flex-col md:flex-row items-center gap-4">
              <div class="flex-shrink-0">
                <div class="w-20 h-20 rounded-full bg-gray-200"></div>
              </div>
              <div class="flex-1 min-w-0 space-y-3">
                <div class="h-8 bg-gray-200 rounded w-3/4"></div>
                <div class="h-4 bg-gray-200 rounded w-1/2"></div>
                <div class="space-y-2">
                  <div class="flex items-center gap-3">
                    <div class="w-9 h-9 rounded-full bg-gray-200"></div>
                    <div class="h-4 bg-gray-200 rounded w-48"></div>
                  </div>
                  <div class="flex items-center gap-3">
                    <div class="w-9 h-9 rounded-full bg-gray-200"></div>
                    <div class="h-4 bg-gray-200 rounded w-32"></div>
                  </div>
                  <div class="flex items-center gap-3">
                    <div class="w-9 h-9 rounded-full bg-gray-200"></div>
                    <div class="h-4 bg-gray-200 rounded w-40"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-else-if="!initialLoading" class="flex flex-col md:flex-row items-center gap-4">
            <div class="flex-shrink-0">
              <div class="w-20 h-20 rounded-full overflow-hidden border-4 border-blue-300 bg-white shadow">
                <img :src="photoURL" :alt="user?.displayName || 'User'" class="w-full h-full object-cover" @error="handleImageError" />
              </div>
            </div>
            <div class="flex-1 min-w-0">
              <h2 class="text-2xl font-bold text-gray-800">{{ user?.displayName || 'User' }}{{ profile?.position ? ` (${profile.position})` : '' }}</h2>
              <p class="text-gray-600 mb-2">{{ profile?.program || 'Accounting Program' }}</p>
              <div class="flex flex-col gap-4 mt-4 text-gray-700">
                <!-- Email -->
                <div class="flex items-center gap-3">
                  <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-blue-100">
                    <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 4h16v16H4V4zm0 0l8 8 8-8"/></svg>
                  </span>
                  <span class="text-base">{{ user?.email || 'n/a' }}</span>
                </div>
                <!-- Phone -->
                <div class="flex items-center gap-3">
                  <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-green-100">
                    <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 5a2 2 0 012-2h2.28a2 2 0 011.7 1.06l1.1 2.21a2 2 0 01-.45 2.32l-.7.7a16.06 16.06 0 006.58 6.58l.7-.7a2 2 0 012.32-.45l2.21 1.1A2 2 0 0121 18.72V21a2 2 0 01-2 2h-1C7.82 23 1 16.18 1 8V7a2 2 0 012-2z"/></svg>
                  </span>
                  <span class="text-base">{{ profile?.phone || 'n/a' }}</span>
                </div>
                <!-- Location -->
                <div class="flex items-center gap-3">
                  <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-purple-100">
                    <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 21s-6-5.686-6-10a6 6 0 1112 0c0 4.314-6 10-6 10zm0-8a2 2 0 100-4 2 2 0 000 4z"/></svg>
                  </span>
                  <span class="text-base">{{ profile?.location || 'n/a' }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Publications Card -->
        <div class="bg-white rounded-xl shadow p-4">
          <div class="flex justify-between items-center mb-3">
            <h3 class="text-xl font-bold text-gray-800">Recent Publications</h3>
            <NuxtLink to="/lecturer/publications" class="text-blue-600 text-base hover:underline">View All</NuxtLink>
          </div>
          <div v-if="initialLoading || publicationsLoading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            <div v-for="i in 3" :key="i" class="bg-gray-50 rounded-xl sm:rounded-2xl p-4 sm:p-5 animate-pulse">
              <div class="space-y-4">
                <div class="h-5 bg-gray-200 rounded w-full"></div>
                <div class="h-4 bg-gray-200 rounded w-3/4"></div>
                <div class="h-6 bg-gray-200 rounded w-16"></div>
              </div>
              <div class="flex items-center gap-3 mt-4">
                <div class="w-8 h-8 rounded-full bg-gray-200"></div>
                <div class="h-4 bg-gray-200 rounded w-24"></div>
              </div>
            </div>
          </div>
          <div v-else-if="!initialLoading && publications && publications.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            <div v-for="(pub, idx) in publications" :key="idx" class="bg-blue-50 rounded-xl sm:rounded-2xl p-4 sm:p-5 flex flex-col justify-between shadow hover:shadow-lg transition">
              <div>
                <p class="font-semibold text-blue-900 text-base sm:text-lg mb-2">{{ pub.title }}</p>
                <p class="text-gray-600 text-sm sm:text-base mb-2">{{ pub.venue }} &bull; {{ pub.year }}</p>
                <a v-if="pub.link" :href="pub.link" class="inline-flex items-center px-3 py-1 bg-blue-200 text-blue-800 rounded text-xs sm:text-sm font-semibold mb-2">
                  <svg class="w-4 h-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                  </svg>
                  Link
                </a>
              </div>
              <div class="flex items-center gap-3 mt-4">
                <img :src="photoURL" class="w-8 h-8 rounded-full border border-blue-300" @error="handleImageError" />
                <span class="text-sm sm:text-base text-gray-700 font-medium">{{ user?.displayName || 'User' }}</span>
              </div>
            </div>
          </div>
          <div v-else-if="!initialLoading" class="text-center py-12">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
            </svg>
            <h3 class="mt-2 text-sm font-medium text-gray-900">No publications yet</h3>
            <p class="mt-1 text-sm text-gray-500">Recent publications will appear here when available.</p>
            <div class="mt-6">
              <NuxtLink to="/lecturer/publications" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                <svg class="-ml-1 mr-2 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                </svg>
                Add Publication
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, watch } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useLecturerProfile } from '@/composables/useLecturerProfile'
import { useLecturerEducation } from '@/composables/useLecturerEducation'
import { useLecturerResearch } from '@/composables/useLecturerResearch'
import { useLecturerPublications } from '@/composables/useLecturerPublications'
import bgImage from '~/assets/background.png'

definePageMeta({
  layout: 'lecturer'
})

// Authentication
const { user } = useFirebaseAuth()

// Compute standardized photo URL with fallback
const photoURL = computed(() => {
  // Priority 1: User's photoURL from Firebase Auth
  if (user.value?.photoURL) {
    return user.value.photoURL
  }
  // Priority 2: Generate fallback avatar
  const displayName = user.value?.displayName || 'User'
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
})

// Handle image loading errors by falling back to generated avatar
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  const displayName = user.value?.displayName || 'User'
  const fallbackURL = `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
  
  // Only change if it's not already the fallback URL to prevent infinite loops
  if (img.src !== fallbackURL) {
    img.src = fallbackURL
  }
}

// Backend data composables
const { profile, isLoading: profileLoading, fetchProfile } = useLecturerProfile()
const { education, isLoading: educationLoading, fetchEducation } = useLecturerEducation()
const { researchAreas, isLoading: researchLoading, fetchResearchAreas } = useLecturerResearch()
const { publications, isLoading: publicationsLoading, fetchPublications } = useLecturerPublications()

// Initial loading state to prevent flash of "no data" states
const initialLoading = ref(true)

// Function to load all lecturer data
const loadLecturerData = async () => {
  try {
    await Promise.all([
      fetchProfile(),
      fetchEducation(),
      fetchResearchAreas(),
      fetchPublications(3) // Limit to 3 publications for dashboard
    ])
  } finally {
    // Set initial loading to false after all data fetches complete (or fail)
    initialLoading.value = false
  }
}

// Watch for user email and fetch data when available
watch(
  () => user.value?.email,
  (email) => {
    if (email) {
      loadLecturerData()
    }
  },
  { immediate: true }
)

// Also load data when component mounts (fallback)
onMounted(() => {
  if (user.value?.email) {
    loadLecturerData()
  }
})
</script>
