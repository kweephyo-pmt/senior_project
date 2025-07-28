<template>
  <div class="container mx-auto px-4 py-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
      <!-- Left side of the header (Back button, Title, Year Selector) -->
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

      <!-- Right side of the header (Profile Section) -->
      <div class="flex items-center">
        <div class="flex items-center space-x-3">
          <!-- Profile Picture Placeholder -->
          <div class="w-10 h-10 rounded-full bg-pink-200 flex items-center justify-center">
            <span class="text-sm font-semibold text-pink-600">SA</span>
          </div>
          <!-- Profile Name -->
          <div>
            <p class="text-sm font-semibold text-gray-900">Dr. Supansa Chaising</p>
            <p class="text-xs text-gray-500">Administrator</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Section 1: Budget Summary and Distribution -->
    <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100 mb-8">
      <!-- Budget Summary Title -->
      <h2 class="text-xl font-semibold text-gray-800 mb-6">Budget Summary</h2>
      
      <!-- Budget Summary Cards -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <!-- Total Budget -->
        <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200">
          <div class="p-3 rounded-xl bg-blue-50 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <div>
            <p class="text-sm font-medium text-gray-500">Total Budget</p>
            <p class="text-2xl font-bold text-gray-800">฿ {{ formatCurrency(totalAllocated) }}</p>
          </div>
        </div>

        <!-- Spent Amount -->
        <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200">
          <div class="p-3 rounded-xl bg-green-50 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
            </svg>
          </div>
          <div>
            <p class="text-sm font-medium text-gray-500">Spent Amount</p>
            <p class="text-2xl font-bold text-gray-800">฿ {{ formatCurrency(totalSpent) }}</p>
          </div>
        </div>

        <!-- Research Projects -->
        <div class="bg-white rounded-xl shadow-lg p-6 flex items-center border border-gray-200">
          <div class="p-3 rounded-xl bg-orange-50 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-orange-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2zM12 7v10M5 12h14M7 12h3m-3 4h3m3-4h3" />
            </svg>
          </div>
          <div>
            <p class="text-sm font-medium text-gray-500">Research Projects</p>
            <!-- <p class="text-2xl font-bold text-gray-800">฿ {{ formatCurrency(researchProjectTotal) }}</p> -->
            <p class="text-2xl font-bold text-gray-800">฿ 18,000.00 </p>
          </div>
        </div>
      </div>

      <!-- Budget Distribution -->
      <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100">
        <h2 class="text-xl font-semibold text-gray-800 mb-6">Budget Distribution</h2>
        
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead>
              <tr class="bg-[#036E94]">
                <th scope="col" class="px-8 py-4 text-left text-sm font-bold text-white uppercase tracking-wider">
                  Category
                </th>
                <th scope="col" class="px-8 py-4 text-right text-sm font-bold text-white uppercase tracking-wider">
                  Allocated
                </th>
                <th scope="col" class="px-8 py-4 text-right text-sm font-bold text-white uppercase tracking-wider">
                  Spent
                </th>
                <th scope="col" class="px-8 py-4 text-right text-sm font-bold text-white uppercase tracking-wider">
                  Remaining
                </th>
                <th scope="col" class="px-8 py-4 text-center text-sm font-bold text-white uppercase tracking-wider">
                  Available Budget
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="(item, index) in budgetSummary" :key="index" class="hover:bg-gray-50">
                <td class="px-8 py-4 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 h-3 w-3 rounded-full mr-3" :class="getCategoryColor(item.category)"></div>
                    <div class="text-sm font-medium text-gray-900">{{ item.category }}</div>
                  </div>
                </td>
                <td class="px-8 py-4 whitespace-nowrap text-right text-sm text-gray-900">
                  ฿ {{ formatCurrency(item.allocated) }}
                </td>
                <td class="px-8 py-4 whitespace-nowrap text-right text-sm text-gray-900">
                  ฿ {{ formatCurrency(item.spent) }}
                </td>
                <td class="px-8 py-4 whitespace-nowrap text-right text-sm text-gray-900">
                  ฿ {{ formatCurrency(item.allocated - item.spent) }}
                </td>
                <td class="px-8 py-4 whitespace-nowrap">
                  <div class="flex items-center w-48 mx-auto">
                    <div class="w-full bg-gray-200 rounded-full h-2.5">
                      <div 
                        class="h-2.5 rounded-full" 
                        :class="getCategoryColor(item.category)"
                        :style="{ width: `${Math.min(100, ((item.allocated - item.spent) / item.allocated) * 100)}%` }"
                      ></div>
                    </div>
                    <span class="text-xs text-gray-500 ml-2 whitespace-nowrap">
                      {{ Math.round(((item.allocated - item.spent) / item.allocated) * 100) || 0 }}%
                    </span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Section 2: Budget Details and Actions -->
    <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-xl font-semibold text-gray-800">Budget Details</h2>
        <div class="flex items-center space-x-4">
          <div class="relative">
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Search event..."
              class="pl-8 pr-4 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
          <button @click="openAddBudgetPopup" class="px-4 py-2 text-white rounded-md text-sm font-medium hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors" style="background-color: #036E94;">
            + Add Budget Details
          </button>
        </div>
      </div>

      <!-- Budget Details List - Scrollable Container -->
      <div class="max-h-96 overflow-y-auto pr-2">
        <div class="grid grid-cols-1 gap-3">
          <div v-for="(event, index) in filteredBudgetEvents" :key="index" class="bg-white p-5 rounded-xl shadow-sm hover:shadow-md transition-shadow duration-200 border border-gray-100">
            <div class="flex items-start justify-between">
              <div class="flex-1">
                <div class="flex items-center">
                  <h3 class="text-sm font-semibold text-gray-900">{{ event.eventName }}</h3>
                </div>
                <p class="text-xs text-gray-500 mt-1">{{ event.professors.join(', ') }}</p> <!-- Displaying professors -->
                
                <div class="mt-3 flex items-center text-sm">
                  <div class="flex items-center">
                    <span class="h-2.5 w-2.5 rounded-full mr-3" :class="getCategoryColor(event.category)"></span>
                    <span class="text-gray-900">Budget: ฿{{ formatCurrency(event.spentAmount) }}</span>
                    <span class="text-gray-400 mx-2">|</span>
                    <span class="text-green-600 ml-1">{{ event.duration }}</span>
                  </div>
                </div>
              </div>
              
              <div class="ml-4 flex-shrink-0 flex space-x-2">
                <button @click="editEvent(event)" class="p-1.5 text-blue-600 hover:bg-blue-50 rounded-full transition-colors" title="Edit">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                  </svg>
                </button>
                <button @click="confirmDeleteEvent(index)" class="p-1.5 text-red-600 hover:bg-red-50 rounded-full transition-colors" title="Delete">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Save/Cancel Buttons -->
      <div class="mt-8 flex justify-end space-x-4">
        <button
          type="button"
          class="px-6 py-2.5 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:border-[#036E94] hover:text-[#036E94] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-400 transition-colors"
        >
          Cancel
        </button>
        <button
          type="button"
          class="px-6 py-2.5 border border-transparent rounded-md shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors"
          style="background-color: #036E94;"
        >
          Save Changes
        </button>
      </div>
    </div>

    <!-- Add/Edit Budget Details Popup -->
    <div v-if="showAddBudgetPopup" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
      <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-lg">
        <div class="flex justify-between items-center mb-6">
          <h2 class="text-xl font-bold text-gray-800">{{ isEditing ? 'Edit Budget Details' : 'Add Budget Details' }}</h2>
          <button @click="closeAddBudgetPopup" class="text-gray-400 hover:text-gray-600 focus:outline-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <form @submit.prevent="submitAddBudget">
          <div class="space-y-4">
            <!-- Event Name -->
            <div>
              <label for="eventName" class="block text-sm font-medium text-gray-700 mb-1">Event Name:</label>
              <input 
                v-model="newBudgetEvent.eventName"
                type="text" 
                id="eventName" 
                placeholder="Enter event name" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>

            <!-- Professor Name Input -->
            <div>
              <label for="professorName" class="block text-sm font-medium text-gray-700 mb-1">Professor Name(s):</label>
              <!-- Main Professor Input -->
              <input 
                v-model="newBudgetEvent.professor"
                type="text" 
                id="professorName" 
                placeholder="Enter professor name" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >

              <!-- Dynamic Professor Inputs - Only shown after clicking the button -->
              <div v-for="(prof, index) in extraProfessorInputs" :key="index" class="mt-2 flex items-center space-x-2">
                <input 
                  v-model="newBudgetEvent.professors[index]"
                  type="text" 
                  :placeholder="'Professor ' + (index + 2) + ' name'" 
                  class="flex-grow px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                <button type="button" @click="removeProfessorInput(index)" class="text-red-500 hover:text-red-700">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>

              <!-- Add Another Professor Button -->
              <button 
                type="button" 
                @click="addProfessorInput" 
                class="w-full mt-2 px-4 py-2 text-sm font-medium text-blue-600 bg-blue-50 hover:bg-blue-100 rounded-lg border border-blue-200 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-1 transition-colors"
              >
                + Add Another Professor
              </button>
            </div>

            <!-- Budget Category -->
            <div>
              <label for="budgetCategory" class="block text-sm font-medium text-gray-700 mb-1">Category:</label>
              <select 
                v-model="newBudgetEvent.category"
                id="budgetCategory" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
                <option value="" disabled selected>Select category</option>
                <option value="Self Development">Self Development</option>
                <option value="Academic Service">Academic Service</option>
                <option value="Research Project">Research Project</option>
                <option value="Guest Speaker">Guest Speaker</option>
                <option value="Guest Lecturer">Guest Lecturer</option>
                <option value="Student Activity">Student Activity</option>
              </select>
            </div>

            <!-- Budget Amounts -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <!-- Spent Amount -->
              <div>
                <label for="spentAmount" class="block text-sm font-medium text-gray-700 mb-1">Spent Amount (THB):</label>
                <div class="relative">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <span class="text-gray-500">฿</span>
                  </div>
                  <input 
                    v-model="newBudgetEvent.spentAmount"
                    type="number" 
                    id="spentAmount" 
                    placeholder="0.00" 
                    min="0"
                    step="0.01"
                    class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  >
                </div>
              </div>
              
              <!-- Allocated Amount -->
              <div>
                <label for="allocatedAmount" class="block text-sm font-medium text-gray-700 mb-1">Allocated Amount (THB):</label>
                <div class="relative">
                  <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <span class="text-gray-500">฿</span>
                  </div>
                  <input 
                    v-model="newBudgetEvent.allocatedAmount"
                    type="number" 
                    id="allocatedAmount" 
                    placeholder="0.00" 
                    min="0"
                    step="0.01"
                    class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  >
                </div>
              </div>
            </div>

            <!-- Date Picker -->
            <div>
              <label for="budgetDate" class="block text-sm font-medium text-gray-700 mb-1">Date:</label>
              <input 
                v-model="newBudgetEvent.date"
                type="date" 
                id="budgetDate" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>
          </div>

          <div class="mt-6 flex justify-end space-x-3">
            <button
              type="button"
              @click="closeAddBudgetPopup"
              class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
            >
              Cancel
            </button>
            <button
              type="submit"
              class="px-6 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors"
              style="background-color: #036E94;"
            >
              Save Changes
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Delete Confirmation Dialog -->
    <div v-if="showDeleteConfirmation" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
      <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-lg">
        <h2 class="text-xl font-bold text-gray-800 mb-6">Confirm Delete</h2>
        <p class="text-sm text-gray-600 mb-6">Are you sure you want to delete "{{ eventToDelete?.eventName }}"?</p>
        <div class="flex justify-end space-x-3">
          <button
            type="button"
            @click="showDeleteConfirmation = false"
            class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
          >
            Cancel
          </button>
          <button
            type="button"
            @click="confirmDelete"
            class="px-6 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors"
            style="background-color: #EF4444;"
          >
            Confirm Delete
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRouter } from 'vue-router';

definePageMeta({
  layout: 'admin'
});

const router = useRouter();
const searchQuery = ref('');
const selectedYear = ref('Year / 2025');
const showAddBudgetPopup = ref(false);
const isEditing = ref(false);

// Updated data structure with events for each category
const budgetEvents = ref([
  // Research Project Events
  { eventName: 'AI Research Conference 2025', category: 'Research Project', spentAmount: 25000, allocatedAmount: 30000, professors: ['Dr. Supansa Chaising'], duration: '12 Months', date: '2025-01-15' },
  { eventName: 'Machine Learning Study', category: 'Research Project', spentAmount: 18000, allocatedAmount: 20000, professors: ['Dr. Supansa Chaising', 'Dr. Korawit Fakkhong'], duration: '8 Months', date: '2025-02-01' },
  
  // Self Development Events
  { eventName: 'Leadership Training Program', category: 'Self Development', spentAmount: 15000, allocatedAmount: 20000, professors: ['Dr. Supansa Chaising'], duration: '3 Months', date: '2025-01-20' },
  { eventName: 'Digital Literacy Course', category: 'Self Development', spentAmount: 7000, allocatedAmount: 10000, professors: ['Dr. Supansa Chaising', 'Dr. Korawit Fakkhong'], duration: '4 Months', date: '2025-03-01' },
  
  // Academic Service Events
  { eventName: 'Student Assessment Board', category: 'Academic Service', spentAmount: 8000, allocatedAmount: 10000, professors: ['Dr. Supansa Chaising'], duration: '6 Months', date: '2025-02-10' },
  
  // Guest Speaker Events
  { eventName: 'International Conference Speaker', category: 'Guest Speaker', spentAmount: 15000, allocatedAmount: 20000, professors: ['Dr. Supansa Chaising'], duration: '2 Days', date: '2025-02-20' },
  
  // Guest Lecturer Events
  { eventName: 'Visiting Professor Program', category: 'Guest Lecturer', spentAmount: 20000, allocatedAmount: 25000, professors: ['Dr. Korawit Fakkhong'], duration: '1 Semester', date: '2025-01-10' },
  { eventName: 'Special Topics Lecture Series', category: 'Guest Lecturer', spentAmount: 12000, allocatedAmount: 15000, professors: ['Dr. Supansa Chaising', 'Dr. Korawit Fakkhong'], duration: '2 Months', date: '2025-02-05' },
  
  // Student Activity Events
  { eventName: 'Student Innovation Competition', category: 'Student Activity', spentAmount: 8000, allocatedAmount: 10000, professors: ['Dr. Supansa Chaising'], duration: '3 Months', date: '2025-01-30' },
  { eventName: 'Academic Excellence Awards', category: 'Student Activity', spentAmount: 6000, allocatedAmount: 8000, professors: ['Dr. Supansa Chaising', 'Dr. Korawit Fakkhong'], duration: '1 Month', date: '2025-03-15' },
]);

// Define a type for the category allocations
type CategoryAllocations = {
  'Research Project': number;
  'Self Development': number;
  'Academic Service': number;
  'Guest Speaker': number;
  'Guest Lecturer': number;
  'Student Activity': number;
};

// State for the new budget event form
const newBudgetEvent = ref({
  eventName: '',
  professor: '', // Holds the comma-separated string input
  professors: [] as string[], // Holds the array of professor names
  category: '',
  spentAmount: 0,
  allocatedAmount: 0,
  duration: '3 Months',
  date: new Date().toISOString().split('T')[0]
});

// State for managing dynamic professor inputs
const extraProfessorInputs = ref<number[]>([]); // Start with no input fields

// State for delete confirmation
const showDeleteConfirmation = ref(false);
const eventToDelete = ref<{eventName: string; index: number} | null>(null);

// Computed properties for budget summary
const budgetSummary = computed(() => {
  const categories = ['Research Project', 'Self Development', 'Academic Service', 'Guest Speaker', 'Guest Lecturer', 'Student Activity'] as const;
  
  const categoryAllocations: CategoryAllocations = {
    'Research Project': 60000,
    'Self Development': 35000,
    'Academic Service': 25000,
    'Guest Speaker': 30000,
    'Guest Lecturer': 40000,
    'Student Activity': 25000
  };

  return categories.map(category => {
    const categoryEvents = budgetEvents.value.filter(event => event.category === category);
    const spent = categoryEvents.reduce((sum, event) => sum + event.spentAmount, 0);
    const allocated = categoryEvents.reduce((sum, event) => sum + event.allocatedAmount, 0);
    
    return {
      category,
      allocated: allocated,
      spent
    };
  });
});

const totalAllocated = computed(() => {
  return budgetSummary.value.reduce((sum, item) => sum + item.allocated, 0);
});

const totalSpent = computed(() => {
  return budgetSummary.value.reduce((sum, item) => sum + item.spent, 0);
});

// Research Project Total for the third card
const researchProjectTotal = computed(() => {
  const researchEvents = budgetEvents.value.filter(event => event.category === 'Research Project');
  return researchEvents.reduce((sum, event) => sum + event.spentAmount, 0);
});

// Filtered budget events based on search query
const filteredBudgetEvents = computed(() => {
  return budgetEvents.value.filter(event =>
    event.eventName.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
    event.category.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
    event.professors.some(p => p.toLowerCase().includes(searchQuery.value.toLowerCase()))
  );
});

// Helper functions
const formatCurrency = (value: number) => {
  return new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value);
};

const getCategoryColor = (category: string) => {
  const colorMap = {
    'Research Project': 'bg-[#8B5CF6]',
    'Self Development': 'bg-[#47B0E7]',
    'Academic Service': 'bg-[#AC0078]',
    'Guest Speaker': 'bg-[#10B981]',
    'Guest Lecturer': 'bg-[#F59E0B]',
    'Student Activity': 'bg-[#EF4444]'
  } as const;
  
  return (colorMap as Record<string, string>)[category] || 'bg-gray-500';
};

// Function to handle navigation back
const goBack = () => {
  router.back();
};

// Function to open the add budget popup
const openAddBudgetPopup = () => {
  showAddBudgetPopup.value = true;
  isEditing.value = false;
};

// Function to close the add budget popup
const closeAddBudgetPopup = () => {
  showAddBudgetPopup.value = false;
  // Reset the form
  newBudgetEvent.value = {
    eventName: '',
    professor: '', // Holds the comma-separated string input
    professors: [] as string[], // Holds the array of professor names
    category: '',
    spentAmount: 0,
    allocatedAmount: 0,
    duration: '3 Months',
    date: new Date().toISOString().split('T')[0]
  };
  extraProfessorInputs.value = []; // Reset dynamic inputs
  isEditing.value = false;
};

// Function to add a professor input field
const addProfessorInput = () => {
  extraProfessorInputs.value.push(extraProfessorInputs.value.length);
};

// Function to remove a professor input field
const removeProfessorInput = (index: number) => {
  extraProfessorInputs.value.splice(index, 1);
  // Also remove the corresponding entry from newBudgetEvent.professors if it exists
  if (newBudgetEvent.value.professors.length > index) {
    newBudgetEvent.value.professors.splice(index, 1);
  }
};

// Function to submit the new budget event
const submitAddBudget = () => {
  // Process comma-separated professor names
  const processedProfessors = newBudgetEvent.value.professor
    .split(',')
    .map(p => p.trim())
    .filter(p => p !== '');

  // Combine the initial input with dynamically added ones
  const allProfessors = [...processedProfessors, ...newBudgetEvent.value.professors];

  // Basic validation
  if (!newBudgetEvent.value.eventName || allProfessors.length === 0 || !newBudgetEvent.value.category || 
      newBudgetEvent.value.spentAmount <= 0 || newBudgetEvent.value.allocatedAmount <= 0) {
    return;
  }

  // Create new event
  const newEvent = {
    eventName: newBudgetEvent.value.eventName,
    category: newBudgetEvent.value.category,
    spentAmount: Number(newBudgetEvent.value.spentAmount),
    allocatedAmount: Number(newBudgetEvent.value.allocatedAmount),
    professors: allProfessors,
    duration: newBudgetEvent.value.duration,
    date: newBudgetEvent.value.date
  };

  // Add to budget events
  budgetEvents.value.push(newEvent);

  // Close the popup and reset form
  closeAddBudgetPopup();
};

// Function to show delete confirmation
const confirmDeleteEvent = (index: number) => {
  const event = filteredBudgetEvents.value[index];
  eventToDelete.value = {
    eventName: event.eventName,
    index: index
  };
  showDeleteConfirmation.value = true;
};

// Function to confirm and delete the event
const confirmDelete = () => {
  if (eventToDelete.value !== null) {
    const { index } = eventToDelete.value;
    const eventToRemove = filteredBudgetEvents.value[index];
    
    // Find the actual index in the original array
    const actualIndex = budgetEvents.value.findIndex(e => 
      e.eventName === eventToRemove.eventName && 
      e.professors.join(',') === eventToRemove.professors.join(',') && 
      e.date === eventToRemove.date
    );
    
    if (actualIndex !== -1) {
      budgetEvents.value.splice(actualIndex, 1);
    }
    
    // Reset and close
    showDeleteConfirmation.value = false;
    eventToDelete.value = null;
  }
};

// Function to edit an event
const editEvent = (event: any) => {
  // Populate the form with the event's data
  newBudgetEvent.value = {
    eventName: event.eventName,
    professor: event.professors.join(', '), // Join array to string for the initial input
    professors: [...event.professors], // Copy existing professors for dynamic inputs
    category: event.category,
    spentAmount: event.spentAmount,
    allocatedAmount: event.allocatedAmount,
    duration: event.duration,
    date: event.date
  };
  
  // Reset and set dynamic professor inputs based on existing professors
  extraProfessorInputs.value = event.professors.slice(1).map((_: unknown, i: number) => i);

  // Remove the old event from the array (we'll add the updated one when form is submitted)
  const index = budgetEvents.value.findIndex(e => 
    e.eventName === event.eventName && 
    e.professors.join(',') === event.professors.join(',') && 
    e.date === event.date
  );
  
  if (index !== -1) {
    budgetEvents.value.splice(index, 1);
  }
  
  // Open the popup for editing
  showAddBudgetPopup.value = true;
  isEditing.value = true;
};
</script>