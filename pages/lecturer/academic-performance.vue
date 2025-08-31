<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900">Domain 3: Academic Services Performance</h1>
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

    <!-- Academic Service Track -->
    <div class="mb-6">
      <h2 class="text-center text-base sm:text-lg font-medium text-inherit mb-1">Academic Service Track</h2>
      <p class="text-center text-sm text-gray-500 mb-4">
        <span v-if="isLoadingPeriods">Loading...</span>
        <span v-else>{{ formatDateRange() }}</span>
      </p>
    </div>

    <!-- Loading spinner -->
    <div v-if="loading" class="flex justify-center items-center py-8">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
      <p class="ml-3 text-sm text-gray-600">Loading KPI data...</p>
    </div>

    <!-- KPI Categories with NuxtLink, only when data is loaded -->
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
        <p class="text-sm text-inherit">Teaching (60%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiWeights?.teaching || 0 }}%</p>
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
        <p class="text-sm text-inherit">Research (40%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiWeights?.research || 0 }}%</p>
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
        <p class="text-sm text-inherit">Academic Service (35%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiWeights?.academicService || 0 }}%</p>
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
        <p class="text-sm text-inherit">Administration (30%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiWeights?.administration || 0 }}%</p>
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
        <p class="text-sm text-inherit">Arts and Culture (10%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiWeights?.artsCulture || 0 }}%</p>
      </NuxtLink>
    </div>

    <!-- Academic Performance -->
    <div class="grid grid-cols-1 md:grid-cols-[60%_40%] gap-4 sm:gap-6 lg:gap-8">
      <div class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6 mb-6 sm:mb-8">
        <div class="flex flex-col items-center">
          <h2 class="text-md font-bold text-gray-900 mb-1 text-center">
            Academic Services Performance
          </h2>
          <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold (10) - Earned score (59)
        </p>
        </div>

        <!-- Performance Chart -->
        <div class="h-[300px] sm:h-[400px] mb-4 sm:mb-6">
          <div v-if="isLoadingChart" class="flex justify-center items-center h-full">
            <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
            <p class="ml-3 text-sm text-gray-600">Loading chart data...</p>
          </div>
          <canvas v-else ref="academicChart"></canvas>
        </div>
      </div>
      <!-- table -->
      <div class="">
        <div class="bg-[#FAFBFD] rounded-lg shadow-md p-4 sm:p-6 mr-0 sm:mr-8 mb-2">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-1">
          Academic Service Activities
        </h2>
        <div class="w-full h-0.5 bg-[#B0B9C4] mb-1"></div>

        <div class="flex flex-col">
          <div class="flex items-start gap-4 bg-[#FFFFFF] p-4 mt-4 rounded-lg shadow-sm shadow-b-gray-300">

          <div>
            <p class="text-xs font-bold mb-2">Digital Literacy Enhancement Training for Elderly (Ban Pang Lao)</p>
            <p class="text-xs text-[#606060]">Dr.Supansa Chaising(Co-organizer)</p>
            <p class="text-xs text-[#606060]">Budget (THB) : 0 </p>
          </div>
          <div class="flex items-center">
            <span class="bg-[#22C55E] text-[#FFFFFF] text-xs font-semibold px-3 py-1 rounded-full mt-8 whitespace-nowrap">Non-revenue</span>
          </div>
        </div>  
        <div class="flex items-start gap-4 bg-[#FFFFFF] p-4 mt-4 rounded-lg shadow-sm shadow-b-gray-300">

          <div>
            <p class="text-xs font-bold mb-2">Digital Literacy Enhancement Training for Youth (NFE Chiang Rai)</p>
            <p class="text-xs text-[#606060]">Dr.Supansa Chaising(Co-organizer)</p>
            <p class="text-xs text-[#606060]">Budget (THB) : 0 </p>
          </div>
          <div class="flex items-center">
            <span class="bg-[#22C55E] text-[#FFFFFF] text-xs font-semibold px-3 py-1 rounded-full mt-8 whitespace-nowrap">Non-revenue</span>
          </div>
        </div>
        </div>
      </div>
      <div class="bg-[#FAFBFD] rounded-lg shadow-md p-4 sm:p-6 mr-0 sm:mr-8">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2">
          Performance as an Invited Lecturer or Speaker
        </h2>
        <div class="w-full h-0.5 bg-[#B0B9C4] mb-2"></div>

        <div class="flex items-start gap-4 bg-[#FFFFFF] p-4 mt-3 rounded-lg shadow-sm shadow-b-gray-300">
          <div>
            <p class="text-xs font-bold mb-2">Developing Steps for Learning Programming through Gamification</p>
            <p class="text-xs text-[#606060]">Dr.Supansa Chaising(Co-organizer)</p>
          </div>
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
import { useAcademicServicePerformance } from '@/composables/useAcademicServicePerformance'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'
import { useMfuKpiApi } from '@/composables/useMfuKpiApi'

definePageMeta({
  layout: 'lecturer'
})

const academicChart = ref<HTMLCanvasElement | null>(null)
const showMobileMenu = ref(false)
const { user, logout } = useFirebaseAuth()
const { academicServiceData, loading: isLoadingChart, error: chartError, fetchAcademicServicePerformance, getChartData } = useAcademicServicePerformance()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()
const { kpiData: mfuKpiData, isLoading: kpiLoading, fetchKpiPercentages } = useMfuKpiApi()

// Reactive data
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
const loading = ref(true)
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

// KPI weights computed from MFU API
const kpiWeights = computed(() => {
  if (mfuKpiData.value?.categories) {
    const categories = mfuKpiData.value.categories
    return {
      teaching: categories[0]?.weight || 0,
      research: categories[1]?.weight || 0,
      academicService: categories[2]?.weight || 0,
      administration: categories[3]?.weight || 0,
      artsCulture: categories[4]?.weight || 0
    }
  }
  // Return null when data is not loaded to prevent flashing
  return null
})

// KPI categories from MFU API
const kpiCategories = computed(() => {
  if (mfuKpiData.value?.categories) {
    return mfuKpiData.value.categories
  }
  // Return empty data if no MFU API data available
  return [
    { name: 'Teaching', weight: 0, value: 0, color: '#1e40af' },
    { name: 'Research', weight: 0, value: 0, color: '#0891b2' },
    { name: 'Academic Service', weight: 0, value: 0, color: '#059669' },
    { name: 'Administration', weight: 0, value: 0, color: '#7c3aed' },
    { name: 'Arts and Culture', weight: 0, value: 0, color: '#dc2626' }
  ]
})

// Load KPI data from MFU API
const loadKpiData = async () => {
  try {
    loading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      console.log('Loading KPI data from MFU API for:', user.value.email, 'evaluation period:', evalId)
      await fetchKpiPercentages(user.value.email, evalId)
      console.log('KPI data loaded:', mfuKpiData.value)
      kpiData.value = mfuKpiData.value as any
    }
  } catch (err) {
    console.error('Failed to load KPI data:', err)
  } finally {
    loading.value = false
  }
}
const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
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
      fetchAcademicServicePerformance(user.value.email, selectedEvaluationPeriod.value.toString()),
      loadKpiData(),
      fetchKpiPercentages(user.value.email)
    ])
    initializeChart()
  }
}

// Initialize chart with data
const initializeChart = () => {
  if (!academicChart.value) return
  
  // Destroy existing chart
  if (chartInstance) {
    chartInstance.destroy()
  }
  
  let chartData;
  
  if (academicServiceData.value.length > 0) {
    chartData = getChartData();
  } else {
    // Show empty chart with zero values using same template structure
    chartData = {
      labels: [
        'Other Services',
        'Visiting Professor',
        'Additional Assigned Tasks',
        'Reviewer',
        'Committee/Advisor',
        'Guest Lecturer',
        'Academic Service Activities'
      ],
      datasets: [
        {
          label: "Internal (Score)",
          data: [0, 0, 0, 0, 0, 0, 0],
          backgroundColor: "#1D3555",
          borderWidth: 0,
          borderRadius: 4,
        },
        {
          label: "External (Score)",
          data: [0, 0, 0, 0, 0, 0, 0],
          backgroundColor: "#a21a5b",
          borderWidth: 0,
          borderRadius: 4,
        },
        {
          label: "Non-Revenue (Score)",
          data: [0, 0, 0, 0, 0, 0, 0],
          backgroundColor: "#059669",
          borderWidth: 0,
          borderRadius: 4,
        },
        {
          label: "Revenue (Score)",
          data: [0, 0, 0, 0, 0, 0, 0],
          backgroundColor: "#dc2626",
          borderWidth: 0,
          borderRadius: 4,
        },
      ],
    };
  }
  
  chartInstance = new Chart(academicChart.value, {
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
          offset: 10,
          padding: 5,
          clamp: true,
          formatter: function (value, context) {
            const datasets = context.chart?.data?.datasets || []
            const index = context.dataIndex

            const internal = datasets[0]?.data?.[index] ?? 0
            const external = datasets[1]?.data?.[index] ?? 0
            const nonRevenue = datasets[2]?.data?.[index] ?? 0
            const revenue = datasets[3]?.data?.[index] ?? 0

            const total = Number(internal) + Number(external) + Number(nonRevenue) + Number(revenue)

            if (context.datasetIndex === 3) {
              return total > 0 ? total : '0'
            }
            return ''
          }
        }
      },
      scales: {
        x: {
          stacked: true,
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
          stacked: true,
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
  
  // Load academic service performance data
  if (user.value?.email) {
    await fetchAcademicServicePerformance(user.value.email, selectedEvaluationPeriod.value?.toString())
  }
  
  // Initialize the chart with database data
  initializeChart()
})

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
        fetchAcademicServicePerformance(email, selectedEvaluationPeriod.value?.toString()),
        fetchKpiPercentages(email)
      ])
      // Re-initialize chart with new data
      initializeChart()
    }
  },
  { immediate: true }
)
</script>
