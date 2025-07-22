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
        <div
          class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700"
        >
          <svg
            class="h-4 w-4"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 20 20"
            fill="currentColor"
          >
            <path
              fill-rule="evenodd"
              d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
              clip-rule="evenodd"
            />
          </svg>
        </div>
      </div>
    </div>

     <!-- KPI Categories with NuxtLink-->
     <div v-if="selectedRound" class="grid grid-cols-2 sm:grid-3 lg:grid-cols-5 gap-3 sm:gap-4 mb-6 sm:mb-8">
      <NuxtLink
        to="/lecturer/teaching-performance"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/teaching-performance'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">Teaching ({{ selectedRound?.categories[0]?.percent || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ selectedRound?.categories[0]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Research ({{ selectedRound?.categories[1]?.percent || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ selectedRound?.categories[1]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Academic Service ({{ selectedRound?.categories[2]?.percent || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ selectedRound?.categories[2]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Administration ({{ selectedRound?.categories[3]?.percent || 0 }}%)</p>
        <p class="text-xl font-bold text-inherit">{{ selectedRound?.categories[3]?.value || 0 }}%</p>
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
        <p class="text-sm text-inherit">Arts and culture (10%)</p>
        <p class="text-xl font-bold text-inherit">{{ selectedRound?.categories[4]?.value || 0 }}%</p>
      </NuxtLink>
    </div>


    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <!-- Teaching Track Chart -->
      <div class="md:col-span-2 bg-white rounded-lg shadow-md p-6">
        <h2 class="text-center text-lg font-medium text-gray-700 mb-1">
          Teaching Track
        </h2>
        <p class="text-center text-sm text-gray-500 mb-6">
          <template v-if="isLoading">Loading...</template>
          <template v-else-if="error">{{ error }}</template>
          <template v-else-if="selectedRound">
            {{ formatDate(selectedRound.startDate) }}-{{ formatDate(selectedRound.endDate) }}
          </template>
        </p>
        <div class="relative w-full h-[250px] sm:h-[300px]">
          <canvas ref="performanceChart"></canvas>
        </div>

        <!-- Chart Legend -->
        <div class="mt-4 sm:mt-6 flex flex-wrap justify-center gap-3 sm:gap-4">
          <div
            v-for="cat in selectedRound?.categories"
            :key="cat.name"
            class="flex items-center"
          >
            <span class="w-2.5 sm:w-3 h-2.5 sm:h-3 rounded-full mr-1.5 sm:mr-2" :style="{ backgroundColor: cat.color }"></span>
            <span class="text-xs sm:text-sm text-gray-700">{{ cat.name }}</span>
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
                <span class="text-sm font-medium text-gray-700">{{ academicPerformance }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-blue-600 h-2 rounded-full"
                  :style="{ width: academicPerformance + '%' }"
                ></div>
              </div>
            </div>

            <div v-if="selectedRound">
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Behavior (40%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ behavior }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-green-600 h-2 rounded-full"
                  :style="{ width: kpiData.behavior + '%' }"
                ></div>
              </div>
            </div>

            <div v-if="selectedRound">
              <div class="flex justify-between mb-1">
                <span class="text-sm font-medium text-gray-700"
                  >Total Score (100%)</span
                >
                <span class="text-sm font-medium text-gray-700">{{ kpiData.totalScore }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-indigo-600 h-2 rounded-full"
                  :style="{ width: kpiData.totalScore + '%' }"
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
                  >{{ kpiData.performanceLevel }}</span
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
import { ref, onMounted, watch, computed } from "vue";
import Chart from "chart.js/auto";
import { useAirtableKpi } from '@/composables/useAirtableKpi'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

const { kpiRounds, selectedRound, selectRound, isLoading, error } = useAirtableKpi()
const selectedRoundId = ref(selectedRound.value?.id || '')
const { user,logout } = useFirebaseAuth()

// Computed properties for derived values
const academicPerformance = computed(() => {
  return selectedRound.value?.categories.find(c => c.name === 'Teaching')?.value || 0
})

const behavior = computed(() => {
  return selectedRound.value?.categories.find(c => c.name === 'Research')?.value || 0
})

const totalScore = computed(() => {
  if (!selectedRound.value) return 0
  return selectedRound.value.categories.reduce((sum, cat) => sum + cat.value, 0)
})

const performanceLevel = computed(() => {
  const total = totalScore.value
  if (total >= 90) return 'Excellent'
  if (total >= 80) return 'Very Good'
  if (total >= 70) return 'Good'
  if (total >= 60) return 'Fair'
  return 'Needs Improvement'
})

// Type-safe accessors for KPI data
const kpiData = computed(() => ({
  behavior: behavior.value,
  totalScore: totalScore.value,
  performanceLevel: performanceLevel.value
}))

definePageMeta({
  layout: 'lecturer'
})

function onRoundChange() {
  selectRound(selectedRoundId.value)
}

function formatDate(dateStr: string) {
  const d = new Date(dateStr)
  return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
}

// Chart logic
const performanceChart = ref<HTMLCanvasElement | null>(null)
let chartInstance: Chart | null = null

function renderChart() {
  if (!performanceChart.value || !selectedRound.value) return;
  if (chartInstance) chartInstance.destroy();
  
  const categories = selectedRound.value.categories;
  // Multi-ring: each category as a separate dataset, only one value per dataset
  const datasets = categories.map((cat, idx) => ({
    data: Array(categories.length).fill(0).map((_, i) => i === idx ? Number(cat.value) : 0),
    backgroundColor: cat.color,
    borderWidth: 0,
    cutout: `${70 - idx * 10}%`,
    radius: `${100 - idx * 12}%`,
    hoverOffset: 0,
  }));
  
  if (performanceChart.value instanceof HTMLCanvasElement) {
    chartInstance = new Chart(performanceChart.value, {
      type: 'doughnut',
      data: {
        labels: categories.map(cat => cat.name),
        datasets,
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '60%',
        plugins: {
          legend: { display: false },
          tooltip: {
            callbacks: {
              label: function(context) {
                const idx = context.dataIndex;
                const cat = categories[idx];
                return `${cat.name}: ${cat.value}%`;
              }
            }
          }
        },
      },
    });
  }
}

onMounted(renderChart)
watch(() => selectedRound.value, renderChart)

definePageMeta({
  layout: "lecturer",
});
</script>
