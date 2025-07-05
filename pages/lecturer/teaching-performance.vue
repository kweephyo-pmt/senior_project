<template>
  <div class="container mx-auto px-4 py-4 sm:py-8">
    <!-- Header with Round Selector -->
    <div class="md:flex md:justify-between md:items-center mb-6 sm:mb-8">
      <!-- Title Section - Always Full Width on Mobile -->
      <div class="mb-4 md:mb-0">
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">
          Domain 1: Teaching Performance
        </h1>
        <p class="text-sm sm:text-base text-inherit mt-1">Welcome back, {{ user?.displayName }}</p>
      </div>
      <!-- Round Selector - Full Width on Mobile -->
      <div class="relative w-full md:w-auto">
        <select
          class="w-full sm:w-auto appearance-none bg-white border-0  rounded-lg py-2 pl-4 pr-10 shadow-sm ring-2 ring-[#4697b9] text-sm"
        >
          <option>Round 2/2025</option>
          <option>Round 1/2025</option>
          <option>Round 2/2024</option>
        </select>
        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-inherit">
          <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </div>
      </div>
    </div>

    <!-- Teaching Track -->
    <div class="mb-4 sm:mb-6">
      <h2 class="text-center text-base sm:text-lg font-medium text-inherit mb-1">Teaching Track</h2>
      <p class="text-center text-xs sm:text-sm text-gray-500 mb-4">11 Feb 2025-31 July 2025</p>
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

    <!-- Main Content Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Teaching Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-3 sm:p-6 lg:p-8">
        <h2 class="text-base sm:text-lg lg:text-xl font-bold text-gray-900 mb-2 text-center">
          Teaching Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 mb-3 sm:mb-4 lg:mb-6 text-center">
          Threshold (170) - Earned score (203.95)
        </p>
        <div class="h-[250px] sm:h-[300px] lg:h-[400px] w-full">
          <canvas ref="teachingChart"></canvas>
        </div>
      </div>

      <!-- Tables stacked vertically in a card column -->
      <div class="flex flex-col gap-6">
        <!-- Undergraduate Teaching -->
        <div class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Undergraduate Teaching</h2>
          <div class="overflow-x-auto">
            <table class="min-w-full text-xs">
              <thead>
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">No.</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course Code</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Number of Students</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-if="!teachingData">
                  <td colspan="4" class="text-center py-4">Loading data...</td>
                </tr>
                <tr v-else-if="!teachingData.undergraduate?.length">
                  <td colspan="4" class="text-center py-4">No undergraduate courses found</td>
                </tr>
                <template v-else>
                  <tr v-for="(item, index) in teachingData.undergraduate" 
                      :key="item.id" 
                      :class="index % 2 === 0 ? '' : 'bg-[#E8F4FC]'">
                    <td class="px-3 py-1 text-center">{{ item.id }}</td>
                    <td class="px-3 py-1">{{ item.course_name }}</td>
                    <td class="px-3 py-1 text-center">{{ item.course_code }}</td>
                    <td class="px-3 py-1 text-center">{{ item.total_student }}</td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Graduate Teaching -->
        <div class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Graduate Teaching</h2>
          <div class="overflow-x-auto">
            <table class="min-w-full text-xs">
              <thead>
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">No.</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase">Course Code</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Number of Students</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-if="!teachingData?.graduate?.length">
                  <td colspan="4" class="text-center py-4">Loading data...</td>
                </tr>
                <template v-else>
                  <tr v-for="(item, index) in teachingData.graduate" 
                      :key="item.id" 
                      :class="index % 2 === 0 ? '' : 'bg-[#E8F4FC]'">
                    <td class="px-3 py-1 text-center">{{ item.id }}</td>
                    <td class="px-3 py-1">{{ item.course_name }}</td>
                    <td class="px-3 py-1 text-center">{{ item.course_code }}</td>
                    <td class="px-3 py-1 text-center">{{ item.total_student }}</td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import Chart from "chart.js/auto";
import { useFetch } from '#app';

const teachingData = ref<any>(null);

onMounted(async () => {
  console.log('Attempting to fetch teaching data...');
  
  try {
    const { data } = await useFetch('http://localhost:4000/api/teaching-performance');
    console.log('Raw response data:', data.value);
    
    if (data.value) {
      teachingData.value = data.value;
      console.log('Teaching data set:', teachingData.value);
    } else {
      console.log('No data received from API');
    }
  } catch (error) {
    console.error('Error fetching teaching data:', error);
    teachingData.value = null;
  }
});
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { useAirtableKpi } from '@/composables/useAirtableKpi'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

definePageMeta({
  layout: "lecturer",
});
const { kpiRounds, selectedRound, selectRound, isLoading, error } = useAirtableKpi()
const selectedRoundId = ref(selectedRound.value?.id || '')
const teachingChart = ref<HTMLCanvasElement | null>(null);
const { user } = useFirebaseAuth()

// Register the plugin
Chart.register(ChartDataLabels);

onMounted(() => {
  // Create bar chart
  if (teachingChart.value) {
    new Chart(teachingChart.value, {
      type: "bar",
      data: {
        labels: [
          ["Other Teaching Tasks Assigned", "by the Academic Office"],
          "Thesis Oversight Duties",
          ["Student Projects or", "Special Issues"],
          "Student Internships",
          "Graduate Teaching",
          "Undergraduate Teaching"
        ],
        datasets: [
          {
            label: "Lecture (Score)",
            data: [0, 0, 0, 3, 30, 90], // Example: 30 for grad, 90 for undergrad
            backgroundColor: ["#172554", "#172554", "#172554", "#172554", "#172554", "#172554"],
            borderWidth: 0,
            borderRadius: 0,
            stack: 'Stack 0',
          },
          {
            label: "Lab (Score)",
            data: [0, 0, 0, 0, 19.46, 61.5], // Example: 19.46 for grad, 61.5 for undergrad
            backgroundColor: ["#a21a5b", "#a21a5b", "#a21a5b", "#a21a5b", "#a21a5b", "#a21a5b"],
            borderWidth: 0,
            borderRadius: 0,
            stack: 'Stack 0',
          },
        ],
      },
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
                const total = context.chart.data.datasets.reduce((sum, dataset) => sum + dataset.data[context.dataIndex], 0);
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
});
</script>
