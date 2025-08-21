<template>
  <div class="container mx-auto px-3 sm:px-4 py-4 sm:py-6 lg:py-8">
    <!-- Header with Round Selector -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center sm:space-y-0 mb-4 sm:mb-6 lg:mb-8">
      <!-- Title Section -->
      <div class="flex-1">
        <h1 class="text-lg sm:text-xl lg:text-2xl font-bold text-gray-900 leading-tight">
          Domain 1: Teaching Performance
        </h1>
        <p class="text-xs sm:text-sm lg:text-base text-gray-600 mt-1">Welcome back, {{ user?.displayName }}</p>
      </div>
      <!-- Evaluation Period Selector -->
      <div class="relative w-full sm:w-48 lg:w-auto">
        <select
          v-model="selectedEvaluationPeriod"
          @change="onEvaluationPeriodChange"
          class="w-full appearance-none bg-white border-0 rounded-lg py-2.5 pl-3 pr-8 shadow-sm ring-2 ring-[#4697b9] text-xs sm:text-sm focus:outline-none focus:ring-2 focus:ring-[#4697b9]"
          :disabled="isLoadingPeriods"
        >
          <option v-if="isLoadingPeriods" disabled>Loading periods...</option>
          <option 
            v-for="period in evaluationPeriods" 
            :key="period.evaluateid" 
            :value="period.evaluateid"
          >
            Round {{ period.evaluatename }}
          </option>
        </select>
        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-500">
          <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </div>
      </div>
    </div>

    <!-- Teaching Track -->
    <div class="mb-4 sm:mb-6">
      <h2 class="text-center text-base sm:text-lg font-medium text-inherit mb-1">Teaching Track</h2>
      <p class="text-center text-xs sm:text-sm text-gray-500 mb-4">{{ formatDateRange() }}</p>
    </div>

    <!-- Loading spinner -->
    <div v-if="loading" class="flex justify-center items-center py-8">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
      <p class="ml-3 text-sm text-gray-600">Loading KPI data...</p>
    </div>

      <!-- KPI Categories with NuxtLink, only when not loading -->
      <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3 sm:gap-4 mb-6 sm:mb-8">
      <NuxtLink
        to="/lecturer/teaching-performance"
        class="rounded-lg p-4 text-center transition-colors cursor-pointer"
        :class="
          $route.path === '/lecturer/teaching-performance'
            ? 'bg-gradient-to-b from-[#38ADEA] to-[#21739D] text-white'
            : 'bg-gray-100 hover:bg-gradient-to-b hover:from-[#38ADEA] hover:to-[#21739D] hover:text-white'
        "
      >
        <p class="text-sm text-inherit">Teaching (60%)</p>
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[0]?.value) }}%</p>
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
        <p class="text-sm text-inherit">Research (15%)</p>
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[1]?.value) }}%</p>
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
        <p class="text-sm text-inherit">Academic Service (10%)</p>
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[2]?.value) }}%</p>
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
        <p class="text-sm text-inherit">Administration (5%)</p>
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[3]?.value) }}%</p>
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
        <p class="text-sm text-inherit">Arts and Culture (10%)</p>
        <p class="text-xl font-bold text-inherit">{{ formatValue(kpiCategories[4]?.value) }}%</p>
      </NuxtLink>
    </div>

    <!-- Main Content Grid - Always rendered -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6 lg:gap-8">
      <!-- Teaching Performance Card - Always rendered, chart always visible -->
      <div class="lg:col-span-2 bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-3 sm:p-6 lg:p-8">
        <h2 class="text-base sm:text-lg lg:text-xl font-bold text-gray-900 mb-2 text-center">
          Teaching Performance
        </h2>
        <p class="text-xs sm:text-sm text-gray-500 mb-3 sm:mb-4 lg:mb-6 text-center">
          Threshold (170) - Earned score (203.95)
        </p>
        <!-- Chart Container - Always visible -->
        <div class="h-[250px] sm:h-[300px] lg:h-[400px] w-full">
          <canvas ref="teachingChart"></canvas>
        </div>
      </div>

      <!-- Tables Column - Loading states only affect tables -->
      <div class="flex flex-col sm:gap-6">
        <!-- Loading State for Tables Only -->
        <div v-if="isLoadingData" class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-6 text-center">
          <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-[#4697b9]"></div>
          <p class="mt-2 text-sm text-gray-600">Loading table data...</p>
        </div>

        <!-- Error State for Tables Only -->
        <div v-else-if="apiError" class="bg-white rounded-xl sm:rounded-2xl shadow-md sm:shadow-xl p-6 text-center">
          <div class="bg-red-50 border border-red-200 rounded-lg p-4">
            <p class="text-red-600 text-sm">{{ apiError }}</p>
            <button 
              @click="fetchAllData" 
              class="mt-2 px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 text-sm"
            >
              Retry
            </button>
          </div>
        </div>

        <!-- Tables - Show when data is loaded successfully -->
        <template v-else>
          <!-- Undergraduate Teaching Table -->
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
                  <tr v-if="!undergraduateData?.length">
                    <td colspan="4" class="text-center py-4 text-gray-500">No undergraduate courses found</td>
                  </tr>
                  <template v-else>
                    <tr v-for="(item, index) in undergraduateData" 
                        :key="index" 
                        :class="index % 2 === 0 ? '' : 'bg-[#E8F4FC]'">
                      <td class="px-3 py-1 text-center">{{ index + 1 }}</td>
                      <td class="px-3 py-1">{{ item.course_name || item.courseName || 'N/A' }}</td>
                      <td class="px-3 py-1 text-center">{{ item.course_code || item.courseCode || 'N/A' }}</td>
                      <td class="px-3 py-1 text-center">{{ item.total_student || item.totalStudents || item.students || 'N/A' }}</td>
                    </tr>
                  </template>
                </tbody>
              </table>
            </div>
          </div>

          <!-- Graduate Teaching Table -->
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
                  <tr v-if="!graduateData?.length">
                    <td colspan="4" class="text-center py-4 text-gray-500">No graduate courses found</td>
                  </tr>
                  <template v-else>
                    <tr v-for="(item, index) in graduateData" 
                        :key="index" 
                        :class="index % 2 === 0 ? '' : 'bg-[#E8F4FC]'">
                      <td class="px-3 py-1 text-center">{{ index + 1 }}</td>
                      <td class="px-3 py-1">{{ item.course_name || item.courseName || 'N/A' }}</td>
                      <td class="px-3 py-1 text-center">{{ item.course_code || item.courseCode || 'N/A' }}</td>
                      <td class="px-3 py-1 text-center">{{ item.total_student || item.totalStudents || item.students || 'N/A' }}</td>
                    </tr>
                  </template>
                </tbody>
              </table>
            </div>
          </div>
        </template>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useFirebaseAuth } from '@/composables/useFirebaseAuth';
import Chart from "chart.js/auto";
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { onMounted, ref } from "vue";
import { useKpiData } from '@/composables/useKpiData'
import { useTeachingPerformance } from '@/composables/useTeachingPerformance'
import { useEvaluationPeriods } from '@/composables/useEvaluationPeriods'

definePageMeta({
  layout: "lecturer",
});

const teachingChart = ref<HTMLCanvasElement | null>(null);
const { getKpiData } = useKpiData()
const { user,logout } = useFirebaseAuth()
const { teachingData, loading: isLoadingChart, error: chartError, fetchTeachingPerformance, getChartData } = useTeachingPerformance()
const { evaluationPeriods, loading: isLoadingPeriods, error: periodsError, activeEvaluationPeriod, fetchEvaluationPeriods } = useEvaluationPeriods()

// Reactive data
const selectedRound = ref('round2-2025')
const selectedEvaluationPeriod = ref<number | null>(null)
const kpiData = ref<any>(null)
const loading = ref(true)

// Handle evaluation period change
const onEvaluationPeriodChange = async () => {
  if (selectedEvaluationPeriod.value && user.value?.email) {
    await Promise.all([
      fetchTeachingPerformance(selectedEvaluationPeriod.value),
      loadKpiData()
    ])
    initializeChart()
  }
}

// Format date range for selected evaluation period
const formatDateRange = () => {
  if (isLoadingPeriods.value) {
    return 'Loading...'
  }
  
  if (!selectedEvaluationPeriod.value || !evaluationPeriods.value) {
    return 'No period selected'
  }
  
  const selectedPeriod = evaluationPeriods.value.find(p => p.evaluateid === selectedEvaluationPeriod.value)
  if (!selectedPeriod) {
    return 'Period not found'
  }
  
  const startDate = new Date(selectedPeriod.evaluatestartdate).toLocaleDateString('en-GB', { 
    day: 'numeric', 
    month: 'short', 
    year: 'numeric' 
  })
  const endDate = new Date(selectedPeriod.evaluateenddate).toLocaleDateString('en-GB', { 
    day: 'numeric', 
    month: 'short', 
    year: 'numeric' 
  })
  
  return `${startDate}-${endDate}`
}

// Dynamic KPI categories from database
const kpiCategories = computed(() => {
  if (kpiData.value?.categories) {
    return kpiData.value.categories
  }
  // Return empty data if no database data available
  return [
    { name: 'Teaching', weight: 0, value: 0, color: '#1e40af', bgColor: '#dbeafe', textColor: '#1e40af' },
    { name: 'Research', weight: 0, value: 0, color: '#0891b2', bgColor: '#cffafe', textColor: '#0891b2' },
    { name: 'Academic Service', weight: 0, value: 0, color: '#059669', bgColor: '#d1fae5', textColor: '#059669' },
    { name: 'Administration', weight: 0, value: 0, color: '#7c3aed', bgColor: '#ede9fe', textColor: '#7c3aed' },
    { name: 'Arts and Culture', weight: 0, value: 0, color: '#dc2626', bgColor: '#fecaca', textColor: '#dc2626' }
  ]
})

// Load KPI data
const loadKpiData = async () => {
  try {
    loading.value = true
    if (user.value?.email) {
      const evalId = selectedEvaluationPeriod.value || activeEvaluationPeriod.value?.evaluateid || 9
      console.log('Loading KPI data for:', user.value.email, 'evaluation period:', evalId)
      const data = await getKpiData(user.value.email, evalId)
      console.log('KPI data loaded:', data)
      kpiData.value = data as any
    }
  } catch (err) {
    console.error('Failed to load KPI data:', err)
  } finally {
    loading.value = false
  }
}
// Debug states
const componentMounted = ref(false)
const consoleLogs = ref<Array<{timestamp: string, message: string, type: string}>>([])

// API Data states
const authToken = ref<string | null>(null)
const undergraduateData = ref<any[]>([])
const graduateData = ref<any[]>([])
const isLoadingData = ref(false)
const apiError = ref<string | null>(null)

// API Configuration using Nuxt runtime config
const runtimeConfig = useRuntimeConfig()
console.log('Runtime config values:', {
  apiBaseUrl: runtimeConfig.public.apiBaseUrl,
  apiUsername: runtimeConfig.public.apiUsername,
  hasPassword: !!runtimeConfig.public.apiPassword
})

// Add fallback values in case runtime config fails
const API_BASE_URL = runtimeConfig.public.apiBaseUrl || 'https://eport.mfu.ac.th/api/master'
const API_CREDENTIALS = {
  username: runtimeConfig.public.apiUsername || 'sombi',
  password: runtimeConfig.public.apiPassword || 'kTzQmR7pWv9LbYD'
}

console.log('Final API_BASE_URL:', API_BASE_URL)
console.log('Final API_CREDENTIALS:', { username: API_CREDENTIALS.username, hasPassword: !!API_CREDENTIALS.password })

// Required headers for GET requests (based on Postman collection)
const REQUIRED_GET_HEADERS_COMMON = {
  evaluateid: runtimeConfig.public.evaluateId || '9',
  lang: runtimeConfig.public.apiLang || 'en'
}

// Specific staffcodes based on Postman collection
const STAFF_CODES = {
  undergraduate: runtimeConfig.public.staffCodeUndergraduate || '67212038',
  graduate: runtimeConfig.public.staffCodeGraduate || '46212058'
}

// Format value helper
const formatValue = (value: any) => {
  if (value === null || value === undefined) return '0';
  if (typeof value === 'number') return Math.round(value * 100) / 100;
  if (typeof value === 'string') {
    const num = parseFloat(value);
    return isNaN(num) ? '0' : Math.round(num * 100) / 100;
  }
  return '0';
}

// Logging function
const addLog = (message: string, type: 'info' | 'error' = 'info') => {
  const timestamp = new Date().toLocaleTimeString()
  consoleLogs.value.push({ timestamp, message, type })
  console.log(`[${timestamp}] ${message}`)
  
  if (consoleLogs.value.length > 30) {
    consoleLogs.value = consoleLogs.value.slice(-30)
  }
}

const clearLogs = () => {
  consoleLogs.value = []
}

// Register the Chart.js plugin
Chart.register(ChartDataLabels);

// Test basic connection
const testConnection = async () => {
  isLoadingData.value = true
  apiError.value = null
  
  try {
    addLog('Testing basic connection...')
    const response = await fetch(API_BASE_URL, { method: 'HEAD' })
    addLog(`Connection test result: ${response.status} ${response.statusText}`)
    
    if (response.ok) {
      addLog('✅ Basic connection successful!')
    } else {
      addLog(`❌ Connection failed: ${response.status}`, 'error')
    }
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error occurred'
    addLog(`❌ Connection error: ${errorMessage}`, 'error')
    apiError.value = `Connection failed: ${errorMessage}`
  } finally {
    isLoadingData.value = false
  }
}

// Test authentication AND RETURN THE TOKEN
const testAuthentication = async () => {
  isLoadingData.value = true
  apiError.value = null
  
  try {
    addLog(`Attempting authentication with username: ${API_CREDENTIALS.username}`)
    
    if (API_CREDENTIALS.username === 'your_actual_username') {
      throw new Error('Please update API_CREDENTIALS with your real username and password!')
    }
    
    const response = await fetch(`${API_BASE_URL}/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        username: API_CREDENTIALS.username,
        password: API_CREDENTIALS.password
      })
    })
    
    const responseText = await response.text()
    addLog(`Auth response status: ${response.status} ${response.statusText}. Body: ${responseText}`)
    
    if (response.ok) {
      try {
        const data = JSON.parse(responseText)
        authToken.value = data.token || data.access_token || data.bearer_token
        if (authToken.value) {
          addLog('✅ Authentication successful! Token received.')
          return authToken.value // <-- IMPORTANT: Return the token
        } else {
          addLog('❌ No token found in response', 'error')
        }
      } catch (e: unknown) {
        const errorMessage = e instanceof Error ? e.message : 'Failed to parse JSON response'
        addLog(`❌ ${errorMessage}`, 'error')
      }
    } else {
      addLog(`❌ Authentication failed: ${response.status} - ${responseText}`, 'error')
      apiError.value = `Authentication failed: ${response.status}`
    }
    
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error occurred'
    addLog(`❌ Authentication error: ${errorMessage}`, 'error')
    apiError.value = `Authentication error: ${errorMessage}`
  } finally {
    isLoadingData.value = false
  }
  return null // Return null if authentication fails or no token is found
}

// Test GET requests using Authorization: Bearer header and required parameters
const testEndpointWithAuthHeader = async (endpoint: string, name: string) => {
  try {
    if (!authToken.value) {
      addLog('No token available, please authenticate first', 'error')
      return
    }
    
    addLog(`Testing ${name} endpoint with Authorization: Bearer header...`)
    
    // Construct headers
    const headers: Record<string, string> = {
      ...REQUIRED_GET_HEADERS_COMMON, 
      'Authorization': `Bearer ${authToken.value}`,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    // Add staffcode header if applicable based on the name
    if (name === 'Undergraduate') {
      headers['staffcode'] = STAFF_CODES.undergraduate;
    } else if (name === 'Graduate') {
      headers['staffcode'] = STAFF_CODES.graduate;
    }
    
    try {
      const response = await fetch(endpoint, {
        method: 'GET',
        headers: headers
      })
      
      const responseText = await response.text()
      addLog(`${name} response: ${response.status} ${response.statusText} - ${responseText.substring(0, 300)}`)
      
      if (response.ok) {
        try {
          const data = JSON.parse(responseText)
          // Check for a successful response structure
          if (data.success === 1 || data.success === true || Array.isArray(data) || data.data) {
            addLog(`🎉 ${name} SUCCESS! Authorization: Bearer header worked.`)
            
            let processedData: any[] = [];
            if (Array.isArray(data)) {
              processedData = data;
            } else if (data.data && Array.isArray(data.data)) {
              processedData = data.data;
            } else if (data.result && Array.isArray(data.result)) {
              processedData = data.result;
            } else if (data.items && Array.isArray(data.items)) {
              processedData = data.items;
            }
            
            // Map fields for display in the table
            const mappedData = processedData.map(item => ({
              course_name: item.coursename || item.courseName || item.name || 'N/A',
              course_code: item.coursecode || item.courseCode || item.code || 'N/A',
              total_student: item.totalstudent || item.totalStudents || item.students || item.student_count || 'N/A',
            }));

            if (mappedData.length > 0) {
              addLog(`${name} data count: ${mappedData.length}. First item keys: ${JSON.stringify(Object.keys(mappedData[0]))}`)
            } else {
              addLog(`${name} returned empty data.`)
            }
            
            if (name === 'Undergraduate') undergraduateData.value = mappedData
            else if (name === 'Graduate') graduateData.value = mappedData
            
            return { name: 'Authorization Header' }
          } else if (data.success === 0) {
            addLog(`${name} auth failed: ${data.message}. Token may be invalid or expired.`)
            addLog(`Received Token: ${authToken.value}`)
          } else {
            addLog(`${name} unknown response structure: ${JSON.stringify(data)}`)
          }
        } catch (error) {
          const parseError = error as Error
          addLog(`${name} JSON parse error: ${parseError.message}`, 'error')
        }
      } else if (response.status === 401) {
          addLog(`${name} received 401 Unauthorized. Token may be invalid or expired.`, 'error')
      } else {
        addLog(`❌ ${name} failed with status ${response.status}.`)
      }
      
    } catch (fetchError: unknown) {
      addLog(`${name} fetch error: ${fetchError instanceof Error ? fetchError.message : String(fetchError)}`, 'error')
    }
    
    return null
    
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : String(error)
    addLog(`❌ ${name} test failed: ${errorMessage}`, 'error')
    return null
  }
}

// Fetch all data using the authenticated header method
const fetchAllData = async () => {
  isLoadingData.value = true
  apiError.value = null
  
  try {
    addLog('Starting data fetch process...')
    
    // 1. Authenticate and capture the token
    const token = await testAuthentication() 
    
    if (!token) {
      throw new Error('Authentication failed - no token available')
    }
    
    addLog('Proceeding to fetch data with authenticated token using Authorization: Bearer header...')
    
    // 2. Test undergraduate data endpoint
    addLog('Testing undergraduate data endpoint...')
    const undergradResult = await testEndpointWithAuthHeader(`${API_BASE_URL}/get_Undergraduate`, 'Undergraduate')
    if (!undergradResult && !undergraduateData.value.length) {
      addLog('Failed to fetch undergraduate data. Check token validity, API response, and required headers.', 'error')
    }
    
    // 3. Test graduate data endpoint
    addLog('Testing graduate data endpoint...')
    const gradResult = await testEndpointWithAuthHeader(`${API_BASE_URL}/get_Graduate`, 'Graduate')
    if (!gradResult && !graduateData.value.length) {
      addLog('Failed to fetch graduate data. Check token validity and API response.', 'error')
    }
    
    addLog('✅ Data fetch process completed!')
    addLog(`Summary - Undergraduate: ${undergraduateData.value.length} items, Graduate: ${graduateData.value.length} items`)
    
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error occurred'
    addLog(`❌ Overall data fetch error: ${errorMessage}`, 'error')
    apiError.value = errorMessage
  } finally {
    isLoadingData.value = false
  }
}

// Store chart instance for proper cleanup
let chartInstance: Chart | null = null;

// Initialize chart with database data
const initializeChart = () => {
  if (teachingChart.value) {
    // Destroy existing chart if it exists
    if (chartInstance) {
      chartInstance.destroy();
      chartInstance = null;
    }
    
    let chartData;
    
    if (teachingData.value.length > 0) {
      addLog('Initializing chart with database data...');
      chartData = getChartData();
    } else {
      addLog('No teaching data available, showing empty chart with zeros...');
      // Show empty chart with zero values using same template structure
      chartData = {
        labels: [
          ['Other Teaching Tasks', 'Assigned by the Academic Office'],
          ['Thesis Oversight', 'Duties'],
          ['Student Projects or', 'Special Issues'],
          ['Student', 'Internships'],
          ['Graduate', 'Teaching'],
          ['Undergraduate', 'Teaching']
        ],
        datasets: [
          {
            label: "Lecture (Score)",
            data: [0, 0, 0, 0, 0, 0],
            backgroundColor: "#172554",
            borderWidth: 0,
            borderRadius: 0,
            stack: 'Stack 0',
          },
          {
            label: "Lab (Score)",
            data: [0, 0, 0, 0, 0, 0],
            backgroundColor: "#a21a5b",
            borderWidth: 0,
            borderRadius: 0,
            stack: 'Stack 0',
          },
        ],
      };
    }
    
    chartInstance = new Chart(teachingChart.value, {
      type: "bar",
      data: chartData,
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
              if (context.datasetIndex === context.chart.data.datasets.length - 1) {
                const total = context.chart.data.datasets.reduce((sum, dataset) => {
                  const dataPoint = dataset.data[context.dataIndex];
                  // Handle different data types
                  if (typeof dataPoint === 'number') {
                    return sum + dataPoint;
                  }
                  if (Array.isArray(dataPoint)) {
                    return sum + dataPoint[0]; // Use first value if array
                  }
                  return sum;
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
    
    if (teachingData.value.length > 0) {
      addLog('Chart initialized with database data');
    } else {
      addLog('Chart initialized with empty data (showing zeros)');
    }
  } else {
    addLog('Cannot initialize chart: teachingChart ref is null', 'error');
  }
};

onMounted(async () => {
  componentMounted.value = true
  addLog('Component mounted successfully')
  
  // Fetch evaluation periods first
  await fetchEvaluationPeriods()
  
  // Set default to active evaluation period
  if (activeEvaluationPeriod.value) {
    selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
  }
  
  // Load KPI data and teaching performance data
  if (user.value?.email) {
    await Promise.all([
      loadKpiData(),
      fetchTeachingPerformance(selectedEvaluationPeriod.value || undefined)
    ])
  }
  
  // Initialize the chart with database data
  initializeChart(); 
  
  addLog('API connection ready. Fetching data...')
  
  // Fetch the data for the tables automatically
  await fetchAllData() 
})
import { watch } from "vue";

watch(
  () => user.value?.email,
  async (email) => {
    if (email) {
      loadKpiData();
      // Fetch evaluation periods and set default
      await fetchEvaluationPeriods()
      if (activeEvaluationPeriod.value && !selectedEvaluationPeriod.value) {
        selectedEvaluationPeriod.value = activeEvaluationPeriod.value.evaluateid
      }
      await fetchTeachingPerformance(selectedEvaluationPeriod.value || undefined);
      // Re-initialize chart with new data
      initializeChart();
    }
  },
  { immediate: true }
);
</script>