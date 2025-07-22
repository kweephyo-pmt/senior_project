<template>
    <div class="container mx-auto px-4 py-6">
      <!-- Header -->
      <div class="flex justify-between items-center mb-6">
        <div class="flex items-center">
          <button @click="goBack" class="mr-4 text-gray-600 hover:text-blue-600 focus:outline-none" aria-label="Back">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
          </button>
          <h1 class="text-2xl font-bold text-gray-800">Edit Budget Management</h1>
          <div class="relative ml-4">
            <select v-model="selectedYear" class="appearance-none bg-white border border-gray-300 rounded-md pl-3 pr-8 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
              <option>Year / 2025</option>
              <option>Year / 2024</option>
              <option>Year / 2023</option>
            </select>
            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
              <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
              </svg>
            </div>
          </div>
        </div>
        <div class="flex items-center space-x-3">
          <div class="flex items-center">
            <div class="w-10 h-10 rounded-full bg-pink-300 flex items-center justify-center mr-2">
              <span class="text-xl font-semibold text-white">S</span>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-800">Dr. Supansa Chaising</p>
              <p class="text-xs text-gray-500">SA</p>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Section 1: Budget Summary and Distribution -->
      <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100 mb-8">
        <!-- Budget Summary -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <!-- Total Budget -->
          <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200 relative">
            <div class="p-3 rounded-xl bg-blue-50 mr-4">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Total Budget</p>
              <p class="text-2xl font-bold text-gray-800">B 125,000</p>
            </div>
            <div class="absolute top-1/2 right-4 -translate-y-1/2 p-1.5 rounded-lg bg-purple-100">
              <div class="w-2 h-2 bg-purple-500 rounded-full"></div>
            </div>
          </div>
  
          <!-- Spent Amount -->
          <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200 relative">
            <div class="p-3 rounded-xl bg-green-50 mr-4">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
              </svg>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Spent Amount</p>
              <p class="text-2xl font-bold text-gray-800">B 78,500</p>
            </div>
            <div class="absolute top-1/2 right-4 -translate-y-1/2 p-1.5 rounded-lg bg-yellow-100">
              <div class="w-2 h-2 bg-yellow-500 rounded-full"></div>
            </div>
          </div>
  
          <!-- Research Projects -->
          <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200 relative">
            <div class="p-3 rounded-xl bg-orange-50 mr-4">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-orange-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2zM12 7v10M5 12h14M7 12h3m-3 4h3m3-4h3" />
              </svg>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Research Projects</p>
              <p class="text-2xl font-bold text-gray-800">B 25,000</p>
            </div>
            <div class="absolute top-1/2 right-4 -translate-y-1/2 p-1.5 rounded-lg bg-orange-100">
              <div class="w-2 h-2 bg-orange-500 rounded-full"></div>
            </div>
          </div>
        </div>
  
        <!-- Budget Distribution -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-gray-200 mb-8">
          <div class="px-6 py-4 border-b border-gray-200 flex justify-between items-center">
            <h2 class="text-lg font-medium text-gray-800">Budget Distribution</h2>
            <div class="relative">
              <input
                v-model="searchQuery"
                type="text"
                placeholder="Search categories..."
                class="pl-8 pr-4 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
              <svg class="absolute left-2.5 top-2.5 h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
  
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Allocated</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Spent</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Remaining</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="(item, index) in filteredBudgetItems" :key="index" class="hover:bg-gray-50">
                  <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                      <div :class="getCategoryColor(item.category).bg + ' flex-shrink-0 h-10 w-10 rounded-xl flex items-center justify-center'">
                        <component :is="getCategoryIcon(item.category)" :class="getCategoryColor(item.category).text + ' h-5 w-5'" />
                      </div>
                      <div class="ml-4">
                        <div class="text-sm font-medium text-gray-900">{{ item.category }}</div>
                        <div class="text-xs text-gray-500">{{ item.department }}</div>
                      </div>
                    </div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">B {{ formatCurrency(item.allocated) }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">B {{ formatCurrency(item.spent) }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm" :class="item.remaining < 0 ? 'text-red-600' : 'text-gray-900'">
                    {{ item.remaining < 0 ? '-' : '' }}B {{ formatCurrency(Math.abs(item.remaining)) }}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button @click="editItem(item)" class="text-blue-600 hover:text-blue-900 mr-3" title="Edit">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                      </svg>
                    </button>
                    <button @click="deleteItem(index)" class="text-red-600 hover:text-red-900" title="Delete">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
  
          <!-- Pagination -->
          <div class="bg-white px-6 py-4 flex items-center justify-between border-t border-gray-200">
            <div class="flex-1 flex justify-between sm:hidden">
              <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                Previous
              </button>
              <button class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                Next
              </button>
            </div>
            <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
              <div>
                <p class="text-sm text-gray-700">
                  Showing <span class="font-medium">1</span> to <span class="font-medium">5</span> of <span class="font-medium">12</span> results
                </p>
              </div>
              <div>
                <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                  <button class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                    <span class="sr-only">Previous</span>
                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                      <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
                    </svg>
                  </button>
                  <button aria-current="page" class="z-10 bg-blue-50 border-blue-500 text-blue-600 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                    1
                  </button>
                  <button class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                    2
                  </button>
                  <button class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                    3
                  </button>
                  <span class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700">
                    ...
                  </span>
                  <button class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                    8
                  </button>
                  <button class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                    <span class="sr-only">Next</span>
                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                      <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                    </svg>
                  </button>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Section 2: Budget Details and Actions -->
      <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-lg font-medium text-gray-800">Budget Details</h2>
          <button @click="openAddBudgetPopup" class="flex items-center px-4 py-2 bg-blue-600 text-white rounded-md text-sm font-medium hover:bg-blue-700 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            Add Budget Details
          </button>
        </div>
  
        <!-- Budget Details List -->
        <div class="grid grid-cols-1 gap-4">
          <div v-for="(item, index) in filteredBudgetItems" :key="index" class="bg-white p-4 rounded-xl shadow-md border border-gray-200 flex items-center justify-between">
            <div class="flex items-center">
              <div :class="getCategoryColor(item.category).bg + ' flex-shrink-0 h-8 w-8 rounded-full flex items-center justify-center mr-3'">
                <component :is="getCategoryIcon(item.category)" :class="getCategoryColor(item.category).text + ' h-4 w-4'" />
              </div>
              <div>
                <p class="text-sm font-semibold text-gray-900">{{ item.category }}</p>
                <p class="text-xs text-gray-500">Dr. Korawit Fakkhong</p>
                <div class="text-xs text-gray-500 mt-1">
                  Budget: B {{ formatCurrency(item.allocated) }} |
                  <span class="text-blue-600 font-medium">{{ item.duration }}</span>
                </div>
              </div>
            </div>
            <div class="flex items-center">
              <button @click="editItem(item)" class="text-blue-600 hover:text-blue-900 mr-3" title="Edit">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                </svg>
              </button>
              <button @click="deleteItem(index)" class="text-red-600 hover:text-red-900" title="Delete">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </button>
            </div>
          </div>
        </div>
  
        <!-- Save/Cancel Buttons -->
        <div class="flex justify-end gap-4 mt-6 px-4 py-4 border-t border-gray-200">
          <button class="px-4 py-2 text-gray-700 rounded-md border border-gray-300 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-400">
            Cancel
          </button>
          <button class="px-4 py-2 bg-blue-600 text-white rounded-md font-medium hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
            Save changes
          </button>
        </div>
      </div>
  
      <!-- Add Budget Details Popup -->
      <div v-if="showAddBudgetPopup" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-lg">
          <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl font-bold text-gray-800">Add New Budget Detail</h2>
            <button @click="closeAddBudgetPopup" class="text-gray-400 hover:text-gray-600 focus:outline-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          <form @submit.prevent="submitAddBudget">
            <div class="grid grid-cols-1 gap-4">
              <div>
                <label for="category" class="block text-sm font-medium text-gray-700">Category</label>
                <select v-model="newBudgetItem.category" id="category" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm rounded-md">
                  <option disabled value="">Select Category</option>
                  <option v-for="item in budgetItems" :key="item.category" :value="item.category">{{ item.category }}</option>
                </select>
              </div>
              <div>
                <label for="department" class="block text-sm font-medium text-gray-700">Department</label>
                <input v-model="newBudgetItem.department" type="text" id="department" placeholder="Enter department" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
              </div>
              <div class="grid grid-cols-2 gap-4">
                <div>
                  <label for="allocated" class="block text-sm font-medium text-gray-700">Allocated</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <span class="text-gray-500 sm:text-sm">B</span>
                    </div>
                    <input v-model="newBudgetItem.allocated" type="number" id="allocated" placeholder="0.00" class="mt-1 block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                  </div>
                </div>
                <div>
                  <label for="spent" class="block text-sm font-medium text-gray-700">Spent</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <span class="text-gray-500 sm:text-sm">B</span>
                    </div>
                    <input v-model="newBudgetItem.spent" type="number" id="spent" placeholder="0.00" class="mt-1 block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                  </div>
                </div>
              </div>
              <div>
                <label for="duration" class="block text-sm font-medium text-gray-700">Duration</label>
                <input v-model="newBudgetItem.duration" type="text" id="duration" placeholder="e.g., 6 Month" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
              </div>
            </div>
            <div class="flex justify-end gap-4 mt-6">
              <button type="button" @click="closeAddBudgetPopup" class="px-4 py-2 text-gray-700 rounded-md border border-gray-300 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-400">
                Cancel
              </button>
              <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md font-medium hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                Add Budget
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, computed } from 'vue';
  import { useRouter } from 'vue-router';
  
  definePageMeta({
    layout: 'admin'
  });
  
  const router = useRouter();
  const searchQuery = ref('');
  const selectedYear = ref('Year / 2025');
  const showAddBudgetPopup = ref(false);
  
  // Dummy data for budget items
  const budgetItems = ref([
    { category: 'Office Supplies', department: 'Administration', allocated: 15000, spent: 12500, remaining: 2500, duration: '12 Month', icon: 'office' },
    { category: 'Employee Training', department: 'HR', allocated: 30000, spent: 18500, remaining: 11500, duration: '6 Month', icon: 'users' },
    { category: 'Software Licenses', department: 'IT', allocated: 45000, spent: 32000, remaining: 13000, duration: '12 Month', icon: 'document' },
    { category: 'Hardware', department: 'IT', allocated: 25000, spent: 22000, remaining: 3000, duration: '6 Month', icon: 'device' },
    { category: 'Marketing', department: 'Sales', allocated: 10000, spent: 4000, remaining: 6000, duration: '3 Month', icon: 'chart' }
  ]);
  
  const newBudgetItem = ref({
    category: '',
    department: '',
    allocated: 0,
    spent: 0,
    remaining: 0,
    duration: '',
    icon: ''
  });
  
  // Filtered budget items based on search query
  const filteredBudgetItems = computed(() => {
    return budgetItems.value.filter(item =>
      item.category.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      item.department.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
  });
  
  // Helper functions
  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('en-US', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    }).format(value);
  };
  
  // Icon components (defined inline for simplicity, could be imported)
  const OfficeBuildingIcon = {
    template: `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/></svg>`
  };
  
  const UserGroupIcon = {
    template: `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>`
  };
  
  const DocumentTextIcon = {
    template: `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>`
  };
  
  const DeviceMobileIcon = {
    template: `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"/></svg>`
  };
  
  const ChartBarIcon = {
    template: `<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/></svg>`
  };
  
  
  const getCategoryIcon = (category: string) => {
    const icons: Record<string, any> = {
      'Office Supplies': OfficeBuildingIcon,
      'Employee Training': UserGroupIcon,
      'Software Licenses': DocumentTextIcon,
      'Hardware': DeviceMobileIcon,
      'Marketing': ChartBarIcon
    };
    return icons[category] || DocumentTextIcon;
  };
  
  const getCategoryColor = (category: string) => {
    const colors: Record<string, { bg: string; text: string }> = {
      'Office Supplies': { bg: 'bg-blue-50', text: 'text-blue-600' },
      'Employee Training': { bg: 'bg-green-50', text: 'text-green-600' },
      'Software Licenses': { bg: 'bg-purple-50', text: 'text-purple-600' },
      'Hardware': { bg: 'bg-yellow-50', text: 'text-yellow-600' },
      'Marketing': { bg: 'bg-pink-50', text: 'text-pink-600' }
    };
    return colors[category] || { bg: 'bg-gray-100', text: 'text-gray-600' };
  };
  
  // Function to handle navigation back
  const goBack = () => {
    router.push('/admin/budget'); // Adjust the route as needed
  };
  
  // Function to open the add budget popup
  const openAddBudgetPopup = () => {
    showAddBudgetPopup.value = true;
  };
  
  // Function to close the add budget popup
  const closeAddBudgetPopup = () => {
    showAddBudgetPopup.value = false;
    // Reset the form
    newBudgetItem.value = {
      category: '',
      department: '',
      allocated: 0,
      spent: 0,
      remaining: 0,
      duration: '',
      icon: ''
    };
  };
  
  // Function to submit the new budget item
  const submitAddBudget = () => {
    // Add logic here to add the newBudgetItem to budgetItems
    // For now, let's just log it and close the popup
    console.log('New Budget Item:', newBudgetItem.value);
  
    // Calculate remaining budget (simple example)
    const remaining = (newBudgetItem.value.allocated || 0) - (newBudgetItem.value.spent || 0);
  
    budgetItems.value.push({
      ...newBudgetItem.value,
      remaining: remaining,
      // Ensure icon is set if it's not already
      icon: newBudgetItem.value.icon || (getCategoryIcon(newBudgetItem.value.category).name || 'document')
    });
  
    closeAddBudgetPopup();
  };
  
  // Function to edit an item (placeholder)
  const editItem = (item: any) => {
    console.log('Editing item:', item);
    // Implement edit functionality here, e.g., open modal with item data
  };
  
  // Function to delete an item
  const deleteItem = (index: number) => {
    if (confirm('Are you sure you want to delete this budget item?')) {
      budgetItems.value.splice(index, 1);
    }
  };
  </script>