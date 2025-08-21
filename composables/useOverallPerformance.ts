import { ref, computed } from 'vue'

interface OverallPerformanceData {
  staffCode: string
  staffName: string
  academicPerformance: number
  behavior: number
  totalScore: number
  performanceLevel: string
  evaluateid: number
  createdAt: string
  updatedAt: string
}

export const useOverallPerformance = () => {
  const performanceData = ref<OverallPerformanceData | null>(null)
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch overall performance data
  const fetchOverallPerformance = async (email: string, evaluateid: number = 9) => {
    try {
      loading.value = true
      error.value = null
      performanceData.value = null // Clear existing data before fetching new data

      const staffCode = extractStaffCode(email)
      if (!staffCode) {
        throw new Error('Invalid email format - cannot extract staff code')
      }

      const backendUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      const url = `${backendUrl}/api/overall-performance/${staffCode}?evaluateid=${evaluateid}`

      const response = await fetch(url)
      
      if (!response.ok) {
        if (response.status === 404) {
          throw new Error('No performance data found for this evaluation period')
        }
        throw new Error(`HTTP ${response.status}: ${response.statusText}`)
      }

      const result = await response.json()
      
      if (!result.success) {
        throw new Error(result.message || 'Failed to fetch performance data')
      }

      performanceData.value = result.data
      return result.data

    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Unknown error occurred'
      error.value = errorMessage
      console.error('Error fetching overall performance:', errorMessage)
      performanceData.value = null // Clear data on error
      
      // Return fallback data on error
      return {
        staffCode: extractStaffCode(email),
        staffName: 'Unknown',
        academicPerformance: 0,
        behavior: 0,
        totalScore: 0,
        performanceLevel: 'No Data',
        evaluateid: evaluateid,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }
    } finally {
      loading.value = false
    }
  }

  // Computed properties for easy access
  const academicPerformance = computed(() => performanceData.value?.academicPerformance || 0)
  const behavior = computed(() => performanceData.value?.behavior || 0)
  const totalScore = computed(() => performanceData.value?.totalScore || 0)
  const performanceLevel = computed(() => performanceData.value?.performanceLevel || 'No Data')
  const staffName = computed(() => performanceData.value?.staffName || 'Unknown')

  // Performance level color helper
  const getPerformanceLevelColor = (level: string) => {
    switch (level.toLowerCase()) {
      case 'excellent':
        return 'bg-blue-100 text-blue-800'
      case 'good':
        return 'bg-green-100 text-green-800'
      case 'moderate':
        return 'bg-yellow-100 text-yellow-800'
      case 'poor':
        return 'bg-orange-100 text-orange-800'
      case 'very poor':
        return 'bg-red-100 text-red-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
  }

  // Performance level based on total score
  const getPerformanceLevelFromScore = (score: number): string => {
    if (score >= 85) return 'Excellent'
    if (score >= 75) return 'Good'
    if (score >= 65) return 'Moderate'
    if (score >= 55) return 'Poor'
    return 'Very Poor'
  }

  return {
    performanceData: readonly(performanceData),
    loading: readonly(loading),
    error: readonly(error),
    fetchOverallPerformance,
    academicPerformance,
    behavior,
    totalScore,
    performanceLevel,
    staffName,
    getPerformanceLevelColor,
    getPerformanceLevelFromScore
  }
}
