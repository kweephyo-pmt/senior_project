<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">
          Domain 1: Teaching Performance
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

    <!-- Error message -->
    <div v-if="fetchError && !loading" class="mb-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <h3 class="text-sm font-medium text-yellow-800">API Connection Issue</h3>
          <div class="mt-2 text-sm text-yellow-700">
            <p>{{ fetchError }}</p>
            <p class="mt-1">Showing sample data instead. Please try refreshing the page.</p>
          </div>
        </div>
      </div>
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
    <div v-if="!loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Teaching Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6 relative">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 text-center">
          Teaching Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold ({{ getDomainThreshold('domain1') }}) - Earned score ({{ getDomainScore('domain1') }})
        </p>
        <!-- Qualitative Work positioned beside title/threshold -->
        <div class="absolute top-4 right-4 bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden z-10 min-w-[120px]">
          <div class="bg-[#2C5282] text-white px-4 py-1 text-center">
            <h3 class="text-xs font-bold">Quality of Work</h3>
          </div>
          <div class="bg-white px-4 py-1.5 text-center">
            <div class="text-xl font-bold text-gray-800">43/50</div>
          </div>
        </div>
        
        <div class="h-[300px] sm:h-[360px] w-full">
          <canvas ref="teachingChart"></canvas>
        </div>
      </div>

      <!-- Tables stacked vertically in a card column -->
      <div class="flex flex-col gap-6">
        <!-- Undergraduate Teaching -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Undergraduate Teaching</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <!-- No data state -->
            <div v-if="undergraduateData.length === 0" class="text-center py-8">
              <p class="text-xs text-gray-500">No undergraduate courses found</p>
            </div>
            <!-- Data table -->
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">No.</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course Code</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Number of Students</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(course, index) in undergraduateData" :key="course.coursecode" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ index + 1 }}</td>
                  <td class="px-3 py-1">{{ course.coursename }}</td>
                  <td class="px-3 py-1 text-center">{{ course.coursecode }}</td>
                  <td class="px-3 py-1 text-center">{{ course.totalstudent }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        
        <!-- Graduate Teaching -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Graduate Teaching</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <!-- No data state -->
            <div v-if="graduateData.length === 0" class="text-center py-8">
              <p class="text-xs text-gray-500">No graduate courses found</p>
            </div>
            <!-- Data table -->
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">No.</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course Code</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Number of Students</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(course, index) in graduateData" :key="course.coursecode" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ index + 1 }}</td>
                  <td class="px-3 py-1">{{ course.coursename }}</td>
                  <td class="px-3 py-1 text-center">{{ course.coursecode }}</td>
                  <td class="px-3 py-1 text-center">{{ course.totalstudent }}</td>
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
import { useFirebaseAuth } from '@/composables/useFirebaseAuth';
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods';
import { useMfuTeachingApi } from '@/composables/useMfuTeachingApi';
import { useMfuKpiApi } from '@/composables/useMfuKpiApi';
import Chart from "chart.js/auto";
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { ref, watch, onMounted, onUnmounted, computed } from "vue";

definePageMeta({
  layout: "lecturer",
});

const { user } = useFirebaseAuth()
const { evaluationPeriods, loading: isLoadingPeriods, fetchEvaluationPeriods, activeEvaluationPeriod } = useEvaluationPeriods()
const { getAllTeachingData, extractStaffCode } = useMfuTeachingApi()
const { kpiData: mfuKpiData, isLoading: kpiLoading, fetchKpiPercentages } = useMfuKpiApi()

// Reactive data
const selectedEvaluationPeriod = ref<number | null>(null)
const loading = ref(true)
const teachingData = ref<any>(null)
const undergraduateData = ref<any[]>([])
const graduateData = ref<any[]>([])
const chartData = ref<any>(null)
const fetchError = ref<string | null>(null)
const teachingChart = ref<HTMLCanvasElement | null>(null)

// Chart instance
let chartInstance: Chart | null = null

// KPI weights computed from MFU API - updated to use the new structure
const kpiWeights = computed(() => {
  if (mfuKpiData.value) {
    return {
      domainScoreName: mfuKpiData.value.domainScoreName || 'Teaching',
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
  return domainNames[domain as keyof typeof domainNames] || 'Unknown'
}

// Load teaching data from MFU API
const loadTeachingData = async () => {
  try {
    loading.value = true
    fetchError.value = null
    
    if (!user.value?.email) {
      throw new Error('User email not available')
    }
    
    const evalId = String(selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9)
    
    console.log(`Loading teaching data for evaluation period: ${evalId}`)
    
    const result = await getAllTeachingData(user.value.email, evalId)
    
    console.log('Teaching data received:', result)
    
    teachingData.value = result
    undergraduateData.value = result.undergraduate || []
    graduateData.value = result.graduate || []
    
    // Use all teaching data for chart
    chartData.value = {
      undergraduate: result.undergraduateRawScore || [],
      graduate: result.graduateRawScore || [],
      studentInternships: result.studentInternships || [],
      studentProjects: result.studentProjects || [],
      thesisOversight: result.thesisOversight || [],
      otherTeachingTasks: result.otherTeachingTasks || []
    }
    
    console.log('All teaching data for chart:', chartData.value)
    console.log('✅ Successfully loaded teaching data from MFU API')
    
    // Render chart after data is loaded
    renderChart()
    
  } catch (err) {
    const errorMessage = err instanceof Error ? err.message : String(err)
    console.error('❌ Failed to load teaching data:', errorMessage)
    fetchError.value = errorMessage
  } finally {
    loading.value = false
  }
}

// Format date range for selected evaluation period
const formatDateRange = () => {
  if (isLoadingPeriods.value) {
    return 'Loading...'
  }
  
  if (!selectedEvaluationPeriod.value || !evaluationPeriods.value) {
    return 'No period selected'
  }
  
  const selectedPeriod = evaluationPeriods.value.find(p => p.evaluateid === selectedEvaluationPeriod.value)
  if (!selectedPeriod) {
    return 'Period not found'
  }
  
  const startDate = new Date(selectedPeriod.evaluatestartdate).toLocaleDateString('en-GB', { 
    day: 'numeric', 
    month: 'short', 
    year: 'numeric' 
  })
  const endDate = new Date(selectedPeriod.evaluateenddate).toLocaleDateString('en-GB', { 
    day: 'numeric', 
    month: 'short', 
    year: 'numeric' 
  })
  
  return `${startDate}-${endDate}`
}

// Load data when evaluation period changes
const onEvaluationPeriodChange = async () => {
  if (selectedEvaluationPeriod.value && user.value?.email) {
    await loadTeachingData()
    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    await fetchKpiPercentages(user.value.email, evalId)
  }
}

// Render chart with raw score data
const renderChart = () => {
  if (!teachingChart.value) return
  
  // Destroy existing chart
  if (chartInstance) {
    chartInstance.destroy()
  }
  
  const ctx = teachingChart.value.getContext('2d')
  if (!ctx) return
  
  // Calculate scores from actual API data
  const undergradLectScore = chartData.value?.undergraduate?.reduce((sum: number, item: any) => {
    return sum + (item.scorelect || 0)
  }, 0) || 0
  
  const undergradLabScore = chartData.value?.undergraduate?.reduce((sum: number, item: any) => {
    return sum + (item.scorelab || 0)
  }, 0) || 0
  
  const gradLectScore = chartData.value?.graduate?.reduce((sum: number, item: any) => {
    return sum + (item.scorelect || 0)
  }, 0) || 0
  
  const gradLabScore = chartData.value?.graduate?.reduce((sum: number, item: any) => {
    return sum + (item.scorelab || 0)
  }, 0) || 0
  
  // Get scores from other teaching tasks
  const otherTeachingScore = chartData.value?.otherTeachingTasks?.reduce((sum: number, item: any) => {
    return sum + (item.sumscore || 0)
  }, 0) || 0
  
  const thesisOversightScore = chartData.value?.thesisOversight?.reduce((sum: number, item: any) => {
    return sum + (item.totalscore || 0)
  }, 0) || 0
  
  const studentProjectsScore = chartData.value?.studentProjects?.reduce((sum: number, item: any) => {
    return sum + (item.totalscore || 0)
  }, 0) || 0
  
  // Student internships doesn't have a score field in the API response, so we'll use 0
  const studentInternshipsScore = 0
  
  // Calculate dynamic maximum value based on actual data
  const lectureData = [otherTeachingScore, thesisOversightScore, studentProjectsScore, studentInternshipsScore, gradLectScore, undergradLectScore]
  const labData = [0, 0, 0, 0, gradLabScore, undergradLabScore]
  
  // Find the maximum combined score (lecture + lab) for any category
  const maxCombinedScore = Math.max(...lectureData.map((lecture, index) => lecture + labData[index]))
  
  // Set dynamic max with some padding (20% extra or minimum of 200)
  const dynamicMax = Math.max(Math.ceil(maxCombinedScore * 1.2), 200)
  
  // Create horizontal stacked bar chart
  chartInstance = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: [
        'Other Teaching Tasks Assigned\nby the Academic Office',
        'Thesis Oversight Duties',
        'Student Projects or\nSpecial Issues',
        'Student Internships',
        'Graduate Teaching',
        'Undergraduate Teaching'
      ],
      datasets: [
        {
          label: 'Lecture (Score)',
          data: lectureData,
          backgroundColor: '#334155', // Dark blue-gray
          borderRadius: 0,
          barThickness: 25
        },
        {
          label: 'Lab(Score)',
          data: labData,
          backgroundColor: '#C2185B', // Magenta/pink
          borderRadius: 0,
          barThickness: 25
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      indexAxis: 'y',
      scales: {
        x: {
          stacked: true,
          beginAtZero: true,
          max: dynamicMax,
          ticks: {
            stepSize: 20,
            font: {
              size: 11
            }
          },
          title: {
            display: true,
            text: 'Raw Score',
            font: {
              size: 12,
              weight: 'bold'
            }
          },
          grid: {
            color: '#E5E7EB'
          }
        },
        y: {
          stacked: true,
          ticks: {
            font: {
              size: 11
            },
            maxRotation: 0,
            callback: function(value, index) {
              const label = this.getLabelForValue(value as number)
              // Split long labels into multiple lines
              if (label.includes('\n')) {
                return label.split('\n')
              }
              return label
            }
          },
          grid: {
            display: false
          }
        }
      },
      plugins: {
        legend: {
          display: false // Hide legend to match screenshot
        },
        tooltip: {
          callbacks: {
            label: (context) => {
              const label = context.dataset.label || ''
              const value = context.parsed.x || 0
              return `${label}: ${value.toFixed(2)}`
            }
          }
        },
        datalabels: {
          display: function(context) {
            const datasetIndex = context.datasetIndex
            const dataIndex = context.dataIndex
            const datasets = context.chart.data.datasets
            const value = context.dataset.data[context.dataIndex]
            
            // Calculate total for this category
            const total = datasets.reduce((sum, dataset) => {
              const dataValue = dataset.data[dataIndex]
              const numValue = typeof dataValue === 'number' ? dataValue : 0
              return sum + numValue
            }, 0)
            
            // Show labels for bars with values > 0, OR show total on last dataset even if it's 0
            const numValue = typeof value === 'number' ? value : 0
            return numValue > 0 || (datasetIndex === datasets.length - 1 && total >= 0)
          },
          anchor: 'end',
          align: 'right',
          color: '#374151',
          font: {
            size: 11,
            weight: 'bold'
          },
          formatter: (value, context) => {
            // Calculate total for this category
            const datasetIndex = context.datasetIndex
            const dataIndex = context.dataIndex
            const datasets = context.chart.data.datasets
            const total = datasets.reduce((sum, dataset) => {
              const dataValue = dataset.data[dataIndex]
              const numValue = typeof dataValue === 'number' ? dataValue : 0
              return sum + numValue
            }, 0)
            
            // Show total on the last dataset for each category
            if (datasetIndex === datasets.length - 1) {
              return total > 0 ? total.toFixed(1) : '0'
            }
            return ''
          },
          offset: 8
        }
      },
      layout: {
        padding: {
          right: 40,
          left: 10,
          top: 10,
          bottom: 10
        }
      }
    },
    plugins: [ChartDataLabels]
  })
}

// Initialize component
const initializeComponent = async () => {
  try {
    // Load evaluation periods first
    await fetchEvaluationPeriods()
    
    // Set default selected period to active period
    if (!selectedEvaluationPeriod.value && activeEvaluationPeriod.value) {
      selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
    }
    
    // Don't load teaching data here - let the user watcher handle it when user is ready
    
  } catch (error) {
    console.error('❌ Error initializing component:', error)
    loading.value = false
  }
}

// Watch for user changes and load data
watch(user, async (newUser) => {
  if (newUser?.email) {
    await loadTeachingData()
    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    await fetchKpiPercentages(newUser.email, evalId)
  }
}, { immediate: true })

// Watch for evaluation period changes
watch(
  () => selectedEvaluationPeriod.value,
  async (newEvalId, oldEvalId) => {
    if (newEvalId && newEvalId !== oldEvalId && user.value?.email && !loading.value) {
      console.log(`Evaluation period changed from ${oldEvalId} to ${newEvalId}`)
      await loadTeachingData()
      await fetchKpiPercentages(user.value.email, newEvalId)
    }
  }
)

// Initialize component on mount
onMounted(async () => {
  await initializeComponent()
})

// Clean up chart instance when component is unmounted
onUnmounted(() => {
  if (chartInstance) {
    chartInstance.destroy()
    console.log('Chart instance destroyed on unmount')
  }
})
</script>