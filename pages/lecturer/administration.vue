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

    <!-- Administration Track -->
    <div class="mb-6">
      <h2 class="text-center text-lg font-medium text-gray-700 mb-1">Administration Track</h2>
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

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Administration Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 text-center">
          Administration Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold (30) - Earned score (115)
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
          <div class="max-h-[200px] overflow-y-auto">
            <div v-if="curricularLoading" class="flex justify-center items-center py-4">
              <div class="inline-block animate-spin rounded-full h-4 w-4 border-b-2 border-[#4697b9]"></div>
              <p class="ml-2 text-xs text-gray-600">Loading...</p>
            </div>
            <div v-else-if="curricularError" class="text-center py-4 text-xs text-red-600">
              Error loading data
            </div>
            <div v-else-if="curricularData.length === 0" class="text-center py-4 text-xs text-gray-500">
              No committee data available
            </div>
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">ID</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(item, index) in curricularData" :key="item.id" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ item.id }}</td>
                  <td class="px-3 py-1 text-center">{{ item.staff_name }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- School Committee Table -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">School Committee</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <div v-if="schoolLoading" class="flex justify-center items-center py-4">
              <div class="inline-block animate-spin rounded-full h-4 w-4 border-b-2 border-[#4697b9]"></div>
              <p class="ml-2 text-xs text-gray-600">Loading...</p>
            </div>
            <div v-else-if="schoolError" class="text-center py-4 text-xs text-red-600">
              Error loading data
            </div>
            <div v-else-if="schoolData.length === 0" class="text-center py-4 text-xs text-gray-500">
              No committee data available
            </div>
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">ID</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(item, index) in schoolData" :key="item.id" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ item.id }}</td>
                  <td class="px-3 py-1 text-center">{{ item.staff_name }}</td>
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
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import Chart from 'chart.js/auto'
import ChartDataLabels from 'chartjs-plugin-datalabels'
import { onMounted, ref, computed, watch, nextTick } from 'vue'
import { useKpiData } from '@/composables/useKpiData'
import { useAdministrationPerformance } from '@/composables/useAdministrationPerformance'
import { useCurricularCommittee } from '@/composables/useCurricularCommittee'
import { useSchoolCommittee } from '@/composables/useSchoolCommittee'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'

definePageMeta({
  layout: 'lecturer'
})

const administrationChart = ref<HTMLCanvasElement | null>(null)
const showMobileMenu = ref(false)
const { getKpiData } = useKpiData()
const { user, logout } = useFirebaseAuth()
const { administrationData, loading: isLoadingChart, error: chartError, fetchAdministrationPerformance, getChartData } = useAdministrationPerformance()
const { curricularData, loading: curricularLoading, error: curricularError, fetchCurricularCommittee } = useCurricularCommittee()
const { schoolData, loading: schoolLoading, error: schoolError, fetchSchoolCommittee } = useSchoolCommittee()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()

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

// Dynamic KPI categories from database
const kpiCategories = computed(() => {
  if (kpiData.value?.categories) {
    return kpiData.value.categories
  }
  // Return empty data if no database data available
  return [
    { name: 'Teaching', weight: 0, value: 0, color: '#1e40af', bgColor: '#dbeafe', textColor: '#1e40af' },
    { name: 'Research', weight: 0, value: 0, color: '#0891b2', bgColor: '#cffafe', textColor: '#0891b2' },
    { name: 'Academic Service', weight: 0, value: 0, color: '#059669', bgColor: '#d1fae5', textColor: '#059669' },
    { name: 'Administration', weight: 0, value: 0, color: '#7c3aed', bgColor: '#ede9fe', textColor: '#7c3aed' },
    { name: 'Arts and Culture', weight: 0, value: 0, color: '#dc2626', bgColor: '#fecaca', textColor: '#dc2626' }
  ]
})

// Load KPI data
const loadKpiData = async () => {
  try {
    loading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      console.log('Loading KPI data for:', user.value.email, 'evaluation period:', evalId)
      const data = await getKpiData(user.value.email, evalId)
      console.log('KPI data loaded:', data)
      kpiData.value = data as any
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
      fetchAdministrationPerformance(user.value.email, selectedEvaluationPeriod.value.toString()),
      fetchCurricularCommittee(user.value.email, selectedEvaluationPeriod.value.toString()),
      fetchSchoolCommittee(user.value.email, selectedEvaluationPeriod.value.toString()),
      loadKpiData()
    ])
    initializeChart()
  }
}

// Initialize chart with data
const initializeChart = () => {
  if (!administrationChart.value) return
  
  // Destroy existing chart
  if (chartInstance) {
    chartInstance.destroy()
  }
  
  let chartData;
  
  if (administrationData.value.length > 0) {
    chartData = getChartData();
  } else {
    // Show empty chart with zero values using same template structure
    chartData = {
      labels: [
        ['Academic Administration assigned', 'by the School or University'],
        ['Coordination with Guest Lecturer'],
        'Course Coordination',
        ['University\'s Committee or', 'Committee-Appointed Working Group'],
        ['School\'s Committee or', 'Committee-Appointed Working Group'],
        'School Committee',
        'Curricular Committee',
        ['Administrative duty assigned', 'by the school']
      ],
      datasets: [
        {
          label: "Score",
          data: [0, 0, 0, 0, 0, 0, 0, 0],
          backgroundColor: "#172554",
          borderWidth: 0,
          borderRadius: 0,
        },
      ],
    };
  }
  
  chartInstance = new Chart(administrationChart.value, {
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
          max: 180,
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
  
  // Load administration performance data
  if (user.value?.email) {
    await Promise.all([
      fetchAdministrationPerformance(user.value.email, selectedEvaluationPeriod.value?.toString()),
      fetchCurricularCommittee(user.value.email, selectedEvaluationPeriod.value?.toString()),
      fetchSchoolCommittee(user.value.email, selectedEvaluationPeriod.value?.toString())
    ])
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
        fetchAdministrationPerformance(email, selectedEvaluationPeriod.value?.toString()),
        fetchCurricularCommittee(email, selectedEvaluationPeriod.value?.toString()),
        fetchSchoolCommittee(email, selectedEvaluationPeriod.value?.toString())
      ])
      // Re-initialize chart with new data
      initializeChart()
    }
  },
  { immediate: true }
)
</script>