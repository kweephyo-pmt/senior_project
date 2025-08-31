<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900">
          KPI Performance Overview
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

     <!-- KPI Categories with NuxtLink-->
    <!-- Loading spinner -->
    <div v-if="loading" class="flex justify-center items-center py-8">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
      <p class="ml-3 text-sm text-gray-600">Loading KPI data...</p>
    </div>

    <!-- KPI Categories with NuxtLink, only when not loading -->
    <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3 sm:gap-4 mb-6 sm:mb-8">
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
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[0]?.value) }}%</p>
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
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[1]?.value) }}%</p>
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
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[2]?.value) }}%</p>
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
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[3]?.value) }}%</p>
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
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[4]?.value) }}%</p>
      </NuxtLink>
    </div>

    <!-- Loading State for KPI Data -->
    <div v-if="loading" class="flex justify-center items-center py-8">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
      <p class="ml-3 text-sm text-gray-600">Loading KPI data...</p>
    </div>

    <div v-if="!loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Teaching Track Chart -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl border border-gray-100 p-6 sm:p-8">
        <div class="text-center mb-6">
          <h2 class="text-lg font-semibold text-gray-900">Teaching Track</h2>
          <p class="text-sm text-gray-500 mt-1">11 Feb 2025 - 31 July 2025</p>
        </div>
        
        <!-- Chart Container -->
        <div class="relative w-full h-80 mx-auto flex items-center justify-center">
          <canvas ref="performanceChart" class="w-full h-full"></canvas>
        </div>

        <!-- Legend -->
        <div class="mt-8 flex flex-wrap justify-center gap-x-8 gap-y-3">
          <div v-for="(category, index) in kpiCategories" :key="index" class="flex items-center">
            <div 
              class="w-3 h-3 rounded-full mr-2 flex-shrink-0"
              :style="{ backgroundColor: category.color }"
            ></div>
            <span class="text-sm font-medium text-gray-700 whitespace-nowrap">
              {{ category.name }} 
            </span>
          </div>
        </div>
      </div>

      <!-- Performance Metrics -->
      <div class="lg:col-span-1 space-y-6">
        <div class="bg-white rounded-xl shadow-md p-6">
          <h2 class="text-lg font-medium text-gray-900 mb-4">
            Overall Performance
          </h2>
          
          <div class="space-y-4">
            <div>
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Academic Performance (60%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ overallPerformance.academicPerformance }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div 
                  class="bg-blue-600 h-2 rounded-full"
                  :style="{ width: (overallPerformance.academicPerformance / 60 * 100) + '%' }"
                ></div>
              </div>
            </div>
            
            <div>
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Behavior (40%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ overallPerformance.behavior }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div 
                  class="bg-green-600 h-2 rounded-full"
                  :style="{ width: (overallPerformance.behavior / 40 * 100) + '%' }"
                ></div>
              </div>
            </div>
            
            <div>
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Total Score (100%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ overallPerformance.totalScore }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-indigo-600 h-2 rounded-full"
                  :style="{ width: overallPerformance.totalScore + '%' }"
                ></div>
              </div>
            </div>

            <div class="pt-4 border-t border-gray-200">
              <div class="flex justify-between items-center">
                <span class="text-sm font-medium text-gray-700"
                  >Performance Level</span
                >
                <span 
                  class="px-3 py-1 text-sm font-medium bg-yellow-100 text-yellow-800 rounded-full"
                  >{{ overallPerformance.performanceLevel }}</span
                >
              </div>
            </div>
          </div>
        </div>

        <!-- Performance Level Legend -->
        <div class="bg-white rounded-lg shadow-md p-4 sm:p-6">
          <h2 class="text-lg font-medium text-gray-900 mb-4">
            Performance Level
          </h2>
          
          <div class="space-y-2">
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-700">< 55</span>
              <span
                class="px-3 py-1 text-xs font-medium bg-red-100 text-red-800 rounded-full"
                >Very Poor</span
              >
            </div>
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-700">55-64</span>
              <span
                class="px-3 py-1 text-xs font-medium bg-orange-100 text-orange-800 rounded-full"
                >Poor</span
              >
            </div>
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-700">65-74</span>
              <span
                class="px-3 py-1 text-xs font-medium bg-yellow-100 text-yellow-800 rounded-full" 
                >Moderate</span
              >
            </div>
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-700">75-84</span>
              <span
                class="px-3 py-1 text-xs font-medium bg-green-100 text-green-800 rounded-full"
                >Good</span
              >
            </div>
            <div class="flex justify-between items-center">
              <span class="text-sm text-gray-700">85-100</span>
              <span
                class="px-3 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded-full" 
                >Excellent</span
              >
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useFirebaseAuth } from '@/composables/useFirebaseAuth';
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods';
import Chart from "chart.js/auto";
import { computed, onMounted, ref, watch, onActivated, onUnmounted } from "vue";

// Import KPI composable
import { useMfuKpiApi } from '@/composables/useMfuKpiApi'
import { useOverallPerformance } from '@/composables/useOverallPerformance'

const { user, logout } = useFirebaseAuth()
const { evaluationPeriods, loading: isLoadingPeriods, fetchEvaluationPeriods, activeEvaluationPeriod } = useEvaluationPeriods()
const { kpiData: mfuKpiData, isLoading: mfuKpiLoading, error: mfuKpiError, fetchKpiPercentages } = useMfuKpiApi()
const { 
  performanceData, 
  loading: performanceLoading, 
  error: performanceError, 
  fetchOverallPerformance,
  getPerformanceLevelColor 
} = useOverallPerformance()

// Selected evaluation period state
const selectedEvaluationPeriod = ref<number | null>(null)

// State management
const loading = ref(true)
const fetchError = ref<string | null>(null)

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

// Logging function
const addLog = (message: string, type: 'info' | 'error' = 'info') => {
  const timestamp = new Date().toLocaleTimeString()
  const logMessage = `[KPI Dashboard ${timestamp}] ${message}`
  console.log(logMessage)
  
  if (type === 'error') {
    console.error(logMessage)
  }
}

// Load KPI data from MFU API and overall performance data
const loadKpiData = async () => {
  try {
    loading.value = true
    fetchError.value = null
    
    addLog('Starting KPI and performance data fetch from MFU API...')
    
    if (!user.value?.email) {
      throw new Error('User email not available')
    }
    
    const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
    addLog(`Loading data for: ${user.value.email}, evaluation period: ${evalId}`)
    
    // Fetch both KPI data from MFU API and overall performance data
    const [kpiResult, performanceResult] = await Promise.all([
      fetchKpiPercentages(user.value.email, evalId),
      fetchOverallPerformance(user.value.email, evalId)
    ])
    
    addLog('Raw KPI data received from MFU API:')
    console.log('KPI Data:', kpiResult)
    console.log('Performance Data:', performanceResult)
    
    if (kpiResult && kpiResult.categories) {
      addLog('✅ Successfully loaded KPI data from MFU API')
    } else {
      throw new Error('Invalid KPI data format received from MFU API')
    }
    
    addLog('✅ Successfully loaded performance data')
    
  } catch (err) {
    const errorMessage = err instanceof Error ? err.message : String(err)
    addLog('❌ Failed to load data: ' + errorMessage, 'error')
    fetchError.value = errorMessage
    // No fallback data - will show zeros if API fails
  } finally {
    loading.value = false
  }
}

// Retry fetch function
const retryFetch = async () => {
  addLog('🔄 Retrying data fetch...')
  await loadKpiData()
}

// Current KPI data computed from MFU API only
const currentKpiData = computed(() => {
  if (mfuKpiData.value && mfuKpiData.value.categories && Array.isArray(mfuKpiData.value.categories)) {
    addLog('Using MFU API KPI data...')
    
    const categories = mfuKpiData.value.categories
    return {
      teaching: { weight: categories[0]?.weight || 0, value: categories[0]?.value || 0 },
      research: { weight: categories[1]?.weight || 0, value: categories[1]?.value || 0 },
      academicService: { weight: categories[2]?.weight || 0, value: categories[2]?.value || 0 },
      administration: { weight: categories[3]?.weight || 0, value: categories[3]?.value || 0 },
      artsCulture: { weight: categories[4]?.weight || 0, value: categories[4]?.value || 0 }
    }
  }
  
  // Return zeros when no API data available
  return {
    teaching: { weight: 0, value: 0 },
    research: { weight: 0, value: 0 },
    academicService: { weight: 0, value: 0 },
    administration: { weight: 0, value: 0 },
    artsCulture: { weight: 0, value: 0 }
  }
})

// KPI categories computed from current data
const kpiCategories = computed(() => {
  const currentValues = currentKpiData.value
  
  // Define maximum weights for each category
  const maxWeights = {
    teaching: 60,
    research: 40,
    academicService: 35,
    administration: 30,
    artsCulture: 10
  }
  
  const categories = [
    { 
      name: 'Teaching', 
      weight: maxWeights.teaching,
      value: currentValues.teaching.weight || 0, // API value
      color: '#005F99', 
      key: 'teaching' 
    },
    { 
      name: 'Research', 
      weight: maxWeights.research,
      value: currentValues.research.weight || 0, // API value
      color: '#00BFFF', 
      key: 'research' 
    },
    { 
      name: 'Academic Service', 
      weight: maxWeights.academicService,
      value: currentValues.academicService.weight || 0, // API value
      color: '#7FD6D6', 
      key: 'academicService' 
    },
    { 
      name: 'Administration', 
      weight: maxWeights.administration,
      value: currentValues.administration.weight || 0, // API value
      color: '#7c3aed', 
      key: 'administration' 
    },
    { 
      name: 'Arts and Culture', 
      weight: maxWeights.artsCulture,
      value: currentValues.artsCulture.weight || 0, // API value
      color: '#8A8BE6', 
      key: 'artsCulture' 
    }
  ]
  
  addLog('Final KPI categories computed with max weights')
  return categories
})

// Overall performance data from database
const overallPerformance = computed(() => {
  if (performanceData.value) {
    return {
      academicPerformance: performanceData.value.academicPerformance || 0,
      behavior: performanceData.value.behavior || 0,
      totalScore: performanceData.value.totalScore || 0,
      performanceLevel: performanceData.value.performanceLevel || 'No Data'
    }
  }
  
  // Fallback if no data available
  return {
    academicPerformance: 0,
    behavior: 0,
    totalScore: 0,
    performanceLevel: 'No Data'
  }
})

definePageMeta({ layout: 'lecturer' })

// Chart logic
const performanceChart = ref<HTMLCanvasElement | null>(null)
let chartInstance: Chart | null = null

function renderChart() {
  if (!performanceChart.value) return;
  if (chartInstance) chartInstance.destroy();

  const ctx = performanceChart.value.getContext('2d');
  if (!ctx) return;

  const categories = kpiCategories.value;
  const ringThickness = 60;
  const ringSpacing = -60;

  addLog('Rendering chart with API data')

  const datasets = categories.map((cat, index) => {
    const outerRadius = 100 - (index * (ringThickness + ringSpacing));
    const innerRadius = outerRadius - ringThickness;
    
    const softGrey = '#E5E7EB';
    // Ensure remainingValue is never exactly zero for hover detection
    const remainingValue = Math.max(0.1, cat.weight - cat.value);

    return {
      data: [cat.value, remainingValue],
      backgroundColor: [cat.color, softGrey],
      cutout: `${innerRadius}%`,
      radius: `${outerRadius}%`,
      borderWidth: 2,
      borderRadius: [14, 14],
      rotation: -90,
      circumference: 360,
    };
  });

  chartInstance = new Chart(performanceChart.value, {
    type: 'doughnut',
    data: { datasets },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: {
        duration: 1000,
        easing: 'easeOutQuart',
      },
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            // Use a closure to capture the categories snapshot at render time
            label: (function(categoriesSnapshot) {
              return function (context) {
                const idx = context.datasetIndex;
                const cat = categoriesSnapshot[idx];
                if (!cat) return '';
                if (context.dataIndex === 0) {
                  return `${cat.name}: ${cat.value.toFixed(1)}% of ${cat.weight}%`;
                } else {
                  const remaining = cat.weight - cat.value;
                  return `Remaining: ${remaining.toFixed(1)}%`;
                }
              }
            })(categories),
          },
        },
      },
    },
    plugins: [
      {
        id: 'centerText',
        beforeDraw(chart) {
          const ctx = chart.ctx;
          const centerX = (chart.chartArea.left + chart.chartArea.right) / 2;
          const centerY = (chart.chartArea.top + chart.chartArea.bottom) / 2;

          ctx.save();
          ctx.font = 'bold 16px Arial';
          ctx.fillStyle = '#1f2937';
          ctx.textAlign = 'center';
          ctx.textBaseline = 'middle';
          ctx.fillText('Academic', centerX, centerY - 10);
          ctx.fillText('Performance', centerX, centerY + 10);
          ctx.restore();
        },
      },
    ],
  });
}

// Watch for changes in data and update chart
const stopDataWatcher = watch([mfuKpiData, kpiCategories], () => {
  // Only re-render if not currently loading AND data is available
  if (!loading.value && mfuKpiData.value) {
    addLog('Data source or data changed, re-rendering chart')
    renderChart();
  }
}, { deep: true, immediate: false }); // immediate: false ensures it doesn't run on initial setup


// Fetch data on initial mount and also when the component is activated
let chartInitialized = false; // Flag to ensure chart is initialized only once after data is ready

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  addLog(`🔄 Evaluation period changed to: ${selectedEvaluationPeriod.value}`)
  await loadKpiData()
  // Force chart re-render after data loads
  if (!loading.value) {
    addLog('🔄 Forcing chart re-render after evaluation period change')
    renderChart()
  }
}

const initializeComponentData = async () => {
  addLog('🚀 Initializing component data...')
  
  try {
    // Load evaluation periods first
    await fetchEvaluationPeriods()
    
    // Set default selected period to active period
    if (!selectedEvaluationPeriod.value && activeEvaluationPeriod.value) {
      selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
    }
    
    // Load KPI data
    await loadKpiData();
    
    if (Chart.registry) {
      const datalabelsPlugin = Chart.registry.plugins.get('datalabels');
      if (datalabelsPlugin) {
        Chart.unregister(datalabelsPlugin);
      }
    }
    
    addLog('📊 Initializing chart with API data...');
    renderChart();
    addLog('✅ Chart initialized successfully');
  } catch (error) {
    addLog('❌ Error initializing component: ' + (error instanceof Error ? error.message : String(error)), 'error')
    loading.value = false
  }
};

// Watch for evaluation period changes
watch(
  () => selectedEvaluationPeriod.value,
  (newEvalId, oldEvalId) => {
    if (newEvalId && newEvalId !== oldEvalId && user.value?.email && !loading.value) {
      addLog(`Evaluation period changed from ${oldEvalId} to ${newEvalId}`)
      onEvaluationPeriodChange()
    }
  }
)

// Watch for user email and fetch data when available
watch(
  () => user.value?.email,
  (email) => {
    if (email) {
      initializeComponentData();
    }
  },
  { immediate: true }
);

// Clean up chart instance when the component is unmounted
onUnmounted(() => {
  if (chartInstance) {
    chartInstance.destroy();
    addLog('Chart instance destroyed on unmount.')
  }
  // Stop the watcher when the component is unmounted to prevent memory leaks
  stopDataWatcher();
});
</script>