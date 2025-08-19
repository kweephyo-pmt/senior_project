<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header -->
    <div class="mb-8">
      <div class="flex flex-col sm:flex-row sm:items-center gap-4 sm:gap-12 mb-4 sm:mb-0">
        <h1 class="text-2xl font-bold text-gray-900">Budget Management</h1>
        <!-- Evaluation Period Selector -->
      <div class="relative w-full sm:w-48 lg:w-auto">
        <select
          v-model="selectedEvaluationPeriod"
          @change="onEvaluationPeriodChange"
          class="w-full appearance-none bg-white border-0 rounded-lg py-2.5 pl-3 pr-8 shadow-sm ring-2 ring-[#4697b9] text-xs sm:text-sm focus:outline-none focus:ring-2 focus:ring-[#4697b9]"
          :disabled="isLoadingPeriods"
        >
          <option v-if="isLoadingPeriods" disabled>Loading periods...</option>
          <option 
            v-for="period in evaluationPeriods" 
            :key="period.evaluateid" 
            :value="period.evaluateid"
          >
            Round {{ period.evaluatename }}
          </option>
        </select>
        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-500">
          <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </div>
      </div>
      </div>
      <p class="text-gray-600 text-sm mt-2">Welcome back, {{ user?.displayName }}</p>
    </div>

    <!-- Budget Overview Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 mb-6 sm:mb-8">
      <!-- Loading State for Cards -->
      <template v-if="loading">
        <div v-for="i in 3" :key="i" class="bg-gray-50 rounded-lg shadow-md p-6 animate-pulse">
          <div class="flex items-center justify-between">
            <div class="flex-1">
              <div class="h-4 bg-gray-200 rounded w-24 mb-2"></div>
              <div class="h-8 bg-gray-200 rounded w-32 mb-1"></div>
              <div class="h-3 bg-gray-200 rounded w-20"></div>
            </div>
            <div class="w-10 h-10 rounded-full bg-gray-200"></div>
          </div>
        </div>
      </template>
      
      <!-- Actual Cards -->
      <template v-else>
        <!-- Total Budget -->
        <div class="bg-blue-50 rounded-lg shadow-md p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm text-gray-600">Total Budget</p>
              <h3 class="text-2xl font-bold text-gray-900">฿ {{ totalBudget.toLocaleString() }}</h3>
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
              <h3 class="text-2xl font-bold text-gray-900">฿ {{ budgetOverview?.totalSpent?.toLocaleString() }}</h3>
              <p class="text-sm text-gray-500">{{ budgetOverview?.spentPercentage }}% of total budget</p>
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
              <h3 class="text-2xl font-bold text-gray-900">฿ {{ budgetOverview?.researchAmount?.toLocaleString() }}</h3>
              <p class="text-sm text-gray-500">{{ budgetOverview?.researchProjectCount }} share projects</p>
            </div>
            <div class="w-10 h-10 rounded-full bg-orange-100 flex items-center justify-center">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-orange-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
              </svg>
            </div>
          </div>
        </div>
      </template>
    </div>

    <!-- Budget Distribution and Details -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Budget Distribution Chart -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-6 sm:p-8 mb-6 sm:mb-8 h-full">
        <h2 class="text-2xl font-semibold text-gray-900 mb-8">Budget Distribution</h2>
        
        <!-- Column Headers -->
        <div class="flex items-center mb-4">
          <div class="flex-1 min-w-0">
            <div class="text-sm font-medium text-gray-600">Budget Item</div>
          </div>
          <div class="w-32 text-right text-sm font-medium text-gray-600">Spent/Received</div>
          <div class="flex-1 mx-4"></div>
        </div>

        <!-- Budget Items -->
        <!-- Loading State for Budget Items -->
        <div v-if="loading" class="space-y-6">
          <div v-for="i in 6" :key="i" class="flex items-center animate-pulse">
            <div class="w-64 flex items-center gap-2">
              <div class="w-4 h-4 rounded-full bg-gray-200"></div>
              <div class="h-4 bg-gray-200 rounded w-32"></div>
            </div>
            <div class="w-32">
              <div class="h-4 bg-gray-200 rounded w-24"></div>
            </div>
            <div class="flex-1 mx-6">
              <div class="w-full bg-gray-200 rounded-full h-3"></div>
            </div>
          </div>
        </div>
        
        <!-- Actual Budget Items -->
        <div class="space-y-6" v-else-if="budgetItems.length > 0">
          <div
            v-for="(item, index) in budgetItems"
            :key="index"
            class="flex items-center space-x-4"
          >
            <div class="flex-1 min-w-0 flex items-center gap-2 text-base text-gray-700">
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
      <div class="lg:col-span-1 h-full">
        <div class="bg-white rounded-xl shadow-xl p-6 h-full flex flex-col">
          <h2 class="text-xl font-semibold text-gray-900 mb-4">Budget Details</h2>
          <!-- Loading State for Budget Details -->
          <div v-if="loading" class="space-y-3 h-[400px]">
            <div v-for="i in 4" :key="i" class="p-4 bg-gray-50 rounded-xl animate-pulse">
              <div class="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
              <div class="h-3 bg-gray-200 rounded w-1/2 mb-2"></div>
              <div class="h-3 bg-gray-200 rounded w-1/3"></div>
            </div>
          </div>
          
          <!-- Actual Budget Details -->
          <div v-else-if="budgetDetails.length > 0" class="space-y-3 overflow-y-scroll pr-2 h-[400px] custom-scrollbar">
            <div v-for="detail in budgetDetails" :key="detail.title"
                 class="p-4">
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
                    Budget: ฿ {{ detail.budget?.toLocaleString() }}
                  </p>
                </div>
              </div>
            </div>
          </div>
          
          <!-- No Data State for Budget Details -->
          <div v-else class="flex-1 flex items-center justify-center">
            <div class="text-center">
              <div class="text-gray-400 mb-2">
                <svg class="mx-auto h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
              <p class="text-gray-500 text-sm">No budget projects found</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch } from 'vue';
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useBudget } from '@/composables/useBudget'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'

const { user } = useFirebaseAuth()
const { extractStaffCode, getBudgetOverview, getBudgetProjects } = useBudget()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()

interface ProjectOwners {
  [key: string]: string;
}

const selectedOwners = ref<ProjectOwners>({})

// Reactive data from database
const budgetOverview = ref<any>(null)
const budgetProjects = ref<any[]>([])
const loading = ref(true)
const selectedYear = ref(2025)
const selectedEvaluationPeriod = ref<number | null>(null)
const openDropdown = ref('')

// Extract staff code from user email
const staffCode = computed(() => {
  if (!user.value?.email) return ''
  return extractStaffCode(user.value.email)
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

// Computed properties for reactive data
const budgetItems = computed(() => {
  return budgetOverview.value?.categories || []
})

const budgetDetails = computed(() => {
  return budgetProjects.value || []
})

const totalBudget = computed(() => {
  return budgetOverview.value?.totalBudget || 0
})

const spentAmount = computed(() => {
  return budgetOverview.value?.totalSpent || 0
})

const spentPercentage = computed(() => {
  return budgetOverview.value?.spentPercentage || 0
})

const researchAmount = computed(() => {
  return budgetOverview.value?.researchAmount || 0
})

const researchProjectCount = computed(() => {
  return budgetOverview.value?.researchProjectCount || 0
})

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (selectedEvaluationPeriod.value && user.value?.email) {
    await loadBudgetData()
  }
}

// Load data from database
const loadBudgetData = async () => {
  const currentStaffCode = staffCode.value
  if (!currentStaffCode) {
    console.log('No staff code available yet')
    return
  }
  
  try {
    loading.value = true
    const evaluateId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    console.log('Budget loadBudgetData - selectedEvaluationPeriod:', selectedEvaluationPeriod.value)
    console.log('Budget loadBudgetData - activeEvaluationPeriod:', activeEvaluationPeriod.value?.evaluateid)
    console.log('Budget loadBudgetData - final evaluateId:', evaluateId)
    const [overview, projects] = await Promise.all([
      getBudgetOverview(currentStaffCode, evaluateId),
      getBudgetProjects(currentStaffCode, evaluateId)
    ])
    budgetOverview.value = overview
    budgetProjects.value = projects as any[]
    
    // Set default selected owners (primary owners) for projects with multiple owners
    const defaultOwners: ProjectOwners = {}
    const typedProjects = projects as any[]
    typedProjects.forEach((project: any) => {
      if (project.owners && project.owners.length > 1) {
        // Set primary owner as default (first in the list is primary)
        defaultOwners[project.title] = project.owner || project.owners[0]
      }
    })
    selectedOwners.value = defaultOwners
    
  } catch (error) {
    console.error('Error loading budget data:', error)
    // Provide fallback mock data if API fails
    budgetOverview.value = {
      totalBudget: 0,
      totalSpent: 0,
      spentPercentage: 0,
      researchAmount: 0,
      researchProjectCount: 0,
      categories: []
    }
    budgetProjects.value = []
    selectedOwners.value = {}
  } finally {
    loading.value = false
  }
}

// Watch for user authentication and load data
watch(
  () => user.value?.email,
  async (email) => {
    if (email) {
      await fetchEvaluationPeriods()
      if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
        selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
      }
      await loadBudgetData()
    }
  },
  { immediate: true }
)

// Load data on component mount
onMounted(async () => {
  if (user.value?.email) {
    await fetchEvaluationPeriods()
    if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
      selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
    }
    await loadBudgetData()
  }
})
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