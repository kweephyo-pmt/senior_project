<template>
    <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
      <!-- Header with Round Selector -->
      <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
        <div>
          <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">Domain 5: Arts and Culture Conservation Performance</h1>
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
    <div v-if="mfuError && !loading" class="mb-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <h3 class="text-sm font-medium text-yellow-800">MFU API Connection Issue</h3>
          <div class="mt-2 text-sm text-yellow-700">
            <p>{{ mfuError }}</p>
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
      <div class="grid grid-cols-1 md:grid-cols-[2fr_1fr] gap-4 sm:gap-6 lg:gap-8">
        <!-- Arts and Culture Performance Chart -->
        <div class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6 mb-6 sm:mb-8">
        <div class="flex flex-col items-center">
          <h2 class="text-md font-bold text-gray-900 mb-1 text-center">
            Arts and Culture Conservation Performance
          </h2>
          <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold ({{ getDomainThreshold('domain5') }}) - Earned score ({{ getDomainScore('domain5') }})
        </p>
        </div>
        
        <!-- Performance Chart -->
        <div class="h-[300px] sm:h-[400px] mb-4 sm:mb-6">
          <div v-if="isLoadingChart" class="flex justify-center items-center h-full">
            <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
            <p class="ml-3 text-sm text-gray-600">Loading chart data...</p>
          </div>
          <canvas v-else ref="acChart"></canvas>
        </div>
      </div>
      
      <!-- Right column with tables -->
      <div class="space-y-6">
        <!-- Self Development Projects -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4"> 
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Self Development</h2>
          <div class="max-h-[150px] overflow-y-auto pr-2"> 
            <table class="min-w-full text-xs">
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-if="loadingSelfDevelopment">
                  <td class="px-6 py-4 text-center text-gray-500">
                    Loading self-development activities...
                  </td>
                </tr>
                <tr v-else-if="selfDevelopmentData.length === 0">
                  <td class="px-6 py-4 text-center text-gray-500">
                    No self-development activities found for this evaluation period.
                  </td>
                </tr>
                <tr v-else v-for="activity in selfDevelopmentData" :key="activity.activity">
                  <td class="px-6 py-4 flex items-center gap-2">
                    <div class="flex-1">
                      <p class="text-sm font-bold mb-1">{{ activity.activity }}</p>
                      <p class="text-xs text-gray-600 mb-1 flex items-center gap-1">
                        <acDateLogo class="w-4 h-4"/>Date : {{ formatDate(activity.startdate) }}
                      </p>
                      <p class="text-xs text-gray-600 mb-1 flex items-center gap-1">
                        <acTypeLogo class="w-4 h-4"/>Type : {{ activity.typename }}
                      </p>
                      <p class="text-xs text-gray-600 flex items-center gap-1">
                        <acLocationLogo class="w-4 h-4"/>{{ activity.venue }}
                      </p>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- MFU-arranged activities table -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4"> 
          <h2 class="text-lg font-medium text-gray-900 mb-4">
            MFU-arranged activities
          </h2>
          
          <!-- Loading state -->
          <div v-if="isLoadingChart" class="text-center py-8">
            <div class="inline-block animate-spin rounded-full h-6 w-6 border-b-2 border-[#4697b9] mr-2"></div>
            <p class="text-sm text-gray-600 mt-2">Loading MFU arranged activities...</p>
          </div>
          
          <!-- No data state -->
          <div v-else-if="!mfuArrangedActivitiesData || mfuArrangedActivitiesData.filter(a => a && (a.projectname || a.project_name || a.activity)).length === 0" class="text-center py-8">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            <p class="text-sm text-gray-500 mt-2">No MFU arranged activities found for this evaluation period.</p>
          </div>
          
          <!-- Table with data -->
          <div v-else class="max-h-[150px] overflow-y-auto pr-2">
            <table class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">No.</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Project Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(activity, index) in mfuArrangedActivitiesData.filter(a => a && (a.projectname || a.project_name || a.activity))" :key="index" 
                    :class="{ 'bg-[#E8F4FC]': index % 2 === 1 }">
                  <td class="px-3 py-1 text-center">{{ index + 1 }}</td>
                  <td class="px-3 py-1">{{ activity.projectname || activity.project_name || activity.activity }}</td>
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
import { ref, onMounted, computed, watch, nextTick } from 'vue'
import Chart from 'chart.js/auto'
import ChartDataLabels from 'chartjs-plugin-datalabels'   
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'
import { useMfuKpiApi } from '@/composables/useMfuKpiApi'
import { useMfuArtsCultureApi } from '@/composables/useMfuArtsCultureApi'

definePageMeta({
  layout: 'lecturer'
})

const acChart = ref<HTMLCanvasElement | null>(null)
const showMobileMenu = ref(false)
const { user, logout } = useFirebaseAuth()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()
const { kpiData: mfuKpiData, isLoading: kpiLoading, fetchKpiPercentages } = useMfuKpiApi()
const { getSelfDevelopment, getMFUArrangedActivities, getAllArtsCultureChartData } = useMfuArtsCultureApi()

// Reactive data
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
const loading = ref(true)
const isLoadingChart = ref(false)
const mfuError = ref<string | null>(null)
const selfDevelopmentData = ref<any[]>([])
const loadingSelfDevelopment = ref(false)
const mfuArrangedActivitiesData = ref<any[]>([])
const chartDataFromApi = ref<any>(null)
let chartInstance: Chart | null = null

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

// KPI weights computed from MFU API - updated to use the new structure
const kpiWeights = computed(() => {
  if (mfuKpiData.value) {
    return {
      domainScoreName: mfuKpiData.value.domainScoreName || 'Arts and Culture',
      domainWeights: mfuKpiData.value.domainWeights || {},
      domainScores: mfuKpiData.value.domainScores || {},
      domainThresholds: mfuKpiData.value.domainThresholds || {}
    }
  }
  // Return null when data is not loaded to prevent flashing
  return null
})

// Helper functions to get domain data
const getDomainWeight = (domain: string) => {
  return kpiWeights.value?.domainWeights?.[domain] || 0
}

const getDomainScore = (domain: string) => {
  return kpiWeights.value?.domainScores?.[domain] || 0
}

const getDomainThreshold = (domain: string) => {
  return kpiWeights.value?.domainThresholds?.[domain] || 0
}

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
      kpiData.value = mfuKpiData.value as any
    }
  } catch (err) {
    // Error handled silently
  } finally {
    loading.value = false
  }
}
const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
}

// Load self-development data from MFU API
const loadSelfDevelopmentData = async () => {
  try {
    loadingSelfDevelopment.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getSelfDevelopment(user.value.email, evalId.toString())
      selfDevelopmentData.value = response.data || []
    }
  } catch (err) {
    selfDevelopmentData.value = []
  } finally {
    loadingSelfDevelopment.value = false
  }
}

// Load MFU arranged activities table data from MFU API
const loadMfuArrangedActivitiesData = async () => {
  if (!user.value?.email) return
  
  try {
    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    const response = await getMFUArrangedActivities(user.value.email, evalId.toString())
    mfuArrangedActivitiesData.value = response.data || []
  } catch (err) {
    mfuArrangedActivitiesData.value = []
  }
}

// Load Arts and Culture Chart data from MFU API
const loadArtsCultureChartData = async () => {
  if (!user.value?.email) return
  
  try {
    isLoadingChart.value = true
    mfuError.value = null
    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    const result = await getAllArtsCultureChartData(user.value.email, evalId.toString())
    
    if (result) {
      chartDataFromApi.value = result
    }
  } catch (err) {
    chartDataFromApi.value = null
    mfuError.value = err instanceof Error ? err.message : 'Failed to load chart data'
  } finally {
    isLoadingChart.value = false
  }
}

// Format date helper
const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-GB', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  })
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

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (user.value?.email && selectedEvaluationPeriod.value) {
    await Promise.all([
      loadKpiData(),
      loadSelfDevelopmentData(),
      loadMfuArrangedActivitiesData(),
      loadArtsCultureChartData(),
      fetchKpiPercentages(user.value.email, selectedEvaluationPeriod.value)
    ])
    initializeChart()
  }
}

// Helper function to get score from API data
const getScore = (dataArray: any[]) => {
  if (!dataArray || dataArray.length === 0) return 0
  const item = dataArray[0]
  return item?.sumscore || item?.score || item?.rawscore || 0
}

// Initialize chart with data
const initializeChart = () => {
  if (!acChart.value) {
    console.warn('Chart canvas element not available')
    return
  }
  
  // Destroy existing chart
  if (chartInstance) {
    chartInstance.destroy()
  }
  
  let chartData;
  
  // Use MFU API data if available
  if (chartDataFromApi.value) {
    chartData = {
      labels: [
        ['Arts & Culture Conservation Performance'],
        ['Organization development or participation'],
        'Self-development',
        'Student Development activities',
        ['MFU-arranged arts & culture', 'conservation activities']
      ],
      datasets: [{
        label: 'Score',
        data: [
          getScore(chartDataFromApi.value.artsCultureConservationRawscore),
          getScore(chartDataFromApi.value.organizationDevelopmentRawscore),
          getScore(chartDataFromApi.value.selfDevelopmentRawscore),
          getScore(chartDataFromApi.value.studentDevelopmentActivitiesRawscore),
          getScore(chartDataFromApi.value.mfuArrangedActivitiesRawscore)
        ],
        backgroundColor: '#172554',
        borderWidth: 0,
        borderRadius: 0,
      }]
    }
  } else {
    // Show empty chart with zero values using same template structure
    chartData = {
      labels: [
        ['Arts & Culture Conservation Performance'],
        ['Organization development or participation'],
        'Self-development',
        'Student Development activities',
        ['MFU-arranged arts & culture', 'conservation activities']
      ],
      datasets: [
        {
          label: "Score",
          data: [0, 0, 0, 0, 0],
          backgroundColor: "#172554",
          borderWidth: 0,
          borderRadius: 0,
        },
      ],
    };
  }
  
  // Validate chart data before creating chart
  if (!chartData || !chartData.labels || chartData.labels.length === 0) {
    console.warn('Chart data not available yet')
    return
  }
  
  chartInstance = new Chart(acChart.value, {
    type: 'bar',
    data: chartData,
    options: {
      indexAxis: 'y',
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        },
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
          max: 160,
          grid: {
            color: '#f0f0f0'
          },
          ticks: {
            font: {
              size: 12
            }
          },
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
          grid: {
            display: false
          },
          ticks: {
            font: {
              size: 12
            }
          }
        }
      }
    },
    plugins: [ChartDataLabels]
  })
}

onMounted(async () => {
  // Load KPI data first
  if (user.value?.email) {
    await loadKpiData()
  }
  
  // Fetch evaluation periods and set default
  await fetchEvaluationPeriods()
  if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
    selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
  }
  
  // Load all data from MFU API
  if (user.value?.email) {
    await Promise.all([
      loadSelfDevelopmentData(),
      loadMfuArrangedActivitiesData(),
      loadArtsCultureChartData()
    ])
  }
  
  // Wait for DOM to be ready before initializing chart
  await nextTick()
  initializeChart()
})

// Watch for evaluation period changes
watch(
  () => selectedEvaluationPeriod.value,
  async (newEvalId, oldEvalId) => {
    if (newEvalId && newEvalId !== oldEvalId && user.value?.email && !loading.value) {
      console.log(`Evaluation period changed from ${oldEvalId} to ${newEvalId}`)
      await Promise.all([
        loadKpiData(),
        loadSelfDevelopmentData(),
        loadMfuArrangedActivitiesData(),
        loadArtsCultureChartData(),
        fetchKpiPercentages(user.value.email, newEvalId)
      ])
      initializeChart()
    }
  }
)

watch(
  () => user.value?.email,
  async (email) => {
    if (email) {
      loadKpiData()
      // Fetch evaluation periods and set default
      await fetchEvaluationPeriods()
      if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
        selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
      }
      await Promise.all([
        loadSelfDevelopmentData(),
        loadMfuArrangedActivitiesData(),
        loadArtsCultureChartData(),
        fetchKpiPercentages(email, selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9)
      ])
      // Re-initialize chart with new data
      await nextTick()
      initializeChart()
    }
  },
  { immediate: true }
)

// Watch for chart data changes and re-initialize chart
watch(
  () => chartDataFromApi.value,
  () => {
    if (chartDataFromApi.value) {
      nextTick(() => {
        initializeChart()
      })
    }
  },
  { deep: true }
)
</script>