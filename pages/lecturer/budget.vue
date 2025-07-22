<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="mb-8">
      <div class="flex items-center gap-12">
        <h1 class="text-2xl font-bold text-gray-900">Budget Management</h1>
        <div class="relative">
          <select
            class="appearance-none bg-white border-0 rounded-lg py-2 pl-4 pr-10 shadow-sm ring-2 ring-[#4697b9] text-sm w-44">
            <option>Year/ 2025</option>
            <option>Year/ 2024</option>
            <option>Year/ 2023</option>
          </select>
          <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
            <svg class="h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </div>
        </div>
      </div>
      <p class="text-gray-600 text-sm mt-2">Welcome back, {{ user?.displayName }}</p>
    </div>

    <!-- Budget Overview Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <!-- Total Budget -->
      <div class="bg-blue-50 rounded-lg shadow-md p-6">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Total Budget</p>
            <h3 class="text-2xl font-bold text-gray-900">฿ 125,000</h3>
            <p class="text-sm text-blue-50">s</p>
          </div>
          <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600" viewBox="0 0 24 24" fill="none">
              <text x="13" y="18" text-anchor="middle" font-size="18" font-family="Arial, Helvetica, sans-serif" fill="currentColor">฿</text>
            </svg>
          </div>
        </div>
      </div>

      <!-- Spent Amount -->
      <div class="bg-purple-50 rounded-lg shadow-md p-6">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Spent Amount</p>
            <h3 class="text-2xl font-bold text-gray-900">฿ 78,500</h3>
            <p class="text-sm text-gray-500">62.8% of total budget</p>
          </div>
          <div class="w-10 h-10 rounded-full bg-purple-100 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
            </svg>
          </div>
        </div>
      </div>

      <!-- Research Projects -->
      <div class="bg-orange-50 rounded-lg shadow-md p-6">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Research Projects</p>
            <h3 class="text-2xl font-bold text-gray-900">฿ 25,000</h3>
            <p class="text-sm text-gray-500">3 share projects</p>
          </div>
          <div class="w-10 h-10 rounded-full bg-orange-100 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-orange-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
            </svg>
          </div>
        </div>
      </div>
    </div>

    <!-- Budget Distribution and Details -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- Budget Distribution Chart -->
      <div class="lg:col-span-2 bg-white rounded-xl shadow-md p-8 mb-8 h-full">
        <h2 class="text-2xl font-semibold text-gray-900 mb-8">Budget Distribution</h2>
        
        <!-- Column Headers -->
        <div class="flex items-center mb-4">
          <div class="w-64"></div>
          <div class="w-32 text-right text-sm font-medium text-gray-600 ml-2">Spent/Received</div>
          <div class="flex-1 mx-6"></div>
        </div>

        <!-- Budget Items -->
        <div class="space-y-6">
          <div
            v-for="(item, index) in budgetItems"
            :key="index"
            class="flex items-center"
          >
            <div class="w-64 flex items-center gap-2 text-base text-gray-700">
              <!-- Colored Dot -->
              <span class="w-4 h-4 rounded-full inline-block mr-2" :style="{ background: item.color }"></span>
              <span>{{ item.name }}</span>
              <!-- Info Icon for Guest Speaker and Guest Lecturer -->
              <template v-if="item.name === 'Guest Speaker'">
                <span class="relative group ml-1">
                  <span class="w-5 h-5 flex items-center justify-center rounded-full bg-gray-200 text-xs font-bold text-gray-700 cursor-pointer">i</span>
                  <span class="absolute left-6 top-1/2 -translate-y-1/2 w-64 p-2 text-xs text-gray-800 bg-white border border-gray-300 rounded shadow-lg opacity-0 group-hover:opacity-100 transition-opacity z-10">
                    A professional invited to speak at a seminar, conference, or event.
                  </span>
                </span>
              </template>
              <template v-if="item.name === 'Guest Lecturer'">
                <span class="relative group ml-1">
                  <span class="w-5 h-5 flex items-center justify-center rounded-full bg-gray-200 text-xs font-bold text-gray-700 cursor-pointer">i</span>
                  <span class="absolute left-6 top-1/2 -translate-y-1/2 w-64 p-2 text-xs text-gray-800 bg-white border border-gray-300 rounded shadow-lg opacity-0 group-hover:opacity-100 transition-opacity z-10">
                    An expert invited to deliver lectures in an academic setting.
                  </span>
                </span>
              </template>
            </div>

            <!-- Amount Display (no label, just values) -->
            <div class="w-32 text-right text-sm font-normal text-gray-900 ml-2">
              ฿ {{ item.spent.toLocaleString() }} / ฿ {{ item.total.toLocaleString() }}
            </div>

            <!-- Progress Bar Container with Tooltip -->
            <div class="flex-1 mx-6 relative group">
              <!-- Special stacked bar for Self Development -->
              <template v-if="item.name === 'Self Development'">
                <div class="flex flex-col group relative">
                  <div class="w-full bg-gray-200 rounded-full h-3 overflow-hidden relative">
                    <!-- Main part (Spent) -->
                    <div
                      class="h-3 rounded-l-full transition-all duration-500 absolute left-0 top-0"
                      :style="{
                        width: (item.spent / item.total) * 100 + '%',
                        background: item.color,
                        zIndex: 1
                      }"
                    ></div>
                  </div>
                  <!-- Tooltip on hover -->
                  <span class="absolute -top-12 right-0 w-48 p-3 text-xs text-gray-800 bg-white border border-gray-300 rounded-lg shadow-xl opacity-0 group-hover:opacity-100 transition-opacity z-20 pointer-events-none">
                    <span class="font-bold">{{ item.name }}</span><br>
                    Spent: ฿ {{ item.spent.toLocaleString() }}<br>
                    Received: ฿ {{ item.total.toLocaleString() }}
                  </span>
                </div>
              </template>
              <template v-else>
                <!-- Standard progress bar -->
                <div class="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                  <div
                    class="h-3 rounded-full transition-all duration-500"
                    :style="{
                      width: (item.spent / item.total) * 100 + '%',
                      background: item.color,
                      minWidth: (item.spent / item.total) * 100 > 0 ? '0.5rem' : '0',
                    }"
                  ></div>
                </div>
                <!-- Tooltip on hover -->
                <span class="absolute -top-12 right-0 w-48 p-3 text-xs text-gray-800 bg-white border border-gray-300 rounded-lg shadow-xl opacity-0 group-hover:opacity-100 transition-opacity z-20 pointer-events-none">
                  <span class="font-bold">{{ item.name }}</span><br>
                  Spent: ฿ {{ item.spent.toLocaleString() }}<br>
                  Received: ฿ {{ item.total.toLocaleString() }}
                </span>
              </template>
            </div>
          </div>
        </div>
      </div>

      <!-- Budget Details -->
      <div class="lg:col-span-1">
        <div class="bg-white rounded-2xl shadow-lg p-5 h-full flex flex-col">
          <h2 class="text-xl font-semibold text-gray-900 mb-4">Budget Details</h2>
          <div class="space-y-3 overflow-y-scroll pr-2 h-[400px] custom-scrollbar">
            <div v-for="detail in budgetDetails" :key="detail.title"
                 class="p-4 bg-white rounded-xl shadow-md hover:shadow-lg transition-shadow border border-gray-100">
              <h3 class="text-base font-medium text-gray-900 mb-2">{{ detail.title }}</h3>

              <!-- Multiple owners with selector -->
              <template v-if="detail.owners">
                <div class="flex items-center justify-between text-sm text-gray-600 mb-2">
                  <div class="flex items-center">
                    <div class="relative">
                      <button @click="toggleOwnerSelect(detail.title)"
                              class="appearance-none text-gray-600 hover:text-gray-900 pr-5 focus:outline-none flex items-center">
                        {{ selectedOwners[detail.title] }}
                        <svg class="h-4 w-4 ml-1 text-gray-400"
                             viewBox="0 0 20 20" fill="currentColor">
                          <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                        </svg>
                      </button>
                      <!-- Dropdown menu -->
                      <div v-if="openDropdown === detail.title"
                           class="absolute z-10 mt-1 w-48 bg-white rounded-lg shadow-lg py-1 border border-gray-200">
                        <button v-for="owner in detail.owners" :key="owner"
                                @click="selectOwner(detail.title, owner)"
                                class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                          {{ owner }}
                        </button>
                      </div>
                    </div>
                  </div>
                  <span class="text-xs text-[#4cd964] font-medium">{{ detail.duration }}</span>
                </div>
              </template>

              <!-- Single owner -->
              <template v-else>
                <div class="flex justify-between items-center text-sm text-gray-600 mb-2">
                  <p class="text-gray-500">{{ detail.owner }}</p>
                  <span class="text-xs text-[#4cd964] font-medium">{{ detail.duration }}</span>
                </div>
              </template>

              <div class="mt-3 pt-2 border-t border-gray-100">
                <div class="flex items-center">
                  <!-- Color bullet with category tooltip -->
                  <span class="relative group inline-block">
                    <span 
                      class="w-3 h-3 rounded-full inline-block mr-2" 
                      :style="{ background: getCategoryColor(detail.category) }">
                    </span>
                    <!-- Tooltip for category -->
                    <span class="absolute left-0 -top-8 w-max p-2 text-xs text-gray-800 bg-white border border-gray-300 rounded shadow-lg opacity-0 group-hover:opacity-100 transition-opacity z-20 pointer-events-none">
                      {{ detail.category }}
                    </span>
                  </span>
                  <p class="text-gray-900 font-semibold text-base">
                    Budget: ฿ {{ detail.budget.toLocaleString() }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

const { user, logout } = useFirebaseAuth()

const selectedYear = ref('2025')
const openDropdown = ref('')
interface ProjectOwners {
  [key: string]: string;
}

const selectedOwners = ref<ProjectOwners>({
  'SoM Project': 'Dr. Korawit Fakkhong'
})

function toggleOwnerSelect(projectTitle: string) {
  openDropdown.value = openDropdown.value === projectTitle ? '' : projectTitle
}

function selectOwner(projectTitle: string, owner: string) {
  selectedOwners.value[projectTitle] = owner
  openDropdown.value = ''
}

// Function to get category color based on category name
function getCategoryColor(category: string): string {
  const categoryColors: { [key: string]: string } = {
    'Guest Speaker': '#10B981',
    'Guest Lecturer': '#F59E0B',
    'Research Project': '#8B5CF6',
    'Self Development': '#3B82F6',
    'Academic Service Project': '#EC4899',
    'Student Activity': '#EF4444'
  }
  return categoryColors[category] || '#9CA3AF' // Default gray if category not found
}

definePageMeta({
  layout: 'lecturer'
})

const budgetItems = ref([
  { name: 'Self Development', spent: 6400, total: 10000, color: '#3B82F6' },
  { name: 'Academic Service Project', spent: 14112, total: 42000, color: '#EC4899' },
  { name: 'Research Project', spent: 5472, total: 18000, color: '#8B5CF6' },
  { name: 'Guest Speaker', spent: 1800, total: 15000, color: '#10B981' },
  { name: 'Guest Lecturer', spent: 1800, total: 15000, color: '#F59E0B' },
  { name: 'Student Activity', spent: 1800, total: 15000, color: '#EF4444' }
]);

const budgetDetails = [
  {
    title: 'Guest Speaker 130S305',
    owner: 'Dr. Supansa Chaising',
    budget: 12000,
    duration: '6 Month',
    category: 'Guest Speaker'
  },
  {
    title: 'SoM Project',
    owners: [
      'Dr. Korawit Fakkhong',
      'Dr. Supansa Chaising',
      'Dr. John Smith'
    ],
    budget: 8000,
    duration: '6 Month',
    category: 'Research Project'
  },
  {
    title: 'Guest Lecturer 130S305',
    owner: 'Dr. Supansa Chaising',
    budget: 5000,
    duration: '6 Month',
    category: 'Guest Lecturer'
  },
]
</script>

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: #d1d5db;
  border-radius: 3px;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: #9ca3af;
}
</style>