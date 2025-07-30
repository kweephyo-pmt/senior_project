<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900">
          KPI Performance Overview
        </h1>
        <p class="text-sm sm:text-base text-gray-600">Welcome back, {{ user?.displayName }}</p>
      </div>
      <div class="relative w-full sm:w-auto">
        <select
          class="w-full sm:w-auto appearance-none bg-white border-0  rounded-lg py-2 pl-4 pr-10 shadow-sm ring-2 ring-[#4697b9] text-sm"
        >
          <option>Round 2/2025</option>
          <option>Round 1/2025</option>
          <option>Round 2/2024</option>
        </select>
        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
          <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </div>
      </div>
    </div>

     <!-- KPI Categories with NuxtLink-->
     <div class="grid grid-cols-2 sm:grid-3 lg:grid-cols-5 gap-3 sm:gap-4 mb-6 sm:mb-8">
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
        <p class="text-sm text-inherit">Research (15%)</p>
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
        <p class="text-sm text-inherit">Academic Service (10%)</p>
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
        <p class="text-sm text-inherit">Administration (5%)</p>
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

    <div v-if="!loading" class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Teaching Track Chart -->
      <div class="lg:col-span-2 bg-white rounded-xl shadow-sm border border-gray-100 p-6">
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
              {{ category.name }} ({{ category.weight }}%)
            </span>
          </div>
        </div>
      </div>

      <!-- Performance Metrics -->
      <div class="lg:col-span-1">
        <div class="bg-white rounded-lg shadow-md p-4 sm:p-6 mb-6 sm:mb-8">
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
                  :style="{ width: overallPerformance.academicPerformance + '%' }"
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
                  :style="{ width: overallPerformance.behavior + '%' }"
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
import Chart from "chart.js/auto";
import { computed, onMounted, ref, watch, onActivated, onUnmounted } from "vue";

// Try to import the composable
let getKpiData: any = null;
try {
  const kpiComposable = await import('@/composables/useKpiData');
  getKpiData = kpiComposable.useKpiData?.().getKpiData;
} catch (error) {
  console.warn('KPI composable not available. Data fetching will be skipped.', error);
}

const { user, logout } = useFirebaseAuth()

// State management
const loading = ref(true)
const kpiData = ref<any>(null)
const fetchError = ref<string | null>(null)
const dataSource = ref<'database' | 'fallback'>('fallback')

// Fixed KPI weights
const FIXED_KPI_WEIGHTS = {
  teaching: 60,
  research: 15,
  academicService: 10,
  administration: 5,
  artsCulture: 10
}

// Fallback data
const fallbackKpiData = {
  teaching: 45.5,
  research: 8.2,
  academicService: 6.1,
  administration: 2.8,
  artsCulture: 7.3
}

const fallbackPerformanceData = {
  academicPerformance: 96.25,
  behavior: 36,
  totalScore: 92.25,
  performanceLevel: 'Excellent'
}

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

// Load KPI data from database
const loadKpiData = async () => {
  try {
    loading.value = true
    fetchError.value = null
    
    addLog('Starting KPI data fetch...')
    
    if (!getKpiData) {
      throw new Error('KPI composable not available')
    }
    
    if (!user.value?.email) {
      throw new Error('User email not available')
    }
    
    addLog('Loading KPI data for: ' + user.value.email)
    
    const timeoutPromise = new Promise((_, reject) => 
      setTimeout(() => reject(new Error('Request timeout')), 10000)
    )
    
    const dataPromise = getKpiData(user.value.email)
    const data = await Promise.race([dataPromise, timeoutPromise])
    
    addLog('Raw KPI data received:')
    console.log('Raw Data:', data)
    
    if (data && typeof data === 'object') {
      kpiData.value = data as any
      dataSource.value = 'database'
      addLog('✅ Successfully loaded data from database')
    } else {
      throw new Error('Invalid data format received')
    }
    
  } catch (err) {
    const errorMessage = err instanceof Error ? err.message : String(err)
    addLog('❌ Failed to load KPI data: ' + errorMessage, 'error')
    fetchError.value = errorMessage
    dataSource.value = 'fallback'
    kpiData.value = null
    addLog('📝 Using fallback data instead')
  } finally {
    loading.value = false
  }
}

// Retry fetch function
const retryFetch = async () => {
  addLog('🔄 Retrying data fetch...')
  await loadKpiData()
}

// Enhanced data parsing
const currentKpiData = computed(() => {
  if (dataSource.value === 'database' && kpiData.value) {
    addLog('Parsing database KPI data...')
    
    // Strategy 1: Look for categories array
    if (kpiData.value.categories && Array.isArray(kpiData.value.categories)) {
      const mapped: any = {}
      kpiData.value.categories.forEach((cat: any) => {
        if (cat.key && typeof cat.value !== 'undefined') {
          mapped[cat.key] = parseFloat(cat.value) || 0
        } else if (cat.name) { // Map by name if key is not available
          const name = cat.name.toLowerCase().replace(/\s+/g, '')
          if (name.includes('teaching')) mapped.teaching = parseFloat(cat.value) || 0
          else if (name.includes('research')) mapped.research = parseFloat(cat.value) || 0
          else if (name.includes('academic') || name.includes('service')) mapped.academicService = parseFloat(cat.value) || 0
          else if (name.includes('administration')) mapped.administration = parseFloat(cat.value) || 0
          else if (name.includes('arts') || name.includes('culture')) mapped.artsCulture = parseFloat(cat.value) || 0
        }
      })
      return mapped
    }
    
    // Strategy 2: Look for direct properties
    if (typeof kpiData.value.teaching !== 'undefined' || 
        typeof kpiData.value.research !== 'undefined') {
      return {
        teaching: parseFloat(kpiData.value.teaching) || 0,
        research: parseFloat(kpiData.value.research) || 0,
        academicService: parseFloat(kpiData.value.academicService || kpiData.value.academic_service) || 0,
        administration: parseFloat(kpiData.value.administration) || 0,
        artsCulture: parseFloat(kpiData.value.artsCulture || kpiData.value.arts_culture) || 0
      }
    }
    
    // Strategy 3: Look for nested data
    if (kpiData.value.data && typeof kpiData.value.data === 'object') {
      return currentKpiData.value // Recursively process nested data
    }
    
    // Strategy 4: Look for any numeric values
    const numericFields = Object.keys(kpiData.value).filter(key => 
      typeof kpiData.value[key] === 'number' && kpiData.value[key] >= 0
    )
    
    if (numericFields.length >= 5) {
      return {
        teaching: parseFloat(kpiData.value[numericFields[0]]) || 0,
        research: parseFloat(kpiData.value[numericFields[1]]) || 0,
        academicService: parseFloat(kpiData.value[numericFields[2]]) || 0,
        administration: parseFloat(kpiData.value[numericFields[3]]) || 0,
        artsCulture: parseFloat(kpiData.value[numericFields[4]]) || 0
      }
    }
    
    addLog('Could not parse database structure, using fallback')
  }
  
  addLog('Using fallback KPI data')
  return fallbackKpiData
})

// KPI categories with enhanced data mapping
const kpiCategories = computed(() => {
  const currentValues = currentKpiData.value
  
  const categories = [
    { 
      name: 'Teaching', 
      weight: FIXED_KPI_WEIGHTS.teaching,
      value: currentValues.teaching || 0,
      color: '#005F99', 
      key: 'teaching' 
    },
    { 
      name: 'Research', 
      weight: FIXED_KPI_WEIGHTS.research,
      value: currentValues.research || 0,
      color: '#00BFFF', 
      key: 'research' 
    },
    { 
      name: 'Academic Service', 
      weight: FIXED_KPI_WEIGHTS.academicService,
      value: currentValues.academicService || 0,
      color: '#7FD6D6', 
      key: 'academicService' 
    },
    { 
      name: 'Administration', 
      weight: FIXED_KPI_WEIGHTS.administration,
      value: currentValues.administration || 0,
      color: '#7c3aed', 
      key: 'administration' 
    },
    { 
      name: 'Arts and Culture', 
      weight: FIXED_KPI_WEIGHTS.artsCulture,
      value: currentValues.artsCulture || 0,
      color: '#8A8BE6', 
      key: 'artsCulture' 
    }
  ]
  
  addLog('Final KPI categories computed')
  return categories
})

// Overall performance data
const overallPerformance = computed(() => {
  if (dataSource.value === 'database' && kpiData.value?.performance) {
    return kpiData.value.performance
  }
  
  if (dataSource.value === 'database' && kpiData.value?.academicPerformance !== undefined) {
    return {
      academicPerformance: kpiData.value.academicPerformance || 0,
      behavior: kpiData.value.behavior || 0,
      totalScore: kpiData.value.totalScore || 0,
      performanceLevel: kpiData.value.performanceLevel || 'No Data'
    }
  }
  
  return fallbackPerformanceData
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

  addLog('Rendering chart with data from: ' + dataSource.value)

  const datasets = categories.map((cat, index) => {
    const outerRadius = 100 - (index * (ringThickness + ringSpacing));
    const innerRadius = outerRadius - ringThickness;
    
    const softGrey = '#E5E7EB';
    const remainingValue = Math.max(0, cat.weight - cat.value);

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
        animateRotate: true,
        duration: 1000,
        easing: 'easeOutQuart',
      },
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function (context) {
              const idx = context.datasetIndex;
              const cat = categories[idx];
              if (context.dataIndex === 0) {
                return `${cat.name}: ${cat.value.toFixed(1)}% of ${cat.weight}%`;
              } else {
                const remaining = cat.weight - cat.value;
                return `Remaining: ${remaining.toFixed(1)}%`;
              }
            },
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
const stopDataWatcher = watch([kpiData, dataSource], () => {
  // Only re-render if not currently loading AND data is available
  if (!loading.value && (kpiData.value || dataSource.value === 'fallback')) {
    addLog('Data source or data changed, re-rendering chart')
    renderChart();
  }
}, { deep: true, immediate: false }); // immediate: false ensures it doesn't run on initial setup


// Fetch data on initial mount and also when the component is activated
let chartInitialized = false; // Flag to ensure chart is initialized only once after data is ready

const initializeComponentData = async () => {
  addLog('🚀 Initializing component data...')
  await loadKpiData();
  
  if (Chart.registry) {
    const datalabelsPlugin = Chart.registry.plugins.get('datalabels');
    if (datalabelsPlugin) {
      Chart.unregister(datalabelsPlugin);
    }
  }
  
  addLog('📊 Initializing chart with ' + dataSource.value + ' data...');
  renderChart();
  addLog('✅ Chart initialized successfully');
};

// Fetch data on mount
onMounted(initializeComponentData);

// Fetch data when component is activated
onActivated(initializeComponentData);

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