<template>
    <div class="container mx-auto px-4 py-6">
      <!-- Header -->
      <div class="flex justify-between items-center mb-6">
        <!-- Left side of the header (Back button, Title, Subtitle, Year Selector) -->
        <div class="flex flex-col">
          <div class="flex items-center mb-1">
            <button @click="goBack" class="mr-4 text-gray-600 hover:text-blue-600 focus:outline-none" aria-label="Back">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
            </button>
            <h1 class="text-3xl font-bold text-gray-800">Executive Management Dashboard</h1>
          </div>
          <p class="text-sm text-gray-600 ml-12">Manage and review the School of Management's leadership history and current appointments</p>
        </div>
  
        <!-- Right side of the header (Year Selector, Add Executive Button) -->
        <div class="flex items-center">
          <div class="relative mr-4">
            <select v-model="selectedYear" class="appearance-none bg-white border border-gray-300 rounded-md pl-3 pr-8 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-gray-700">
              <option value="2025">Year/ 2025</option>
              <option value="2024">Year/ 2024</option>
              <option value="2023">Year/ 2023</option>
            </select>
            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
              <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
              </svg>
            </div>
          </div>
          <button @click="openAddExecutivePopup" class="px-4 py-2 text-white rounded-md text-sm font-medium hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors" style="background-color: #036E94;">
            + Add Executive
          </button>
        </div>
      </div>
  
      <!-- Section 1: Overview Summary -->
      <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100 mb-8">
        <!-- Overview Summary Title -->
        <h2 class="text-xl font-semibold text-gray-800 mb-6">Overview Summary</h2>
        
        <!-- Overview Summary Cards - MATCHING THE IMAGE'S 4 CARDS -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
          <!-- Dean Card -->
          <div class="rounded-xl p-6 flex flex-col items-center" style="background-color: #BBD0FF; color: #02319E;">
            <div class="text-center">
              <p class="text-3xl font-bold">1</p>
              <p class="text-sm font-medium">Dean</p>
            </div>
          </div>

          <!-- Associate Dean Card -->
          <div class="rounded-xl p-6 flex flex-col items-center" style="background-color: #C6FFCE; color: #016D06;">
            <div class="text-center">
              <p class="text-3xl font-bold">3</p>
              <p class="text-sm font-medium">Associate Dean</p>
            </div>
          </div>

          <!-- Assistant Dean Card -->
          <div class="rounded-xl p-6 flex flex-col items-center" style="background-color: #F7DAFF; color: #8E02B5;">
            <div class="text-center">
              <p class="text-3xl font-bold">3</p>
              <p class="text-sm font-medium">Assistant Dean</p>
            </div>
          </div>

          <!-- Total Card -->
          <div class="rounded-xl p-6 flex flex-col items-center" style="background-color: #E4E4E4; color: #000000;">
            <div class="text-center">
              <p class="text-3xl font-bold">7</p>
              <p class="text-sm font-medium">Total</p>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Section 2: Executive Members -->
      <div class="bg-gray-50 p-6 rounded-xl shadow-lg border border-gray-100">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-xl font-semibold text-gray-800">Executive Members</h2>
          <div class="flex items-center space-x-4">
            <div class="relative">
              <input
                v-model="searchQuery"
                type="text"
                placeholder="Search executives..."
                class="pl-8 pr-4 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              >
              <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
              </div>
            </div>
            <div class="relative">
              <select v-model="selectedPosition" class="appearance-none bg-white border border-gray-300 rounded-md pl-3 pr-8 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                <option value="">All Positions</option>
                <option value="Dean">Dean</option>
                <option value="Associate Dean">Associate Dean</option>
                <option value="Assistant Dean">Assistant Dean</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                  <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                </svg>
              </div>
            </div>
          </div>
        </div>
  
        <!-- Executive Members Grid -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div v-for="(member, index) in filteredExecutiveMembers" :key="index" class="bg-white p-5 rounded-xl shadow-sm hover:shadow-md transition-shadow duration-200 border border-gray-100">
            <div class="flex items-start justify-between">
              <div class="flex-1">
                <div class="flex items-center mb-2">
                  <!-- Profile Picture Placeholder -->
                  <div class="w-10 h-10 rounded-full mr-3 flex items-center justify-center" :class="getProfilePlaceholderColor(member.position)">
                    <span class="text-sm font-semibold" :class="getProfilePlaceholderTextColor(member.position)">{{ member.initials }}</span>
                  </div>
                  <div>
                    <h3 class="text-sm font-semibold text-gray-900">{{ member.name }}</h3>
                    <p class="text-xs" :class="getPositionTextColor(member.position)">{{ member.position }}</p>
                  </div>
                </div>
                
                <p class="text-xs text-gray-500 mt-1">E-mail: {{ member.email }}</p>
                <p class="text-xs text-gray-500">Tel. {{ member.phone }}</p>
                
                <div class="mt-3 flex items-center justify-between">
                  <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium" :class="getStatusBadgeClass(member.status)">
                    <span class="h-2 w-2 rounded-full mr-1.5" :class="getStatusIndicatorClass(member.status)"></span>
                    {{ member.status }}
                  </span>
                  
                  <div class="flex space-x-1">
                    <button @click="editExecutive(member)" class="p-1 text-blue-600 hover:bg-blue-50 rounded-full transition-colors" title="Edit">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                      </svg>
                    </button>
                    <button @click="confirmDelete(member)" class="p-1 text-red-600 hover:bg-red-50 rounded-full transition-colors" title="Delete">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Add Executive Popup -->
      <div v-if="showAddExecutivePopup" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-lg">
          <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl font-bold text-gray-800">Add Executive</h2>
            <button @click="closeAddExecutivePopup" class="text-gray-400 hover:text-gray-600 focus:outline-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          <form @submit.prevent="submitAddExecutive">
            <div class="space-y-4">
              <!-- Name -->
              <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Name:</label>
                <input 
                  v-model="newExecutive.name"
                  type="text" 
                  id="name" 
                  placeholder="Enter name" 
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                >
              </div>
  
              <!-- Position -->
              <div>
                <label for="position" class="block text-sm font-medium text-gray-700 mb-1">Position:</label>
                <select 
                  v-model="newExecutive.position"
                  id="position" 
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                >
                  <option value="" disabled selected>Select position</option>
                  <option value="Dean">Dean</option>
                  <option value="Associate Dean">Associate Dean</option>
                  <option value="Assistant Dean">Assistant Dean</option>
                </select>
              </div>
  
              <!-- Email -->
              <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">E-mail:</label>
                <input 
                  v-model="newExecutive.email"
                  type="email" 
                  id="email" 
                  placeholder="Enter email address" 
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                >
              </div>
  
              <!-- Telephone -->
              <div>
                <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Tel.:</label>
                <input 
                  v-model="newExecutive.phone"
                  type="text" 
                  id="phone" 
                  placeholder="Enter telephone number" 
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                >
              </div>
  
              <!-- Status -->
              <div class="flex items-center space-x-4">
                <label class="block text-sm font-medium text-gray-700">Status:</label>
                <div class="flex items-center">
                  <input type="radio" id="statusServing" value="Currently Serving" v-model="newExecutive.status" class="mr-2">
                  <label for="statusServing" class="text-sm text-gray-700">Currently Serving</label>
                </div>
                <div class="flex items-center">
                  <input type="radio" id="statusRetired" value="Retired" v-model="newExecutive.status" class="mr-2">
                  <label for="statusRetired" class="text-sm text-gray-700">Retired</label>
                </div>
              </div>
            </div>
  
            <div class="mt-6 flex justify-end space-x-3">
              <button
                type="button"
                @click="closeAddExecutivePopup"
                class="px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
              >
                Cancel
              </button>
              <button 
                type="submit" 
                class="px-4 py-2 text-sm font-medium text-white border border-transparent rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-all duration-200 hover:opacity-90 hover:shadow-md"
                style="background-color: #036E94;"
              >
                Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>
  
      <!-- Delete Confirmation Popup -->
      <div v-if="showDeleteConfirmation" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-xl shadow-xl p-6 w-full max-w-md">
          <div class="flex flex-col items-center">
            <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
              <svg class="h-6 w-6 text-red-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
              </svg>
            </div>
            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
              <h3 class="text-lg leading-6 font-medium text-gray-900">
                Delete Executive
              </h3>
              <div class="mt-2">
                <p class="text-sm text-gray-500">
                  Are you sure you want to delete this executive? This action cannot be undone.
                </p>
              </div>
            </div>
          </div>
          <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
            <button
              type="button"
              @click="executeDelete"
              class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm transition-colors"
            >
              Delete
            </button>
            <button
              type="button"
              @click="cancelDelete"
              class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:w-auto sm:text-sm transition-colors"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
  
      <!-- Edit Executive Popup -->
      <div v-if="showEditExecutivePopup" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
        <div class="bg-white rounded-xl shadow-xl p-8 w-full max-w-md">
          <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl font-bold text-gray-800">Edit Executive</h2>
            <button @click="closeEditExecutivePopup" class="text-gray-400 hover:text-gray-600 focus:outline-none">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          <form @submit.prevent="submitEditExecutive" class="space-y-4">
            <!-- Name -->
            <div>
              <label for="edit-name" class="block text-sm font-medium text-gray-700 mb-1">Name:</label>
              <input 
                v-model="editingExecutive.name"
                type="text" 
                id="edit-name" 
                placeholder="Enter full name" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>
            
            <!-- Email -->
            <div>
              <label for="edit-email" class="block text-sm font-medium text-gray-700 mb-1">E-mail:</label>
              <input 
                v-model="editingExecutive.email"
                type="email" 
                id="edit-email" 
                placeholder="Enter email address" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>
            
            <!-- Telephone -->
            <div>
              <label for="edit-phone" class="block text-sm font-medium text-gray-700 mb-1">Telephone:</label>
              <input 
                v-model="editingExecutive.phone"
                type="tel" 
                id="edit-phone" 
                placeholder="Enter phone number" 
                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                required
              >
            </div>
            
            <div class="flex justify-end space-x-3 pt-4">
              <button 
                type="button" 
                @click="closeEditExecutivePopup"
                class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                Cancel
              </button>
              <button 
                type="submit" 
                class="px-4 py-2 text-sm font-medium text-white border border-transparent rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-all duration-200 hover:opacity-90 hover:shadow-md"
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
  import { computed, ref } from 'vue';
import { useRouter } from 'vue-router';
  
  definePageMeta({
    layout: 'admin' // Assuming you have an admin layout
  });
  
  const router = useRouter();
  const searchQuery = ref('');
  const selectedYear = ref('2025'); // Set default value to 2025
  const showAddExecutivePopup = ref(false); // Control for the popup visibility
  const showEditExecutivePopup = ref(false); // Control for the edit popup visibility
  const showDeleteConfirmation = ref(false);
  const executiveToDelete = ref<number | null>(null);
  
  // Mock data for Executive Members matching the screenshot
  const executiveMembers = ref([
    { id: 1, name: 'Dr. Piyatida Pianluprasidh', position: 'Dean', email: 'piyatida@mfu.ac.th', phone: '053-916695', status: 'Currently Serving', initials: 'PP', profileColor: 'bg-pink-200' },
    { id: 2, name: 'Dr.Chachaya Yodsuwan', position: 'Associate Dean', email: 'chachaya@mfu.ac.th', phone: '053-916707', status: 'Currently Serving', initials: 'CY', profileColor: 'bg-pink-200' },
    { id: 3, name: 'Dr. Pratsanee Nakereere', position: 'Associate Dean', email: 'pratsanee.nak@mfu.ac.th', phone: '053-916707', status: 'Currently Serving', initials: 'PN', profileColor: 'bg-pink-200' },
    { id: 4, name: 'Dr.Siripen Yiamjanya', position: 'Associate Dean', email: 'siripen.yia@mfu.ac.th', phone: '053-916695', status: 'Currently Serving', initials: 'SY', profileColor: 'bg-pink-200' },
    { id: 5, name: 'Dr.Parinyakorn Paengsri', position: 'Assistant Dean', email: '-', phone: '-', status: 'Currently Serving', initials: 'PP', profileColor: 'bg-pink-200' },
    { id: 6, name: 'Dr. Supansa Chaising', position: 'Assistant Dean', email: 'supansa.cha@mfu.ac.th', phone: '053-916703', status: 'Currently Serving', initials: 'SC', profileColor: 'bg-pink-200' },
    { id: 7, name: 'Dr.Matej Balen', position: 'Assistant Dean', email: 'matej.bal@mfu.ac.th', phone: '053-916695', status: 'Currently Serving', initials: 'MB', profileColor: 'bg-pink-200' },
  ]);
  
  // State for the new executive member form
  const newExecutive = ref({
    id: null as number | null, // To track if we are editing an existing member
    name: '',
    position: '',
    email: '',
    phone: '',
    status: 'Currently Serving', // Default status
    initials: '',
    profileColor: ''
  });
  
  // State for the editing executive member form
  const editingExecutive = ref({
    id: null as number | null, // To track if we are editing an existing member
    name: '',
    position: '',
    email: '',
    phone: '',
    status: 'Currently Serving', // Default status
    initials: '',
    profileColor: ''
  });
  
  // Filtered executive members based on search query and position
  const filteredExecutiveMembers = computed(() => {
    return executiveMembers.value.filter(member =>
      member.name.toLowerCase().includes(searchQuery.value.toLowerCase()) &&
      (selectedPosition.value === '' || member.position === selectedPosition.value)
    );
  });
  
  // Dropdown for filtering by position
  const selectedPosition = ref('');
  
  // Helper functions
  const formatCurrency = (value: number): string => {
    // This function is not directly used in the executive management view,
    // but kept if you decide to merge functionalities later.
    return new Intl.NumberFormat('en-US', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    }).format(value);
  };
  
  // Functions to get profile placeholder styles
  const getProfilePlaceholderColor = (position: string): string => {
    switch (position) {
      case 'Dean': return 'bg-blue-100';
      case 'Associate Dean': return 'bg-green-100';
      case 'Assistant Dean': return 'bg-purple-100';
      default: return 'bg-gray-100'; // Fallback for any unexpected positions
    }
  };
  
  const getProfilePlaceholderTextColor = (position: string): string => {
    switch (position) {
      case 'Dean': return 'text-blue-600';
      case 'Associate Dean': return 'text-green-600';
      case 'Assistant Dean': return 'text-purple-600';
      default: return 'text-gray-600';
    }
  };
  
  // Functions to get status indicator styles
  const getStatusIndicatorClass = (status: string): string => {
    return status === 'Currently Serving' ? 'bg-green-500' : 'bg-gray-400';
  };
  
  const getStatusBadgeClass = (status: string): string => {
    return status === 'Currently Serving' 
      ? 'bg-green-100 text-green-800' 
      : 'bg-gray-100 text-gray-800';
  };
  
  const getStatusTextColor = (status: string): string => {
    return status === 'Currently Serving' ? 'text-green-600' : 'text-gray-500';
  };
  
  // Helper function to get position text color
  const getPositionTextColor = (position: string): string => {
    switch(position) {
      case 'Dean':
        return 'text-[#02319E]';
      case 'Associate Dean':
        return 'text-[#016D06]';
      case 'Assistant Dean':
        return 'text-[#8E02B5]';
      default:
        return 'text-gray-500';
    }
  };
  
  // Function to handle navigation back
  const goBack = () => {
    // Adjust the route as necessary to navigate to the previous page or dashboard
    router.push('/admin/dashboard'); 
  };
  
  // Functions for the Add/Edit Executive Popup
  const openAddExecutivePopup = () => {
    // Reset form for adding a new executive
    newExecutive.value = {
      id: null,
      name: '',
      position: '',
      email: '',
      phone: '',
      status: 'Currently Serving',
      initials: '',
      profileColor: ''
    };
    showAddExecutivePopup.value = true;
  };
  
  const closeAddExecutivePopup = () => {
    showAddExecutivePopup.value = false;
  };
  
  const submitAddExecutive = () => {
    // Basic validation
    if (!newExecutive.value.name || !newExecutive.value.position || !newExecutive.value.email || !newExecutive.value.phone) {
      alert('Please fill in all required fields.');
      return;
    }
  
    // Generate initials from the name
    const nameParts = newExecutive.value.name.split(' ');
    let initials = '';
    if (nameParts.length > 0) {
      initials += nameParts[0].charAt(0);
      if (nameParts.length > 1) {
        initials += nameParts[nameParts.length - 1].charAt(0);
      }
    }
    newExecutive.value.initials = initials.toUpperCase();
  
    // Assign profile color based on position
    newExecutive.value.profileColor = getProfilePlaceholderColor(newExecutive.value.position);
  
    if (newExecutive.value.id) {
      // Update existing executive
      const index = executiveMembers.value.findIndex(member => member.id === newExecutive.value.id);
      if (index !== -1) {
        executiveMembers.value[index] = { ...newExecutive.value } as any; 
      }
    } else {
      // Add new executive
      // Generate a simple unique ID (replace with a more robust solution if needed)
      const newId = executiveMembers.value.length > 0 ? Math.max(...executiveMembers.value.map(m => m.id)) + 1 : 1;
      executiveMembers.value.push({ ...newExecutive.value, id: newId } as any); 
    }
  
    closeAddExecutivePopup();
  };
  
  const editExecutive = (member: any) => {
    // Pre-fill form with member data
    editingExecutive.value = { ...member };
    showEditExecutivePopup.value = true;
  };
  
  const closeEditExecutivePopup = () => {
    showEditExecutivePopup.value = false;
  };
  
  const submitEditExecutive = () => {
    // Basic validation
    if (!editingExecutive.value.name || !editingExecutive.value.email || !editingExecutive.value.phone) {
      alert('Please fill in all required fields.');
      return;
    }
  
    // Update existing executive
    const index = executiveMembers.value.findIndex(member => member.id === editingExecutive.value.id);
    if (index !== -1) {
      executiveMembers.value[index] = { ...editingExecutive.value } as any; 
    }
  
    closeEditExecutivePopup();
  };
  
  const confirmDelete = (member: any) => {
    executiveToDelete.value = member.id;
    showDeleteConfirmation.value = true;
  };

  const executeDelete = () => {
    if (executiveToDelete.value !== null) {
      deleteExecutive(executiveToDelete.value);
      showDeleteConfirmation.value = false;
      executiveToDelete.value = null;
    }
  };

  const cancelDelete = () => {
    showDeleteConfirmation.value = false;
    executiveToDelete.value = null;
  };

  const deleteExecutive = (id: number) => {
    const index = executiveMembers.value.findIndex(member => member.id === id);
    if (index !== -1) {
      executiveMembers.value.splice(index, 1);
    }
  };
  </script>