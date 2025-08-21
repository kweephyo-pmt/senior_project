export const useAdministrationPerformance = () => {
  const administrationData = ref<any[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch administration performance data
  const fetchAdministrationPerformance = async (email: string, evaluateid?: string) => {
    if (!email) {
      error.value = 'Email is required'
      return
    }

    const staffCode = extractStaffCode(email)
    if (!staffCode) {
      error.value = 'Invalid email format'
      return
    }

    loading.value = true
    error.value = null
    administrationData.value = [] // Clear existing data before fetching new data

    try {
      const baseUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      
      let url = `${baseUrl}/api/administration-performance/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success) {
        administrationData.value = response.data || []
      } else {
        administrationData.value = [] // Clear data on error
        throw new Error(response.message || 'Failed to fetch administration performance data');
      }
    } catch (err: any) {
      console.error('Error fetching administration performance data:', err);
      error.value = err.message || 'Failed to fetch administration performance data';
      administrationData.value = [] // Clear data on error
    } finally {
      loading.value = false;
    }
  };

  // Get chart data in the format expected by Chart.js
  const getChartData = () => {
    const labels = administrationData.value.map(item => {
      // Handle multi-line labels for better display
      const category = item.category
      if (category.includes('assigned by the School or University')) {
        return ['Academic Administration assigned', 'by the School or University']
      } else if (category.includes('University\'s Committee or Committee-Appointed Working Group')) {
        return ['University\'s Committee or ', 'Committee-Appointed Working Group']
      } else if (category.includes('School\'s Committee or Committee-Appointed Working Group')) {
        return ['School\'s Committee or ', 'Committee-Appointed Working Group']
      } else if (category.includes('Administrative duty assigned by the school')) {
        return ['Administrative duty assigned', 'by the school']
      }
      return category
    })

    const scoreData = administrationData.value.map(item => Number(item.score) || 0)

    return {
      labels,
      datasets: [{
        data: scoreData,
        backgroundColor: '#1D3555',
        borderWidth: 0,
        borderRadius: 4
      }]
    }
  }

  return {
    administrationData,
    loading,
    error,
    fetchAdministrationPerformance,
    getChartData
  }
}
