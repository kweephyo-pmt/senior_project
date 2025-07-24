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
            <!-- You can add an img tag here if you have a profile picture URL -->
            <!-- <img src="path/to/profile-pic.jpg" alt="Profile Picture" class="w-full h-full rounded-full object-cover"> -->
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
            <p class="text-2xl font-bold text-gray-800">฿ 125,000</p>
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
            <p class="text-2xl font-bold text-gray-800">฿ 78,500</p>
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
            <p class="text-2xl font-bold text-gray-800">฿ 25,000</p>
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
                  Progress
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="(item, index) in budgetItems" :key="index" class="hover:bg-gray-50">
                <td class="px-8 py-4 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 h-3 w-3 rounded-full mr-3" :class="{
                      'bg-blue-500': item.category === 'Research Project',
                      'bg-green-500': item.category === 'Self Development',
                      'bg-yellow-500': item.category === 'Academic Service',
                      'bg-purple-500': item.category === 'Guest Speaker',
                      'bg-red-500': item.category === 'Guest Lecturer',
                      'bg-indigo-500': item.category === 'Student Activity'
                    }"></div>
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
                        :class="{
                          'bg-blue-500': item.category === 'Research Project',
                          'bg-green-500': item.category === 'Self Development',
                          'bg-yellow-500': item.category === 'Academic Service',
                          'bg-purple-500': item.category === 'Guest Speaker',
                          'bg-red-500': item.category === 'Guest Lecturer',
                          'bg-indigo-500': item.category === 'Student Activity'
                        }"
                        :style="{ width: `${Math.min(100, (item.spent / item.allocated) * 100)}%` }"
                      ></div>
                    </div>
                    <span class="text-xs text-gray-500 ml-2 whitespace-nowrap">
                      {{ Math.round((item.spent / item.allocated) * 100) || 0 }}%
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
              placeholder="Search project..."
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

      <!-- Budget Details List -->
      <div class="grid grid-cols-1 gap-3">
        <div v-for="(item, index) in budgetItems" :key="index" class="bg-white p-5 rounded-xl shadow-sm hover:shadow-md transition-shadow duration-200 border border-gray-100">
          <div class="flex items-start justify-between">
            <div class="flex-1">
              <div class="flex items-center">
                <h3 class="text-sm font-semibold text-gray-900">{{ item.category }}</h3>
              </div>
              <p class="text-xs text-gray-500 mt-1">Dr. Korawit Fakkhong</p>
              
              <div class="mt-3 flex items-center text-sm">
                <div class="flex items-center">
                  <span class="h-2.5 w-2.5 rounded-full mr-2" :class="{
                    'bg-blue-500': item.category === 'Research Project',
                    'bg-green-500': item.category === 'Self Development',
                    'bg-yellow-500': item.category === 'Academic Service',
                    'bg-purple-500': item.category === 'Guest Speaker',
                    'bg-red-500': item.category === 'Guest Lecturer',
                    'bg-indigo-500': item.category === 'Student Activity'
                  }"></span>
                  <span class="text-gray-900">Budget: ฿{{ formatCurrency(item.allocated) }} | </span>
                  <span class="text-green-600 ml-1">{{ item.duration }}</span>
                </div>
              </div>
            </div>
            
            <div class="ml-4 flex-shrink-0 flex space-x-2">
              <button @click="editItem(item)" class="p-1.5 text-blue-600 hover:bg-blue-50 rounded-full transition-colors" title="Edit">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                </svg>
              </button>
              <button @click="deleteItem(index)" class="p-1.5 text-red-600 hover:bg-red-50 rounded-full transition-colors" title="Delete">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </button>
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

    <!-- Add Budget Details Popup -->
    <div v-if="showAddBudgetPopup" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
      <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-lg">
        <div class="flex justify-between items-center mb-6">
          <h2 class="text-xl font-bold text-gray-800">Add Budget Details</h2>
          <button @click="closeAddBudgetPopup" class="text-gray-400 hover:text-gray-600 focus:outline-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <form @submit.prevent="submitAddBudget">
          <div class="space-y-4">
            <!-- Budget Title -->
            <div>
              <label for="budgetTitle" class="block text-sm font-medium text-gray-700 mb-1">Budget Title:</label>
              <input 
                v-model="newBudgetItem.title"
                type="text" 
                id="budgetTitle" 
                placeholder="Enter budget title" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>

            <!-- Professor Name -->
            <div>
              <label for="professorName" class="block text-sm font-medium text-gray-700 mb-1">Professor Name:</label>
              <input 
                v-model="newBudgetItem.professor"
                type="text" 
                id="professorName" 
                placeholder="Enter professor name" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>

            <!-- Budget Category -->
            <div>
              <label for="budgetCategory" class="block text-sm font-medium text-gray-700 mb-1">Category:</label>
              <select 
                v-model="newBudgetItem.category"
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

            <!-- Budget Amount -->
            <div>
              <label for="budgetAmount" class="block text-sm font-medium text-gray-700 mb-1">Amount(THB):</label>
              <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <span class="text-gray-500">฿</span>
                </div>
                <input 
                  v-model="newBudgetItem.amount"
                  type="number" 
                  id="budgetAmount" 
                  placeholder="0.00" 
                  min="0"
                  step="0.01"
                  class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                >
              </div>
            </div>

            <!-- Date Picker -->
            <div>
              <label for="budgetDate" class="block text-sm font-medium text-gray-700 mb-1">Date:</label>
              <input 
                v-model="newBudgetItem.date"
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
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'; // Removed unused import: computed, onMounted, onUnmounted
import { useRouter } from 'vue-router';

definePageMeta({
  layout: 'admin'
});

const router = useRouter();
const searchQuery = ref('');
const selectedYear = ref('Year / 2025');
const showAddBudgetPopup = ref(false);

// Dummy data for budget items
// I've added professor and duration to the dummy data to better match potential use cases
const budgetItems = ref([
  { category: 'Research Project', allocated: 50000, spent: 32000, professor: 'Dr. Korawit Fakkhong', duration: '12 Months' },
  { category: 'Self Development', allocated: 30000, spent: 15000, professor: 'Dr. Supansa Chaising', duration: '6 Months' },
  { category: 'Academic Service', allocated: 20000, spent: 10000, professor: 'Dr. Korawit Fakkhong', duration: '12 Months' },
  { category: 'Guest Speaker', allocated: 15000, spent: 8000, professor: 'Dr. Supansa Chaising', duration: '6 Months' },
  { category: 'Guest Lecturer', allocated: 18000, spent: 9000, professor: 'Dr. Korawit Fakkhong', duration: '9 Months' },
  { category: 'Student Activity', allocated: 10000, spent: 5000, professor: 'Dr. Supansa Chaising', duration: '3 Months' }
]);

// State for the new budget item form
const newBudgetItem = ref({
  title: '',
  professor: '', // This will be used for the "Add Budget Details" form
  category: '',
  amount: 0,
  date: new Date().toISOString().split('T')[0] // Set default to today's date
});

// Filtered budget items based on search query
const filteredBudgetItems = computed(() => {
  return budgetItems.value.filter(item =>
    item.category.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
    item.professor.toLowerCase().includes(searchQuery.value.toLowerCase()) // Searching by professor name too
  );
});

// Helper functions
const formatCurrency = (value: number) => {
  return new Intl.NumberFormat('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(value);
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
    title: '',
    professor: '',
    category: '',
    amount: 0,
    date: new Date().toISOString().split('T')[0] // Set default to today's date
  };
};

// Function to submit the new budget item
const submitAddBudget = () => {
  // Basic validation to ensure at least a title, professor, category and amount are entered
  if (!newBudgetItem.value.title || !newBudgetItem.value.professor || !newBudgetItem.value.category || newBudgetItem.value.amount <= 0) {
    alert('Please fill in all required fields correctly.');
    return;
  }

  // Create new item with required fields from the form
  const newItem = {
    category: newBudgetItem.value.category,
    allocated: newBudgetItem.value.amount,
    spent: 0, // New items start with 0 spent
    professor: newBudgetItem.value.professor,
    duration: '12 Months' // Default duration, can be made dynamic
    // You might want to add a 'title' field to budgetItems if it's going to be displayed
  };

  // Add to budget items
  budgetItems.value.push(newItem);

  // Close the popup and reset form
  closeAddBudgetPopup();
};

// Function to edit an item (placeholder)
const editItem = (item: any) => {
  console.log('Editing item:', item);
  // For editing, you would typically populate the newBudgetItem form with the item's data
  // and potentially change the form title to "Edit Budget Details".
  // Then, you'd have a logic to update the existing item in budgetItems.value
  // For now, this is just a placeholder.
  alert('Edit functionality not yet implemented.');
};

// Function to delete an item
const deleteItem = (index: number) => {
  if (confirm('Are you sure you want to delete this budget item?')) {
    budgetItems.value.splice(index, 1);
  }
};
</script>