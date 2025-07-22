<template>
  <div class="container mx-auto px-4 py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
      <div>
        <h1 class="text-xl sm:text-2xl font-bold text-gray-900 leading-tight">
          Domain 2: Research Performance
        </h1>
        <p class="text-sm sm:text-base text-gray-600">Welcome back, {{ user?.displayName }}</p>
      </div>
      <div class="relative w-full sm:w-auto">
        <select
          class="w-full sm:w-auto appearance-none bg-white border-0  rounded-lg py-2 pl-4 pr-10 shadow-sm ring-2 ring-[#4697b9] text-sm"
        > <option>Round 2/2025</option>
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

    <!-- Research Track -->
    <div class="mb-6">
      <h2 class="text-center text-lg font-medium text-gray-700 mb-1">Teaching Track</h2>
      <p class="text-center text-sm text-gray-500 mb-4">11 Feb 2025-31 July 2025</p>
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
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 sm:gap-8">
      <!-- Research Performance Card -->
      <div class="lg:col-span-2 bg-white rounded-2xl shadow-xl p-4 sm:p-8">
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
            <table class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">Level</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Project Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr>
                  <td class="px-3 py-1 text-center">1</td>
                  <td class="px-3 py-1">Self Project</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">2</td>
                  <td class="px-3 py-1">RECAI (Research Centre Reform)</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">3</td>
                  <td class="px-3 py-1">AI-Enhanced Learning Analytics</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">4</td>
                  <td class="px-3 py-1">Smart Campus Initiative</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">5</td>
                  <td class="px-3 py-1">Educational Data Mining Project</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">6</td>
                  <td class="px-3 py-1">Student Success Prediction Model</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">7.1</td>
                  <td class="px-3 py-1">Blockchain in Education</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">7.2</td>
                  <td class="px-3 py-1">Virtual Reality Learning Environments</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <!-- Research Publication -->
        <div class="bg-white rounded-2xl shadow-xl p-3 sm:p-4">
          <h2 class="text-sm sm:text-base font-semibold text-gray-900 mb-2">Research Publication</h2>
          <div class="max-h-[200px] overflow-y-auto">
            <table class="min-w-full text-xs">
              <thead class="sticky top-0">
                <tr>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tl-xl">Level</th>
                  <th class="px-3 py-2 bg-[#046e93] text-white text-center text-[11px] font-bold uppercase rounded-tr-xl">Project Name</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr>
                  <td class="px-3 py-1 text-center">1</td>
                  <td class="px-3 py-1">Self Research Highlights</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">2</td>
                  <td class="px-3 py-1">Gold Chain of Knowledge</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">3</td>
                  <td class="px-3 py-1">Machine Learning in Education</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">4</td>
                  <td class="px-3 py-1">Adaptive Learning Systems</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">5</td>
                  <td class="px-3 py-1">Educational Technology Integration</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">6</td>
                  <td class="px-3 py-1">Digital Assessment Methods</td>
                </tr>
                <tr>
                  <td class="px-3 py-1 text-center">7.1</td>
                  <td class="px-3 py-1">Learning Analytics Dashboard</td>
                </tr>
                <tr class="bg-[#E8F4FC]">
                  <td class="px-3 py-1 text-center">8.1</td>
                  <td class="px-3 py-1">InsightlyHub</td>
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
import { useAirtableKpi } from '@/composables/useAirtableKpi';
import Chart from "chart.js/auto";
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { onMounted, ref } from "vue";
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

definePageMeta({
  layout: "lecturer",
});
const { kpiRounds, selectedRound, selectRound, isLoading, error } = useAirtableKpi()
const selectedRoundId = ref(selectedRound.value?.id || '')
const researchChart = ref<HTMLCanvasElement | null>(null);
const { user,logout } = useFirebaseAuth()

function onRoundChange() {
  selectRound(selectedRoundId.value)
}

// Register the plugin
Chart.register(ChartDataLabels);

onMounted(() => {
  // Create bar chart
  if (researchChart.value) {
    new Chart(researchChart.value, {
      type: "bar",
      data: {
        labels: [
          ["Other Academic Work", "assigned by the School"],
          "Other Academic Work",
          "Patented Inventions",
          ["Composition of textbooks, Books,", "and interactive/e-Learning Materials"],
          "Academic Articles",
          "Research Publication",
          "Research Studies"
        ],
        datasets: [
          {
            label: "Level 4 (Score)",
            data: [10, 0, 0, 50, 0, 25, 7],
            backgroundColor: "#172554",
            borderWidth: 0,
            borderRadius: 4,
            stack: 'Stack 0'
          },
          {
            label: "Level 6 (Score)",
            data: [0, 0, 0, 0, 0, 30, 8],
            backgroundColor: "#a21a5b",
            borderWidth: 0,
            borderRadius: 4,
            stack: 'Stack 0'
          },
          {
            label: "Level 7 (Score)",
            data: [0, 0, 0, 0, 0, 30, 0],
            backgroundColor: "#dc2626",
            borderWidth: 0,
            borderRadius: 4,
            stack: 'Stack 0'
          }
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
});
</script>

