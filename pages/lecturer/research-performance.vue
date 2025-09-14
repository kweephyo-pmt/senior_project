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
    <div v-if="mfuResearchError && !loading" class="mb-6 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
      <div class="flex items-start">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <h3 class="text-sm font-medium text-yellow-800">MFU API Connection Issue</h3>
          <div class="mt-2 text-sm text-yellow-700">
            <p>{{ mfuResearchError }}</p>
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
    <div v-if="!loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Research Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-4 sm:p-6">
        <h2 class="text-lg sm:text-xl font-bold text-gray-900 mb-2 text-center">
          Research Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 text-center mb-4 sm:mb-6">
          Threshold ({{ getDomainThreshold('domain2') }}) - Earned score ({{ getDomainScore('domain2') }})
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
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'
import { useMfuResearchApi } from '@/composables/useMfuResearchApi'
import { useMfuKpiApi } from '@/composables/useMfuKpiApi'


definePageMeta({
  layout: "lecturer",
});
const researchChart = ref<HTMLCanvasElement | null>(null);
const { user,logout } = useFirebaseAuth()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()
const { getResearchStudies, getResearchPublications, getAllResearchChartData, formatResearchStudiesData, formatResearchPublicationsData, isLoading: mfuResearchLoading, error: mfuResearchError } = useMfuResearchApi()
const { kpiData: mfuKpiData, isLoading: kpiLoading, fetchKpiPercentages } = useMfuKpiApi()

// Reactive data
const selectedRound = ref('round2-2025')
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
const loading = ref(true)
const researchStudiesData = ref<any[]>([])
const researchPublicationsData = ref<any[]>([])
const researchChartData = ref<any>(null)
const studiesLoading = ref(false)
const publicationsLoading = ref(false)
const chartLoading = ref(false)

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (selectedEvaluationPeriod.value && user.value?.email) {
    await Promise.all([
      loadKpiData(),
      loadResearchStudies(), // Now uses MFU API
      loadResearchPublications(),
      loadResearchChartData() // Load chart data from seven APIs
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
// KPI weights computed from MFU API - updated to use the new structure
const kpiWeights = computed(() => {
  if (mfuKpiData.value) {
    return {
      domainScoreName: mfuKpiData.value.domainScoreName || 'Research',
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
      await fetchKpiPercentages(user.value.email, evalId)
      kpiData.value = mfuKpiData.value as any
    }
  } catch (err) {
    console.error('Failed to load KPI data:', err)
  } finally {
    loading.value = false
  }
}

// Load research studies data from MFU API
const loadResearchStudies = async () => {
  try {
    studiesLoading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getResearchStudies(user.value.email, evalId.toString())
      researchStudiesData.value = formatResearchStudiesData(response.data)
    }
  } catch (err) {
    // Provide fallback data when API fails
    researchStudiesData.value = [
      { id: 1, level: 1, projectName: 'Sample Research Study (API unavailable)' },
      { id: 2, level: 2, projectName: 'Another Research Project (API unavailable)' }
    ]
  } finally {
    studiesLoading.value = false
  }
}

// Load research publications data from MFU API
const loadResearchPublications = async () => {
  try {
    publicationsLoading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getResearchPublications(user.value.email, evalId.toString())
      researchPublicationsData.value = formatResearchPublicationsData(response.data)
    }
  } catch (err) {
    // Provide fallback data when API fails
    researchPublicationsData.value = [
      { id: 1, level: 1, projectName: 'Sample Research Publication (API unavailable)' },
      { id: 2, level: 2, projectName: 'Another Research Publication (API unavailable)' }
    ]
  } finally {
    publicationsLoading.value = false
  }
}

// Load research chart data from seven MFU API endpoints
const loadResearchChartData = async () => {
  try {
    chartLoading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      const response = await getAllResearchChartData(user.value.email, evalId.toString())
      researchChartData.value = response
    }
  } catch (err) {
    researchChartData.value = null
  } finally {
    chartLoading.value = false
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

    // Create chart with real API data from seven endpoints
    let chartData;
    
    if (researchChartData.value) {
      // Extract scores from API data - sum up all scores for each category
      const extractScore = (dataArray: any[], categoryName: string) => {
        if (!Array.isArray(dataArray) || dataArray.length === 0) return 0
        return dataArray.reduce((sum, item) => {
          // Try multiple possible score property names based on teaching performance pattern
          const score = parseFloat(
            item.score || 
            item.rawscore || 
            item.total_score || 
            item.totalscore || 
            item.sumscore ||
            item.scorelect ||
            item.scorelab ||
            item.Score || 
            item.RawScore || 
            item.TotalScore ||
            item.SumScore ||
            0
          )
          return sum + (isNaN(score) ? 0 : score)
        }, 0)
      }

      const scores = [
        extractScore(researchChartData.value.otherAcademicWorkAssignedBySchool, 'otherAcademicWorkAssignedBySchool'),
        extractScore(researchChartData.value.otherAcademicWork, 'otherAcademicWork'),
        extractScore(researchChartData.value.patentedInventions, 'patentedInventions'),
        extractScore(researchChartData.value.compositionofTextbooks, 'compositionofTextbooks'),
        extractScore(researchChartData.value.academicArticlesRawscore, 'academicArticlesRawscore'),
        extractScore(researchChartData.value.researchPublicationRawscore, 'researchPublicationRawscore'),
        extractScore(researchChartData.value.researchStudiesRawscore, 'researchStudiesRawscore')
      ]

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
            data: scores,
            backgroundColor: "#172554",
            borderWidth: 0,
            borderRadius: 0,
          },
        ],
      };
    } else {
      // Fallback chart with zero values when API data is not available
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
              drawTicks: true,
              display: true
            },
            border: {
              display: true,
              color: "#D1D5DB",
              width: 1
            },
            ticks: {
              color: "#64748B",
              padding: 8,
              font: {
                size: 11,
                weight: 500
              },
              display: true,
              stepSize: 20
            },
            title: {
              display: true,
              text: 'Raw Score',
              color: "#374151",
              font: {
                size: 14,
                weight: 'bold'
              },
              padding: {
                top: 10
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
      loadResearchStudies(),
      loadResearchPublications(),
      loadResearchChartData()
    ]);
  }
});

import { watch } from "vue";

// Watch for research chart data changes and create chart
watch(
  () => researchChartData.value,
  (data) => {
    nextTick(() => {
      createChart();
    });
  },
  { deep: true }
);

// Watch for evaluation period changes and reload data
watch(
  () => selectedEvaluationPeriod.value,
  async (newPeriod) => {
    if (newPeriod && user.value?.email) {
      await Promise.all([
        loadResearchStudies(),
        loadResearchPublications(),
        loadResearchChartData()
      ]);
    }
  }
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
        loadResearchStudies(),
        loadResearchPublications(),
        loadResearchChartData(),
        fetchKpiPercentages(email)
      ]);
    }
  },
  { immediate: true }
);
</script>

