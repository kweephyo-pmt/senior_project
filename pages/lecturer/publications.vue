<template>
  <div class="max-w-5xl mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header Section with Controls -->
    <div class="mb-8">
      <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-4 sm:mb-0">
        <div class="flex items-center">
          <button @click="goBack" class="mr-4 text-gray-600 hover:text-blue-600 focus:outline-none" aria-label="Back">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
          </button>
          <h1 class="text-3xl font-bold text-gray-900">Recent Publications</h1>
        </div>
        <div class="flex flex-col sm:flex-row sm:items-center sm:gap-4">
          <!-- Year Filter -->
          <div class="relative inline-block">
            <select
          class="w-full sm:w-auto appearance-none bg-white border-0  rounded-lg py-2 pl-4 pr-10 shadow-sm ring-2 ring-[#4697b9] text-sm"
        >    <option value="2023">Year/ 2023</option>
              <option value="2022">Year/ 2022</option>
              <option value="2021">Year/ 2021</option>
              <option value="2020">Year/ 2020</option>
            </select>
            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
              <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </div>
          </div>
          <!-- Search -->
          <div class="relative w-full sm:w-64">
            <input type="text" v-model="searchQuery" 
                   placeholder="Search..." 
                   class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-200 hover:border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <p class="text-gray-600">Welcome back, {{ user?.displayName || 'User' }}</p>
    </div>

    <!-- Publications by Year -->
    <div class="space-y-12">
      <div v-for="year in filteredPublications" :key="year.year">
        <h2 class="text-2xl font-bold mb-6">{{ year.year }}</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
          <div v-for="pub in year.publications" :key="pub.title" 
               class="bg-blue-50 rounded-lg sm:rounded-xl p-4 sm:p-6 flex flex-col justify-between shadow-md sm:shadow-xl hover:shadow-lg transition">
            <div>
              <p class="font-semibold text-blue-900 text-base mb-2">{{ pub.title }}</p>
              <p class="text-gray-600 text-sm mb-2">{{ pub.venue }}</p>
              <a v-if="pub.link" :href="pub.link" 
                 class="inline-block px-2 py-0.5 bg-blue-200 text-blue-800 rounded text-xs font-semibold mb-2">
                Link
              </a>
            </div>
            <div class="flex items-center gap-2 mt-4">
              <img :src="user?.photoURL ?? 'https://ui-avatars.com/api/?name=' + encodeURIComponent(user?.displayName || 'User')" 
                   :alt="user?.displayName ?? 'User'" 
                   class="w-7 h-7 rounded-full border border-blue-300" />
              <span class="text-sm text-gray-700 font-medium">{{ user?.displayName }}</span>
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
