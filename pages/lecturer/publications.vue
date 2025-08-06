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
          <div class="relative flex-1 max-w-[8.5rem]">
            <select
              v-model="selectedYear"
              class="w-full h-9 px-3 rounded-md border border-gray-300 bg-white text-sm transition appearance-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="2023">2023</option>
              <option value="2022">2022</option>
              <option value="2021">2021</option>
              <option value="2020">2020</option>
            </select>
            <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
              <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </div>
          </div>
          <!-- Search -->
          <div class="relative flex-1">
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

    <!-- Publications by Year -->
    <div class="space-y-10 sm:space-y-12">
      <div v-for="year in filteredPublications" :key="year.year">
        <h2 class="text-xl sm:text-2xl font-bold mb-5 sm:mb-6">{{ year.year }}</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
          <div v-for="pub in year.publications" :key="pub.title" 
               class="bg-blue-50 rounded-lg sm:rounded-xl p-4 sm:p-6 flex flex-col justify-between shadow-sm sm:shadow-md hover:shadow-lg transition-all duration-200">
            <div>
              <p class="font-semibold text-base sm:text-lg text-blue-900 mb-2 sm:mb-3">{{ pub.title }}</p>
              <p class="text-sm sm:text-base text-gray-600 mb-2 sm:mb-3">{{ pub.venue }}</p>
              <div class="flex flex-wrap items-center gap-2 sm:gap-3">
                <span class="text-xs sm:text-sm text-gray-500">{{ pub.year }}</span>
                <span class="text-gray-400">•</span>
                <span class="text-xs sm:text-sm text-gray-500">{{ pub.authors }}</span>
              </div>
              <a v-if="pub.link" :href="pub.link" 
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
import { computed, ref } from 'vue';
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
const selectedYear = ref('2023')
const searchQuery = ref('')

// Filter publications based on selected year and search query
const filteredPublications = computed(() => {
  // First filter by year
  let filtered = groupedPublications.value.filter(yearGroup => 
    yearGroup.year <= parseInt(selectedYear.value)
  ).sort((a, b) => b.year - a.year) // Sort by year descending

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

// Static grouped publications for mockup
const groupedPublications = computed(() => [
  {
    year: 2023,
    publications: [
      { 
        title: 'Advanced Machine Learning Techniques in Educational Data Mining',
        authors: 'Chaising, S., Temdee, P., & Kumar, R.',
        venue: 'IEEE Transactions on Education, 66(2), 156-169',
        year: 2023,
        link: '#'
      },
      { 
        title: 'Blockchain-Based Framework for Secure Academic Credential Verification',
        authors: 'Chaising, S., & Temdee, P.',
        venue: 'Journal of Information Security and Applications, 45, 102-115',
        year: 2023,
        link: '#'
      }
    ]
  },
  {
    year: 2022,
    publications: [
      { 
        title: 'Classification Approach for Industry Standards Categorization',
        authors: 'Chaisricharoen, R., Srimaharaj, W., Chaising, S., & Pamanee, K.',
        venue: 'In 2022 Joint International Conference on Digital Arts, Media and Technology... (pp. 308-313). IEEE.',
        year: 2022,
        link: '#'
      },
      { 
        title: 'Deep Learning Applications in Educational Technology',
        authors: 'Chaising, S., Kumar, R., & Smith, J.',
        venue: 'Educational Technology Research and Development, 70(3), 789-805',
        year: 2022,
        link: '#'
      },
      { 
        title: 'Artificial Intelligence in Higher Education: A Systematic Review',
        authors: 'Chaising, S., & Johnson, M.',
        venue: 'International Journal of Educational Technology in Higher Education, 19(1), 1-25',
        year: 2022,
        link: '#'
      }
    ]
  },
  {
    year: 2021,
    publications: [
      { 
        title: 'Average weighted objective distance-based method for type 2 diabetes prediction',
        authors: 'Nuankaew, P., Chaising, S., & Temdee, P.',
        venue: 'IEEE Access, 9, 137015-137028.',
        year: 2021,
        link: '#'
      },
      { 
        title: 'Blockchain-based Trusty Buyer Coalition Scheme Using A Group Signature',
        authors: 'Boongsame, L., Chaising, S., & Temdee, P.',
        venue: 'Journal of Mobile Multimedia, 203-230.',
        year: 2021,
        link: '#'
      },
      { 
        title: 'Individual Attribute Selection Using Information Gain based Distance for Group Classification of Elderly People with Hypertension',
        authors: 'Chaising, S., Temdee, P., & Prasad, R.',
        venue: 'IEEE Access, 9, 82713-82725.',
        year: 2021,
        link: '#'
      }
    ]
  },
  {
    year: 2020,
    publications: [
      { 
        title: 'Machine Learning for Student Performance Prediction',
        authors: 'Chaising, S., & Wilson, K.',
        venue: 'Computers & Education, 155, 103912',
        year: 2020,
        link: '#'
      },
      { 
        title: 'Data Mining Techniques in Educational Research',
        authors: 'Chaising, S., Brown, A., & Davis, R.',
        venue: 'Journal of Educational Data Mining, 12(2), 45-67',
        year: 2020,
        link: '#'
      },
      { 
        title: 'Predictive Analytics in Higher Education',
        authors: 'Chaising, S., & Anderson, P.',
        venue: 'International Journal of Educational Technology, 7(4), 89-104',
        year: 2020,
        link: '#'
      }
    ]
  }
])
</script>
