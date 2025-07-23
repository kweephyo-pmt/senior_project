<template>
  <div class="bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header Section -->
      <div class="flex items-center mb-8">
        <div class="bg-blue-600 p-3 rounded-lg mr-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5z" />
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l6.16-3.422A12.083 12.083 0 0121.485 12 12.083 12.083 0 0118.16 14.578L12 18l-6.16-3.422A12.083 12.083 0 012.515 12c0-1.25.37-2.434 1.02-3.422L12 14z" />
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0v6" />
          </svg>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">Select Faculties Directory</h1>
          <p class="text-gray-600 text-sm mt-1">Choose a department to view faculty performance metrics</p>
        </div>
      </div>

      <!-- Departments Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(department, index) in departments" :key="index"
          class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
          
          <!-- Department Header -->
          <div class="flex items-center mb-4">
            <div :class="[department.color, 'p-4 rounded-xl mr-4 shadow-sm border-2 border-white/20']">
              <component :is="department.icon" class="h-6 w-6 text-white" />
            </div>
            <div>
              <h3 class="font-semibold text-gray-900 text-base leading-tight">{{ department.name }}</h3>
            </div>
          </div>

          <!-- Faculty Count -->
          <div class="flex items-center mb-6">
            <peopleIcon class="h-4 w-4 text-gray-400 mr-2"/>
            <span class="text-sm text-gray-600">Total Faculty: {{ department.facultyCount }}</span>
          </div>

          <!-- Action Button -->
          <button
            :class="[department.buttonColor, department.textColor, 'w-full py-2.5 px-4 rounded-lg font-medium text-sm flex items-center justify-center gap-2 hover:opacity-90 transition-opacity duration-200']">
            <svg width="16" height="10" viewBox="0 0 18 10" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
              <path d="M9 0.178711C4.28375 0.178711 0.5625 4.99996 0.5625 4.99996C0.5625 4.99996 4.28375 9.82184 9 9.82184C12.6062 9.82184 17.4375 4.99996 17.4375 4.99996C17.4375 4.99996 12.6062 0.178711 9 0.178711ZM9 8.00371C7.34375 8.00371 5.99563 6.65621 5.99563 4.99996C5.99563 3.34371 7.34375 1.99559 9 1.99559C10.6562 1.99559 12.0044 3.34371 12.0044 4.99996C12.0044 6.65621 10.6562 8.00371 9 8.00371ZM9 3.24621C8.76695 3.24181 8.53536 3.28391 8.31877 3.37006C8.10218 3.4562 7.90494 3.58465 7.73857 3.74791C7.5722 3.91117 7.44004 4.10595 7.34983 4.32088C7.25961 4.5358 7.21314 4.76656 7.21314 4.99965C7.21314 5.23274 7.25961 5.46349 7.34983 5.67842C7.44004 5.89334 7.5722 6.08813 7.73857 6.25139C7.90494 6.41464 8.10218 6.5431 8.31877 6.62924C8.53536 6.71538 8.76695 6.75749 9 6.75309C9.45931 6.74441 9.89688 6.55587 10.2186 6.22798C10.5404 5.90009 10.7206 5.45904 10.7206 4.99965C10.7206 4.54026 10.5404 4.09921 10.2186 3.77132C9.89688 3.44343 9.45931 3.25488 9 3.24621Z" />
            </svg>
            View Faculty List
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import peopleIcon from '../assets/peopleIcon.vue';
import AccountingIcon from '~/components/accountingIcon.vue';
import AviationIcon from '~/components/aviationIcon.vue';
import BusinessIcon from '~/components/businessIcon.vue';
import EconomicsIcon from '~/components/economicsIcon.vue';
import HospitalityIcon from '~/components/hospitalityIcon.vue';
import TourismIcon from '~/components/tourismIcon.vue';
import LogisticIcon from '~/components/logisticIcon.vue';

definePageMeta({
  layout: 'dean'
});

const departments = [
  {
    name: 'Accounting',
    facultyCount: 6,
    icon: AccountingIcon,
    color: 'bg-[#E0EFFF]',
    buttonColor: 'bg-[#E0EFFF]',
    textColor: 'text-[#3F63C5]'
  },

  {
    name: 'Aviation Business Management',
    facultyCount: 9,
    icon: AviationIcon,
    color: 'bg-[#DEF3FA]',
    buttonColor: 'bg-[#DEF3FA]',
    textColor: 'text-[#1D7DAA]'
  },
  {
    name: 'Business Administration',
    facultyCount: 15,
    icon: BusinessIcon,
    color: 'bg-[#D3F3E3]',
    buttonColor: 'bg-[#D3F3E3]',
    textColor: 'text-[#0D875E]'
  },
  {
    name: 'Economics',
    facultyCount: 10,
    icon: EconomicsIcon,
    color: 'bg-[#F1E8FD]',
    buttonColor: 'bg-[#F1E8FD]',
    textColor: 'text-[#7C51AA]'
  },
  {
    name: 'Hospitality Business Management',
    facultyCount: 9,
    icon: HospitalityIcon,
    color: 'bg-[#FFE2F1]',
    buttonColor: 'bg-[#FFE2F1]',
    textColor: 'text-[#CD3774]'
  },
  {
    name: 'Tourism Business and Event',
    facultyCount: 8,
    icon: TourismIcon,
    color: 'bg-[#FFEBD3]',
    buttonColor: 'bg-[#FFEBD3]',
    textColor: 'text-[#EC5101]'
  },
  {
    name: 'Logistics and Supply Chain Management',
    facultyCount: 8,
    icon: LogisticIcon,
    color: 'bg-[#FCE2E5]',
    buttonColor: 'bg-[#FCE2E5]',
    textColor: 'text-[#EC5101]'
  }
];
</script>
