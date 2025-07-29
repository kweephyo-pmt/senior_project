<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900">Domain 3: Academic Services Performance</h1>
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
            <path fill-rule="evenodd"
              d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
              clip-rule="evenodd" />
          </svg>
        </div>
      </div>
    </div>

    <!-- Administration Track -->
    <div class="mb-6">
      <h2 class="text-center text-base sm:text-lg font-medium text-inherit mb-1">Teaching Track</h2>
      <p class="text-center text-sm text-gray-500 mb-4">11 Feb 2025-31 July 2025</p>
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
        <p class="text-sm text-inherit">Teaching (0%)</p>
        <p class="text-xl font-bold text-inherit">0%</p>
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
        <p class="text-sm text-inherit">Research (0%)</p>
        <p class="text-xl font-bold text-inherit">0%</p>
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
        <p class="text-sm text-inherit">Academic Service (0%)</p>
        <p class="text-xl font-bold text-inherit">0%</p>
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
        <p class="text-sm text-inherit">Administration (0%)</p>
        <p class="text-xl font-bold text-inherit">0%</p>
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
        <p class="text-xl font-bold text-inherit">10%</p>
      </NuxtLink>
    </div>

    <!-- Academic Performance -->
    <div class="grid grid-cols-1 lg:grid-cols-[60%_40%] gap-6 sm:gap-8">
      <div class="bg-white rounded-lg shadow-md p-4 sm:p-6 mb-6 sm:mb-8">
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
          <canvas ref="academicChart"></canvas>
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
import { ref, onMounted } from 'vue'
import Chart from 'chart.js/auto'
import ChartDataLabels from 'chartjs-plugin-datalabels'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

definePageMeta({
  layout: 'lecturer'
})

const academicChart = ref<HTMLCanvasElement | null>(null)
const showMobileMenu = ref(false)
const { user, logout } = useFirebaseAuth()

const toggleMobileMenu = () => {
  showMobileMenu.value = !showMobileMenu.value
}

onMounted(() => {
  if (academicChart.value) {
    new Chart(academicChart.value, {
      type: 'bar',
      data: {
        labels: [
          'Other types of Academic Service Provided',
          'Academic Reviewer',
          'External Committee/Advisor/Member',
          'Performance as an Invited Lecturer or Speaker',
          'Academic Service Activities'
        ],
        datasets: [
          {
            label: 'Internal (Score)',
            data: [ 0, 5, 0, 27, 0], 
            backgroundColor: '#1D3555',
            borderWidth: 0,
            borderRadius: 4
          },
          {
            label: 'External (Score)',
            data: [ 0, 0, 0, 27, 0],
            backgroundColor: '#AC0078',
            borderWidth: 0,
            borderRadius: 4
          },
          {
            label: 'Non-Revenue (Score)',
            data: [ 0, 0, 0, 0, 27],  
            backgroundColor: '#1D3555',
            borderWidth: 0,
            borderRadius: 4
          },
          {
            label: 'Revenue (Score)',
            data: [ 0, 0, 0, 0, 27], 
            backgroundColor: '#AC0078',
            borderWidth: 0,
            borderRadius: 4
          }
        ]
      },
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
            clamp:true,
            formatter: function (value, context) {
              const datasets = context.chart?.data?.datasets || [];
              const index = context.dataIndex;

              const internal = datasets[0]?.data?.[index] ?? 0;
              const external = datasets[1]?.data?.[index] ?? 0;
              const nonRevenue = datasets[2]?.data?.[index] ?? 0;
              const revenue = datasets[3]?.data?.[index] ?? 0;

              const total = Number(internal) + Number(external) + Number(nonRevenue) + Number(revenue);

              if (context.datasetIndex === 3) {
                return total > 0 ? total : '';
              }
              return '';
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
})
</script>
