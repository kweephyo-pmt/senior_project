<template>
  <div class="bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Main Dashboard Title Section -->
      <div class="flex justify-between items-center mb-8">
        <div>
          <h1 class="text-5xl font-extrabold text-gray-900">Faculty Analytics Dashboard</h1>
          <p class="text-gray-600 text-sm mt-1">Faculty Performance Overview</p>
        </div>
        <!-- Placeholder for potential right-aligned elements, keeping the layout consistent -->
        <div class="w-32"></div>
      </div>

      <!-- "Select Faculties Directory" Section -->
      <div class="flex items-center justify-between mb-10">
        <div class="flex items-center">
          <div class="bg-[#004086] p-3.5 rounded-xl mr-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l6.16-3.422A12.083 12.083 0 0121.485 12 12.083 12.083 0 0118.16 14.578L12 18l-6.16-3.422A12.083 12.083 0 012.515 12c0-1.25.37-2.434 1.02-3.422L12 14z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0v6" />
            </svg>
          </div>
          <div>
            <h2 class="text-3xl font-bold text-gray-900">Select Faculties Directory</h2>
            <p class="text-base text-gray-600 mt-1.5">Choose a department to view faculty performance metrics</p>
          </div>
        </div>

        <!-- Year Selector Dropdown -->
        <div class="relative inline-block text-left" ref="dropdownRef">
          <div>
            <button
              type="button"
              @click="toggleDropdown"
              class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              id="menu-button" aria-expanded="true" aria-haspopup="true">
              Year/ {{ selectedYear }}
              <svg class="-mr-1 ml-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </button>
          </div>

          <!-- Dropdown menu -->
          <transition enter-active-class="transition ease-out duration-100"
                      enter-from-class="transform opacity-0 scale-95"
                      enter-to-class="transform opacity-100 scale-100"
                      leave-active-class="transition ease-in duration-75"
                      leave-from-class="transform opacity-100 scale-100"
                      leave-to-class="transform opacity-0 scale-95">
            <div v-if="isDropdownOpen"
                 class="origin-top-right absolute right-0 mt-2 w-32 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none" role="menu" aria-orientation="vertical" aria-labelledby="menu-button" tabindex="-1">
              <div class="py-1" role="none">
                <a href="#" @click.prevent="selectYear(2025)" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100" role="menuitem" tabindex="-1" id="menu-item-0">2025</a>
                <a href="#" @click.prevent="selectYear(2024)" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100" role="menuitem" tabindex="-1" id="menu-item-1">2024</a>
                <a href="#" @click.prevent="selectYear(2023)" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100" role="menuitem" tabindex="-1" id="menu-item-2">2023</a>
              </div>
            </div>
          </transition>
        </div>
      </div>

      <!-- Departments Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(department, index) in departments" :key="index"
          class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">

          <!-- Department Header -->
          <div class="flex items-center mb-5">
            <div :class="[department.color, 'p-4 rounded-xl mr-5 shadow-sm border-2 border-white/20']">
              <component :is="department.icon" class="h-8 w-8 text-white" />
            </div>
            <div>
              <h3 class="font-semibold text-gray-900 text-xl leading-tight">{{ department.name }}</h3>
            </div>
          </div>

          <!-- Faculty Count -->
          <div class="flex items-center mb-6">
            <peopleIcon class="h-5 w-5 text-gray-500 mr-2"/>
            <span class="text-base text-gray-700">Total Faculty: {{ department.facultyCount }}</span>
          </div>

          <!-- Action Button -->
          <button
            @click="navigateToFaculty(department)"
            :class="[
              department.buttonColor, 
              department.textColor, 
              'w-full py-2.5 px-4 rounded-lg font-medium text-sm flex items-center justify-center gap-2',
              'transition-all duration-200 transform hover:scale-[1.02] hover:shadow-md',
              'active:scale-95 active:opacity-90',
              'focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-opacity-50',
              department.textColor.replace('text-', 'focus:ring-') + '/20'
            ]">
            <svg width="16" height="10" viewBox="0 0 18 10" fill="currentColor" xmlns="http://www.w3.org/2000/svg" class="transition-transform duration-200 group-hover:translate-x-0.5">
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
import { onMounted, onUnmounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import AccountingIcon from '~/components/accountingIcon.vue';
import AviationIcon from '~/components/aviationIcon.vue';
import BusinessIcon from '~/components/businessIcon.vue';
import DeanIcon from '~/components/deanIcon.vue';
import EconomicsIcon from '~/components/economicsIcon.vue';
import HospitalityIcon from '~/components/hospitalityIcon.vue';
import LogisticIcon from '~/components/logisticIcon.vue';
import TourismIcon from '~/components/tourismIcon.vue';
import peopleIcon from '../assets/peopleIcon.vue';

const router = useRouter();

definePageMeta({
  layout: 'admin'
});

const selectedYear = ref(2025);
const isDropdownOpen = ref(false);
const dropdownRef = ref(null);

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value;
};

const selectYear = (year) => {
  selectedYear.value = year;
  isDropdownOpen.value = false;
  console.log(`Year selected: ${year}`);
};

const navigateToFaculty = (department) => {
  // Map department names to their corresponding paths
  const departmentPaths = {
    'Accounting': 'accounting',
    'Aviation Business Management': 'aviation',
    'Business Administration': 'business',
    'Economics': 'economics',
    'Hospitality Business Management': 'hospitality',
    'Tourism Business and Event': 'tourism',
    'Logistics and Supply Chain Management': 'logistics',
    'Dean': 'dean'
  };
  
  const path = departmentPaths[department.name] || department.name.toLowerCase().replace(/\s+/g, '-');
  
  navigateTo({
    path: `/admin/faculty/${path}`
  });
};

const handleClickOutside = (event) => {
  if (dropdownRef.value && !dropdownRef.value.contains(event.target)) {
    isDropdownOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
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
  },
  {
    name: 'Dean',
    facultyCount: 7,
    icon: DeanIcon,
    color: 'bg-[#F6F3FC]',
    buttonColor: 'bg-[#F6F3FC]',
    textColor: 'text-[#BEADE8]'
  }
];
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: scale(0.95);
}
</style>