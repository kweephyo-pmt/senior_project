<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6 sm:mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">
          Domain 2: Research Performance
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

    <!-- Research Track -->
    <div class="mb-6">
      <h2 class="text-center text-lg font-medium text-gray-700 mb-1">Research Track</h2>
      <p class="text-center text-sm text-gray-500 mb-4">{{ formatDateRange() }}</p>
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
      <!-- Research Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 text-center">
          Research Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold (25) - Earned score (94.93)
        </p>
        <div class="h-[300px] sm:h-[360px] w-full">
          <canvas ref="researchChart"></canvas>
        </div>
      </div>

      <!-- Tables stacked vertically in a card column -->
      <div class="flex flex-col gap-6">
        <!-- Research Studies -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Research Studies</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <!-- Loading state -->
            <div v-if="studiesLoading" class="flex justify-center items-center py-8">
              <div class="inline-block animate-spin rounded-full h-6 w-6 border-b-2 border-[#4697b9]"></div>
              <p class="ml-2 text-xs text-gray-600">Loading studies...</p>
            </div>
            <!-- No data state -->
            <div v-else-if="researchStudiesData.length === 0" class="text-center py-8">
              <p class="text-xs text-gray-500">No research studies found</p>
            </div>
            <!-- Data table -->
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">Level</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Project Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(study, index) in researchStudiesData" :key="study.id" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ study.level }}</td>
                  <td class="px-3 py-1">{{ study.projectName }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <!-- Research Publication -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Research Publication</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <!-- Loading state -->
            <div v-if="publicationsLoading" class="flex justify-center items-center py-8">
              <div class="inline-block animate-spin rounded-full h-6 w-6 border-b-2 border-[#4697b9]"></div>
              <p class="ml-2 text-xs text-gray-600">Loading publications...</p>
            </div>
            <!-- No data state -->
            <div v-else-if="researchPublicationsData.length === 0" class="text-center py-8">
              <p class="text-xs text-gray-500">No research publications found</p>
            </div>
            <!-- Data table -->
            <table v-else class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">Level</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Project Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(publication, index) in researchPublicationsData" :key="publication.id" :class="index % 2 === 1 ? 'bg-[#E8F4FC]' : ''">
                  <td class="px-3 py-1 text-center">{{ publication.level }}</td>
                  <td class="px-3 py-1">{{ publication.projectName }}</td>
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
import Chart from "chart.js/auto";
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { onMounted, ref, nextTick } from "vue";
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useKpiData } from '@/composables/useKpiData'
import { useResearchPerformance } from '@/composables/useResearchPerformance'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'
import { useResearchStudies } from '@/composables/useResearchStudies'
import { useResearchPublications } from '@/composables/useResearchPublications'


definePageMeta({
  layout: "lecturer",
});
const researchChart = ref<HTMLCanvasElement | null>(null);
const { getKpiData } = useKpiData()
const { user,logout } = useFirebaseAuth()
const { researchData, loading: researchLoading, error: researchError, fetchResearchPerformance, getChartData } = useResearchPerformance()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()
const { getResearchStudies, formatResearchStudiesData } = useResearchStudies()
const { getResearchPublications, formatResearchPublicationsData } = useResearchPublications()

// Reactive data
const selectedRound = ref('round2-2025')
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
const loading = ref(true)
const researchStudiesData = ref<any[]>([])
const researchPublicationsData = ref<any[]>([])
const studiesLoading = ref(false)
const publicationsLoading = ref(false)

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (selectedEvaluationPeriod.value && user.value?.email) {
    await Promise.all([
      fetchResearchPerformance(user.value.email, selectedEvaluationPeriod.value.toString()),
      loadKpiData(),
      loadResearchStudies(),
      loadResearchPublications()
    ])
    nextTick(() => {
      createChart()
    })
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

// Load research studies data
const loadResearchStudies = async () => {
  try {
    studiesLoading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getResearchStudies(user.value.email, evalId)
      if (response.success) {
        researchStudiesData.value = formatResearchStudiesData(response.data)
      } else {
        researchStudiesData.value = []
      }
    }
  } catch (err) {
    console.error('Failed to load research studies:', err)
    researchStudiesData.value = []
  } finally {
    studiesLoading.value = false
  }
}

// Load research publications data
const loadResearchPublications = async () => {
  try {
    publicationsLoading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getResearchPublications(user.value.email, evalId)
      if (response.success) {
        researchPublicationsData.value = formatResearchPublicationsData(response.data)
      } else {
        researchPublicationsData.value = []
      }
    }
  } catch (err) {
    console.error('Failed to load research publications:', err)
    researchPublicationsData.value = []
  } finally {
    publicationsLoading.value = false
  }
}
// Register the plugin
Chart.register(ChartDataLabels);

let chartInstance: Chart | null = null;

const createChart = () => {
  if (researchChart.value) {
    // Destroy existing chart if it exists
    if (chartInstance) {
      chartInstance.destroy();
    }

    let chartData;
    
    if (researchData.value.length > 0) {
      chartData = getChartData();
    } else {
      // Show empty chart with zero values using same template structure
      chartData = {
        labels: [
          ['Other Academic Work assigned', 'by the School'],
          'Other Academic Work',
          'Patented Inventions',
          ['Composition of textbooks, Books,', 'and interactive/e-Learning Materials'],
          'Academic Articles',
          'Research Publication',
          'Research Studies'
        ],
        datasets: [
          {
            label: "Score",
            data: [0, 0, 0, 0, 0, 0, 0],
            backgroundColor: "#172554",
            borderWidth: 0,
            borderRadius: 0,
          },
        ],
      };
    }
    
    chartInstance = new Chart(researchChart.value, {
      type: "bar",
      data: chartData,
      options: {
        indexAxis: "y" as const,
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          x: {
            stacked: true,
            beginAtZero: true,
            max: 180,
            grid: {
              color: "#E5E7EB",
              drawTicks: false
            },
            border: {
              display: false
            },
            ticks: {
              color: "#64748B",
              padding: 8,
              font: {
                size: 10
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
            border: {
              display: false
            },
            ticks: {
              color: "#64748B",
              padding: 16,
              font: {
                size: 10
              },
              callback: function(value: string | number) {
                const numValue = typeof value === 'string' ? parseFloat(value) : value;
                const label = this.getLabelForValue(numValue);
                return Array.isArray(label) ? label : [label];
              }
            }
          },
        },
        plugins: {
          legend: {
            display: false,
          },
          tooltip: {
            backgroundColor: "#1E293B",
            titleFont: {
              size: 13
            },
            bodyFont: {
              size: 12
            },
            padding: 12,
            cornerRadius: 4
          },
          datalabels: {
            display: true,
            align: 'end',
            anchor: 'end',
            formatter: function(value, context) {
              // Only show the total for each group
              if (context.datasetIndex === context.chart.data.datasets.length - 1) {
                const total = context.chart.data.datasets.reduce((sum, dataset) => {
                  const dataValue = dataset.data[context.dataIndex];
                  // Only add if it's a number
                  return typeof dataValue === 'number' ? sum + dataValue : sum;
                }, 0);
                return total;
              }
              return null;
            },
            color: '#64748B',
            font: {
              size: 14,
              weight: 'bold'
            },
            padding: {
              left: 10
            }
          }
        },
      },
    });
  }
};

onMounted(async () => {
  // Load evaluation periods first
  await fetchEvaluationPeriods()
  
  // Set default to active evaluation period
  if (activeEvaluationPeriod.value) {
    selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
  }
  
  // Load KPI data and research data when component mounts
  if (user.value?.email) {
    await Promise.all([
      loadKpiData(),
      fetchResearchPerformance(user.value.email),
      loadResearchStudies(),
      loadResearchPublications()
    ]);
  }
});

import { watch } from "vue";

// Watch for research data changes and create chart
watch(
  () => researchData.value,
  (data) => {
    if (data && data.length > 0) {
      nextTick(() => {
        createChart();
      });
    }
  },
  { deep: true }
);

watch(
  () => user.value?.email,
  async (email) => {
    if (email) {
      loadKpiData();
      await fetchEvaluationPeriods();
      
      // Set default to active evaluation period
      if (activeEvaluationPeriod.value) {
        selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid;
      }
      
      await Promise.all([
        fetchResearchPerformance(email),
        loadResearchStudies(),
        loadResearchPublications()
      ]);
    }
  },
  { immediate: true }
);
</script>

