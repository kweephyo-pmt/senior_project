<template>
    <div class="px-4 sm:px-6 lg:px-8 py-6 sm:py-8">
    <!-- Header Section with Controls -->
    <div class="mb-6 sm:mb-8">
      <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div class="flex flex-row items-center mb-2 sm:mb-0">
          <button @click="goBack" class="mr-2 sm:mr-4 text-gray-600 hover:text-blue-600 focus:outline-none" aria-label="Back">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
          </button>
          <h1 class="text-2xl sm:text-3xl font-bold text-gray-900">Recent Publications</h1>
        </div>
        <!-- Controls Row: Year + Search -->
        <div class="flex flex-row gap-2 w-full sm:w-auto">
          <!-- Year Filter -->
          <div class="relative w-[8.5rem] flex-shrink-0">
            <select
              v-model="selectedYear"
              class="w-full h-9 px-3 rounded-md border border-gray-300 bg-white text-sm transition appearance-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="">All Years</option>
              <option value="2025">2025</option>
              <option value="2024">2024</option>
              <option value="2023">2023</option>
              <option value="2022">2022</option>
              <option value="2021">2021</option>
            </select>
            <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
              <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </div>
          </div>
          <!-- Search -->
          <div class="relative flex-1 min-w-[200px]">
            <input 
              type="text" 
              v-model="searchQuery" 
              placeholder="Search publications..."
              class="w-full h-9 pl-9 pr-3 rounded-md border border-gray-300 text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition"
            >
            <div class="absolute inset-y-0 left-0 pl-2 flex items-center pointer-events-none">
              <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <p class="mt-2 text-sm sm:text-base text-gray-600">Welcome back, {{ user?.displayName || 'User' }}</p>
    </div>

    <!-- Loading State -->
    <div v-if="isLoading" class="space-y-10 sm:space-y-12">
      <div v-for="i in 3" :key="i">
        <div class="h-8 bg-gray-200 rounded w-20 mb-5 sm:mb-6 animate-pulse"></div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
          <div v-for="j in 2" :key="j" class="bg-gray-100 rounded-lg sm:rounded-xl p-4 sm:p-6 animate-pulse">
            <div class="h-6 bg-gray-200 rounded mb-3"></div>
            <div class="h-4 bg-gray-200 rounded mb-3"></div>
            <div class="h-4 bg-gray-200 rounded w-3/4 mb-3"></div>
            <div class="h-8 bg-gray-200 rounded w-16 mb-4"></div>
            <div class="flex items-center gap-3">
              <div class="w-8 h-8 bg-gray-200 rounded-full"></div>
              <div class="h-4 bg-gray-200 rounded w-24"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="text-center py-12">
      <div class="text-red-600 mb-4">
        <svg class="w-12 h-12 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <p class="text-lg font-medium">Error loading publications</p>
        <p class="text-sm text-gray-600 mt-2">{{ error }}</p>
      </div>
      <button @click="fetchPublications()" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition">
        Try Again
      </button>
    </div>

    <!-- No Data State -->
    <div v-else-if="!isLoading && !isInitialLoad && filteredPublications.length === 0" class="text-center py-12">
      <div class="text-gray-500">
        <svg class="w-12 h-12 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
        <p class="text-lg font-medium">No publications found</p>
        <p class="text-sm text-gray-600 mt-2">Publications will appear here once they are added to your profile.</p>
      </div>
    </div>

    <!-- Publications by Year -->
    <div v-else-if="!isLoading && filteredPublications.length > 0" class="space-y-10 sm:space-y-12">
      <div v-for="year in filteredPublications" :key="year.year">
        <h2 class="text-xl sm:text-2xl font-bold mb-5 sm:mb-6">{{ year.year }}</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
          <div v-for="pub in year.publications" :key="pub.id" 
               class="bg-blue-50 rounded-lg sm:rounded-xl p-4 sm:p-6 flex flex-col justify-between shadow-sm sm:shadow-md hover:shadow-lg transition-all duration-200">
            <div>
              <p class="font-semibold text-base sm:text-lg text-blue-900 mb-2 sm:mb-3">{{ pub.title }}</p>
              <p class="text-sm sm:text-base text-gray-600 mb-2 sm:mb-3">{{ pub.venue }}</p>
              <div class="flex flex-wrap items-center gap-2 sm:gap-3">
                <span class="text-xs sm:text-sm text-gray-500">{{ pub.year }}</span>
                <span class="text-gray-400">•</span>
                <span class="text-xs sm:text-sm text-gray-500">{{ pub.authors }}</span>
              </div>
              <a v-if="pub.link && pub.link !== '#'" :href="pub.link.startsWith('http') ? pub.link : `https://${pub.link}`" target="_blank" rel="noopener noreferrer"
                 class="inline-flex items-center px-3 py-1.5 sm:py-2 bg-blue-200 text-blue-800 rounded text-xs sm:text-sm font-semibold mt-2 sm:mt-3">
                <svg class="w-4 h-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
                Link
              </a>
            </div>
            <div class="flex items-center gap-3 mt-4 sm:mt-5">
              <img :src="user?.photoURL ?? 'https://ui-avatars.com/api/?name=' + encodeURIComponent(user?.displayName || 'User')" 
                   :alt="user?.displayName ?? 'User'" 
                   class="w-8 h-8 rounded-full border border-blue-300" />
              <span class="text-sm sm:text-base text-gray-700 font-medium">{{ user?.displayName }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useFirebaseAuth } from '@/composables/useFirebaseAuth';
import { useLecturerPublications } from '@/composables/useLecturerPublications';
import { computed, ref, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

// Function to handle back navigation
const goBack = () => {
  router.go(-1); // Go back to the previous page
};

definePageMeta({
  layout: 'lecturer'
})

const { user } = useFirebaseAuth()
const { publications, isLoading, error, fetchPublications } = useLecturerPublications()
const selectedYear = ref('')
const searchQuery = ref('')
const isInitialLoad = ref(true)

// Year to evaluateid mapping
const yearToEvaluateids: { [key: string]: number[] } = {
  '2025': [9], // 1/2025
  '2024': [7, 8], // 1/2024, 2/2024
  '2023': [5, 6], // 1/2023, 2/2023
  '2022': [3, 4], // 1/2022, 2/2022
  '2021': [1, 2], // 1/2021, 2/2021
}

// Load publications when component mounts or user changes
const loadPublications = async () => {
  if (!user.value?.email) return
  
  if (selectedYear.value) {
    // Fetch publications for specific year's evaluation periods
    const evaluateids = yearToEvaluateids[selectedYear.value]
    if (evaluateids) {
      // For multiple evaluateids, we'll fetch all and filter client-side
      // since API only supports single evaluateid
      await fetchPublications()
    }
  } else {
    // Fetch all publications
    await fetchPublications()
  }
  
  isInitialLoad.value = false
}

onMounted(() => {
  loadPublications()
})

watch(() => user.value?.email, (newEmail) => {
  if (newEmail) {
    loadPublications()
  }
}, { immediate: true })

// Watch for year changes and refetch data
watch(selectedYear, async () => {
  if (user.value?.email) {
    await loadPublications()
  }
})

// Group publications by year
const groupedPublications = computed(() => {
  const groups: { [year: number]: any[] } = {}
  
  publications.value.forEach(pub => {
    if (!groups[pub.year]) {
      groups[pub.year] = []
    }
    groups[pub.year].push(pub)
  })
  
  return Object.keys(groups)
    .map(year => ({
      year: parseInt(year),
      publications: groups[parseInt(year)]
    }))
    .sort((a, b) => b.year - a.year)
})

// Filter publications based on selected year and search query
const filteredPublications = computed(() => {
  // First filter by year and evaluateid
  let filtered = selectedYear.value ? 
    groupedPublications.value.filter(yearGroup => {
      const yearStr = selectedYear.value
      const evaluateids = yearToEvaluateids[yearStr]
      if (!evaluateids) return false
      
      // Check if any publication in this year group has matching evaluateid
      return yearGroup.publications.some(pub => evaluateids.includes(pub.evaluateid))
    }).map(yearGroup => ({
      year: yearGroup.year,
      publications: yearGroup.publications.filter(pub => {
        const yearStr = selectedYear.value
        const evaluateids = yearToEvaluateids[yearStr]
        return evaluateids && evaluateids.includes(pub.evaluateid)
      })
    })) : 
    groupedPublications.value
  
  filtered = filtered.sort((a, b) => b.year - a.year) // Sort by year descending

  // Then filter by search query if exists
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.map(yearGroup => ({
      year: yearGroup.year,
      publications: yearGroup.publications.filter(pub => 
        pub.title.toLowerCase().includes(query) ||
        pub.authors.toLowerCase().includes(query) ||
        pub.venue.toLowerCase().includes(query)
      )
    })).filter(group => group.publications.length > 0)
  }

  return filtered
})
</script>
