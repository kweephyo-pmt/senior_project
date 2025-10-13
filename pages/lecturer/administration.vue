<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">
          Domain 4: Administration Performance
        </h1>
        <p class="text-sm sm:text-base text-gray-600">Welcome back, {{ user?.displayName }}</p>
      </div>
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

    <!-- Dynamic Track Title -->
    <div class="mb-6">
      <h2 class="text-center text-lg font-medium text-gray-700 mb-1">
        <span v-if="loading || kpiLoading || !kpiWeights">Loading...</span>
        <span v-else>{{ kpiWeights.domainScoreName }} Track</span>
      </h2>
      <p class="text-center text-sm text-gray-500 mb-4">
        <span v-if="loading || isLoadingPeriods">Loading...</span>
        <span v-else>{{ formatDateRange() }}</span>
      </p>
    </div>

     <!-- Loading spinner -->
     <div v-if="loading" class="flex justify-center items-center py-8">
       <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
       <p class="ml-3 text-sm text-gray-600">Loading KPI data...</p>
     </div>

    <!-- Error message for MFU API -->
    <div v-if="chartError && !loading" class="mb-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <h3 class="text-sm font-medium text-yellow-800">MFU API Connection Issue</h3>
          <div class="mt-2 text-sm text-yellow-700">
            <p>{{ chartError }}</p>
            <p class="mt-1">Showing sample data instead. Please try refreshing the page.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- KPI Categories with NuxtLink, only when not loading -->
    <div v-if="!loading && kpiWeights" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3 sm:gap-4 mb-6 sm:mb-8">
      <NuxtLink
        to="/lecturer/teaching-performance"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/teaching-performance'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">
          {{ getDomainCategoryName('domain1') }} ({{ getDomainWeight('domain1') }}%)
        </p>
        <p class="text-xl font-bold text-inherit">{{ getDomainScore('domain1') }}%</p>
      </NuxtLink>

      <NuxtLink
        to="/lecturer/research-performance"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/research-performance'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">
          {{ getDomainCategoryName('domain2') }} ({{ getDomainWeight('domain2') }}%)
        </p>
        <p class="text-xl font-bold text-inherit">{{ getDomainScore('domain2') }}%</p>
      </NuxtLink>

      <NuxtLink
        to="/lecturer/academic-performance"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/academic-performance'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">
          {{ getDomainCategoryName('domain3') }} ({{ getDomainWeight('domain3') }}%)
        </p>
        <p class="text-xl font-bold text-inherit">{{ getDomainScore('domain3') }}%</p>
      </NuxtLink>

      <NuxtLink
        to="/lecturer/administration"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/administration'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">
          {{ getDomainCategoryName('domain4') }} ({{ getDomainWeight('domain4') }}%)
        </p>
        <p class="text-xl font-bold text-inherit">{{ getDomainScore('domain4') }}%</p>
      </NuxtLink>

      <NuxtLink
        to="/lecturer/arts-culture"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/arts-culture'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">
          {{ getDomainCategoryName('domain5') }} ({{ getDomainWeight('domain5') }}%)
        </p>
        <p class="text-xl font-bold text-inherit">{{ getDomainScore('domain5') }}%</p>
      </NuxtLink>
    </div>

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Administration Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 text-center">
          Administration Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold ({{ getDomainThreshold('domain4') }}) - Earned score ({{ getDomainScore('domain4') }})
        </p>
        <!-- Performance Chart -->
        <div class="h-[300px] sm:h-[400px] mb-4 sm:mb-6">
          <div v-if="isLoadingChart" class="flex justify-center items-center h-full">
            <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
            <p class="ml-3 text-sm text-gray-600">Loading chart data...</p>
          </div>
          <canvas v-else ref="administrationChart"></canvas>
        </div>
      </div>

      <!-- Tables stacked vertically in a card column -->
      <div class="flex flex-col gap-6">
        <!-- Curricular Committee Table -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Curricular Committee</h2>
          <div v-if="!curricularCommitteeData || curricularCommitteeData.length === 0" class="text-center py-4 text-sm text-gray-500">
            No member found
          </div>
          <div v-else class="max-h-[200px] overflow-y-auto">
            <table class="min-w-full divide-y divide-gray-200 text-xs sm:text-sm">
              <thead class="bg-[#0e7490] sticky top-0 z-10">
                <tr>
                  <th class="px-2 py-2 text-center text-xs font-medium text-white uppercase tracking-wider">No.</th>
                  <th class="px-2 py-2 text-center text-xs font-medium text-white uppercase tracking-wider">Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(item, index) in curricularCommitteeData" :key="index">
                  <td class="px-2 py-2 whitespace-nowrap text-gray-900">{{ index + 1 }}.</td>
                  <td class="px-2 py-2 whitespace-normal text-gray-900">{{ item.nameofcommittee || item.committee_name || item.name }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- School Committee Table -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">School Committee</h2>
          <div v-if="!schoolCommitteeData || schoolCommitteeData.filter(item => item && (item.nameofcommittee || item.committee_name || item.name)).length === 0" class="text-center py-4 text-sm text-gray-500">
            No member found
          </div>
          <div v-else class="max-h-[200px] overflow-y-auto">
            <table class="min-w-full divide-y divide-gray-200 text-xs sm:text-sm">
              <thead class="bg-[#0e7490] sticky top-0 z-10">
                <tr>
                  <th class="px-2 py-2 text-center text-xs font-medium text-white uppercase tracking-wider">No.</th>
                  <th class="px-2 py-2 text-center text-xs font-medium text-white uppercase tracking-wider">Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(item, index) in schoolCommitteeData.filter(item => item && (item.nameofcommittee || item.committee_name || item.name))" :key="index">
                  <td class="px-2 py-2 whitespace-nowrap text-gray-900">{{ index + 1 }}.</td>
                  <td class="px-2 py-2 whitespace-normal text-gray-900">{{ item.nameofcommittee || item.committee_name || item.name }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useMfuAdministrationApi } from '@/composables/useMfuAdministrationApi'
import { useMfuKpiApi } from '@/composables/useMfuKpiApi'
import Chart from 'chart.js/auto'
import ChartDataLabels from 'chartjs-plugin-datalabels'
import { computed, onMounted, ref, watch } from 'vue'

definePageMeta({
  layout: 'lecturer'
})

// Refs
const administrationChart = ref<HTMLCanvasElement | null>(null)
const showMobileMenu = ref(false)
const loading = ref(true)
const isLoadingChart = ref(true)
const chartError = ref('')

// Composable hooks
const { user } = useFirebaseAuth()
const { evaluationPeriods, loading: isLoadingPeriods, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()
const { kpiData: mfuKpiData, isLoading: kpiLoading, fetchKpiPercentages } = useMfuKpiApi()
const {
  isLoading: isAdminApiLoading,
  error: adminApiError,
  getAcademicAdministration,
  getGuestLecturerCoordination,
  getCourseCoordination,
  getUniversityCommittee,
  getSchoolCommittee,
  getSchoolCommitteeList,
  getCurricularCommittee,
  getAdministrativeDuty,
  getAllAdministrationData
} = useMfuAdministrationApi()

// Data refs
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
let chartInstance: Chart | null = null

// Administration data refs
const academicAdministrationData = ref<any[]>([])
const guestLecturerData = ref<any[]>([])
const courseCoordinationData = ref<any[]>([])
const universityCommitteeData = ref<any[]>([])
const schoolCommitteeData = ref<any[]>([])
const schoolCommitteeListData = ref<any[]>([])
const curricularCommitteeData = ref<any[]>([])
const administrativeDutyData = ref<any[]>([])

// Format value helper
const formatValue = (value: any) => {
  if (value === null || value === undefined) return '0';
  if (typeof value === 'number') return Math.round(value * 100) / 100;
  if (typeof value === 'string') {
    const num = parseFloat(value);
    return isNaN(num) ? '0' : Math.round(num * 100) / 100;
  }
  return '0';
}

// KPI weights computed from MFU API
const kpiWeights = computed(() => {
  if (mfuKpiData.value) {
    return {
      domainScoreName: mfuKpiData.value.domainScoreName || 'Administration',
      domainWeights: mfuKpiData.value.domainWeights || {},
      domainScores: mfuKpiData.value.domainScores || {},
      domainThresholds: mfuKpiData.value.domainThresholds || {}
    }
  }
  return null
})

// Helper functions to get domain data
const getDomainWeight = (domain: string) => kpiWeights.value?.domainWeights?.[domain] || 0
const getDomainScore = (domain: string) => kpiWeights.value?.domainScores?.[domain] || 0
const getDomainThreshold = (domain: string) => kpiWeights.value?.domainThresholds?.[domain] || 0

const getDomainCategoryName = (domain: string) => {
  const domainNames = {
    'domain1': 'Teaching',
    'domain2': 'Research',
    'domain3': 'Academic Service',
    'domain4': 'Administration',
    'domain5': 'Arts and Culture'
  }
  return domainNames[domain as keyof typeof domainNames] || domain
}

// Load KPI data from MFU API
const loadKpiData = async () => {
  try {
    loading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      await fetchKpiPercentages(user.value.email, evalId)
      kpiData.value = mfuKpiData.value
    }
  } catch (err) {
    // Error handled silently
  } finally {
    loading.value = false
  }
}

// Load all administration data
const loadAdministrationData = async () => {
  if (!user.value?.email) return

  try {
    loading.value = true
    isLoadingChart.value = true
    chartError.value = ''

    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9

    const result = await getAllAdministrationData(user.value.email, evalId.toString())

    if (result) {
      // Update the data refs with the response data
      // Handle both array and single object responses
      academicAdministrationData.value = Array.isArray(result.academicAdministration) ? result.academicAdministration : [result.academicAdministration].filter(Boolean)
      guestLecturerData.value = Array.isArray(result.guestLecturer) ? result.guestLecturer : [result.guestLecturer].filter(Boolean)
      courseCoordinationData.value = Array.isArray(result.courseCoordination) ? result.courseCoordination : [result.courseCoordination].filter(Boolean)
      universityCommitteeData.value = Array.isArray(result.universityCommittee) ? result.universityCommittee : [result.universityCommittee].filter(Boolean)
      schoolCommitteeData.value = Array.isArray(result.schoolCommittee) ? result.schoolCommittee : [result.schoolCommittee].filter(Boolean)
      schoolCommitteeListData.value = Array.isArray(result.schoolCommitteeList) ? result.schoolCommitteeList : [result.schoolCommitteeList].filter(Boolean)
      curricularCommitteeData.value = Array.isArray(result.curricularCommittee) ? result.curricularCommittee : [result.curricularCommittee].filter(Boolean)
      administrativeDutyData.value = Array.isArray(result.administrativeDuty) ? result.administrativeDuty : [result.administrativeDuty].filter(Boolean)

      // Initialize the chart with the new data
      initializeChart()
    } else {
      throw new Error('No data returned from API')
    }
  } catch (err) {
    chartError.value = 'Failed to load administration data. Please try again later.'

    // Reset data on error
    academicAdministrationData.value = []
    guestLecturerData.value = []
    courseCoordinationData.value = []
    universityCommitteeData.value = []
    schoolCommitteeData.value = []
    schoolCommitteeListData.value = []
    curricularCommitteeData.value = []
    administrativeDutyData.value = []
  } finally {
    loading.value = false
    isLoadingChart.value = false
  }
}

// Initialize chart with data
const initializeChart = () => {
  if (!administrationChart.value) return

  // Destroy existing chart
  if (chartInstance) {
    chartInstance.destroy()
  }

      // Helper function to get the score from a data array, handling different possible field names
    const getScore = (dataArray: any[]) => {
      if (!dataArray || dataArray.length === 0) return 0
      const item = dataArray[0]
      // Try different possible field names for score
      return item?.sumscore || item?.score || item?.rawscore || 0
    }

    const chartData = {
      labels: [
        ['Academic Administration', 'assigned by School/University'],
        'Coordination with a Guest Lecturer',
        'Course Coordination',
        'University\'s Committee',
        'School\'s Committee',
        'School Committee',
        'Curricular Committee',
        ['Administrative Duty', 'Assigned by School']
      ],
      datasets: [{
        label: 'Score',
        data: [
          // Academic Administration
          getScore(academicAdministrationData.value),
          // Guest Lecturer
          getScore(guestLecturerData.value),
          // Course Coordination
          getScore(courseCoordinationData.value),
          // University Committee
          getScore(universityCommitteeData.value),
          // School Committee
          getScore(schoolCommitteeData.value),
          // School Committee List
          getScore(schoolCommitteeListData.value),
          // Curricular Committee
          getScore(curricularCommitteeData.value),
          // Administrative Duty
          getScore(administrativeDutyData.value)
        ],
      backgroundColor: '#172554',
      borderWidth: 0,
      borderRadius: 0,
    }]
  }

  chartInstance = new Chart(administrationChart.value, {
    type: 'bar',
    data: chartData,
    options: {
      indexAxis: 'y',
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        datalabels: {
          anchor: 'end',
          align: 'end',
          color: '#6B7280',
          font: {
            size: 12,
            weight: 'bold'
          },
          offset: 4
        }
      },
      scales: {
        x: {
          beginAtZero: true,
          max: 180,
          grid: { color: '#f0f0f0' },
          ticks: { font: { size: 12 } },
          title: {
            display: true,
            text: 'Raw Score',
            font: {
              size: 14,
              weight: 'bold'
            }
          }
        },
        y: {
          grid: { display: false },
          ticks: { font: { size: 12 } }
        }
      }
    },
    plugins: [ChartDataLabels]
  })
}

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (user.value?.email && selectedEvaluationPeriod.value) {
    await Promise.all([
      loadKpiData(),
      loadAdministrationData()
    ])
  }
}

// Format date range for evaluation period
const formatDateRange = () => {
  const currentPeriod = evaluationPeriods.value.find(p => p.evaluateid === selectedEvaluationPeriod.value)
  if (!currentPeriod) return 'Loading...'

  const startDate = new Date(currentPeriod.evaluatestartdate)
  const endDate = new Date(currentPeriod.evaluateenddate)

  const formatDate = (date: Date) => {
    return date.toLocaleDateString('en-GB', {
      day: 'numeric',
      month: 'short',
      year: 'numeric'
    })
  }

  return `${formatDate(startDate)} - ${formatDate(endDate)}`
}

const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
}

// Lifecycle hooks
onMounted(async () => {
  // Load evaluation periods first
  await fetchEvaluationPeriods()

  // Set the selected evaluation period if not already set
  if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
    selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
  }

  // Load KPI data and administration data
  if (user.value?.email) {
    await Promise.all([
      loadKpiData(),
      loadAdministrationData()
    ])
  }
})

// Watchers
watch(
  () => selectedEvaluationPeriod.value,
  async (newEvalId, oldEvalId) => {
    if (newEvalId && newEvalId !== oldEvalId && user.value?.email && !loading.value) {
      await Promise.all([
        loadKpiData(),
        loadAdministrationData()
      ])
    }
  }
)

watch(
  () => user.value?.email,
  async (email) => {
    if (email) {
      // Fetch evaluation periods and set default
      await fetchEvaluationPeriods()
      if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
        selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
      }
      await Promise.all([
        loadKpiData(),
        loadAdministrationData()
      ])
    }
  },
  { immediate: true }
)
</script>