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
        <p class="text-sm text-inherit">Teaching ({{ kpiCategories[0]?.weight || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiCategories[0]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Research ({{ kpiCategories[1]?.weight || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiCategories[1]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Academic Service ({{ kpiCategories[2]?.weight || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiCategories[2]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Administration ({{ kpiCategories[3]?.weight || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiCategories[3]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Arts and Culture ({{ kpiCategories[4]?.weight || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ kpiCategories[4]?.value || 0 }}%</p>
      </NuxtLink>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Teaching Track Chart -->
      <div class="lg:col-span-2 bg-white rounded-xl shadow-sm border border-gray-100 p-6">
        <div class="text-center mb-6">
          <h2 class="text-lg font-semibold text-gray-900">Teaching Track</h2>
          <p class="text-sm text-gray-500 mt-1">11 Feb 2025 - 31 July 2025</p>
        </div>
        
        <!-- Chart Container -->
        <div class="relative h-80 mx-auto" style="max-width: 400px">
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
            <div v-if="selectedRound">
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Academic Performance (60%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ mockData.academicPerformance }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div 
                  class="bg-blue-600 h-2 rounded-full"
                  :style="{ width: mockData.academicPerformance + '%' }"
                ></div>
              </div>
            </div>
            
            <div v-if="selectedRound">
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Behavior (40%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ mockData.behavior }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div 
                  class="bg-green-600 h-2 rounded-full"
                  :style="{ width: mockData.behavior + '%' }"
                ></div>
              </div>
            </div>
            
            <div v-if="selectedRound">
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Total Score (100%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ mockData.totalScore }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-indigo-600 h-2 rounded-full"
                  :style="{ width: mockData.totalScore + '%' }"
                ></div>
              </div>
            </div>

            <div class="pt-4 border-t border-gray-200" v-if="selectedRound">
              <div class="flex justify-between items-center">
                <span class="text-sm font-medium text-gray-700"
                  >Performance Level</span
                >
                <span 
                  class="px-3 py-1 text-sm font-medium bg-yellow-100 text-yellow-800 rounded-full"
                  >{{ mockData.performanceLevel }}</span
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
import { ref, onMounted, computed } from "vue";
import Chart from "chart.js/auto";
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import { useKpiData } from '@/composables/useKpiData'

const { user, logout } = useFirebaseAuth()
const { getKpiData } = useKpiData()

// Reactive data
const selectedRound = ref('round2-2025')
const kpiData = ref<any>(null)
const loading = ref(true)

// Dynamic KPI categories from database
const kpiCategories = computed(() => {
  if (kpiData.value?.categories) {
    return kpiData.value.categories
  }
  // Fallback to mock data
  return [
    { name: 'Teaching', weight: 60, value: 60, color: '#1e40af', bgColor: '#dbeafe', textColor: '#1e40af' },
    { name: 'Research', weight: 15, value: 15, color: '#0891b2', bgColor: '#cffafe', textColor: '#0891b2' },
    { name: 'Academic Service', weight: 10, value: 10, color: '#059669', bgColor: '#d1fae5', textColor: '#059669' },
    { name: 'Administration', weight: 5, value: 5, color: '#7c3aed', bgColor: '#ede9fe', textColor: '#7c3aed' },
    { name: 'Arts and Culture', weight: 10, value: 3.75, color: '#dc2626', bgColor: '#fecaca', textColor: '#dc2626' }
  ]
})

// Load KPI data
const loadKpiData = async () => {
  try {
    loading.value = true
    if (user.value?.email) {
      console.log('Loading KPI data for:', user.value.email)
      const data = await getKpiData(user.value.email)
      console.log('KPI data loaded:', data)
      kpiData.value = data as any
    }
  } catch (err) {
    console.error('Failed to load KPI data:', err)
  } finally {
    loading.value = false
  }
}

const mockData = computed(() => ({
  academicPerformance: 96.25,
  behavior: 36,
  totalScore: 92.25,
  performanceLevel: 'Excellent'
}))

definePageMeta({ layout: 'lecturer' })

function onRoundChange() {
  console.log('Round changed to:', selectedRound.value)
}

// Chart logic
const performanceChart = ref<HTMLCanvasElement | null>(null)
let chartInstance: Chart | null = null

function renderChart() {
  if (!performanceChart.value) return;
  if (chartInstance) chartInstance.destroy();
  
  const categories = kpiCategories.value;
  const totalCategories = categories.length;
  
  // Create radial chart with multiple rings
  const datasets = categories.map((cat: any, idx: number) => {
    // Calculate the size of the ring (thickness and position)
    const ringThickness = 12; // pixels
    const ringSpacing = 8;    // pixels between rings
    
    // Calculate radius and cutout to create concentric rings
    const outerRadius = 100 - ((ringThickness + ringSpacing) * idx);
    const innerRadius = outerRadius - ringThickness;
    
    return {
      data: [cat.value, 100 - cat.value],
      backgroundColor: [cat.color, 'transparent'],
      borderWidth: 0,
      cutout: `${innerRadius}%`,
      radius: `${outerRadius}%`,
      circumference: 360,
      rotation: -90,
      spacing: 0,
      weight: 1,
    };
  });
  
  // Get the 2D context for custom drawing
  const ctx = performanceChart.value.getContext('2d');
  if (!ctx) return;
  
  // Create the chart
  chartInstance = new Chart(performanceChart.value, {
    type: 'doughnut',
    data: { datasets },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: {
        animateRotate: false,
        animateScale: false
      },
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function(context) {
              const category = categories[context.datasetIndex];
              return [
                category.name,
                `Value: ${category.value}%`,
                `Weight: ${category.weight}%`
              ];
            }
          }
        }
      },
      // Add center text
      onHover: (event, elements) => {
        const canvas = performanceChart.value;
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        if (!ctx) return;
        
        // Redraw the chart to clear any hover effects
        chartInstance?.update();
      }
    },
    plugins: [{
      id: 'centerText',
      beforeDraw: function(chart) {
        if (!chart.ctx) return;
        
        const width = chart.width;
        const height = chart.height;
        const ctx = chart.ctx;
        
        ctx.restore();
        
        // Draw center text
        ctx.font = 'bold 20px Arial';
        ctx.fillStyle = '#374151';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        
        // Center text position
        const centerX = (chart.chartArea.left + chart.chartArea.right) / 2;
        const centerY = (chart.chartArea.top + chart.chartArea.bottom) / 2;
        
        // Draw main text
        ctx.font = 'bold 16px Arial';
        ctx.fillText('Academic', centerX, centerY - 10);
        ctx.font = 'bold 16px Arial';
        ctx.fillText('Performance', centerX, centerY + 10);
        
        ctx.save();
      }
    }]
  });
}

onMounted(() => {
  renderChart()
  loadKpiData()
})
</script>
