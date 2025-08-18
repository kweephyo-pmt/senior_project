export const useArtsCulturePerformance = () => {
  const artsCultureData = ref<any[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch arts culture performance data
  const fetchArtsCulturePerformance = async (email: string, evaluateid?: string) => {
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

    try {
      const baseUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      
      let url = `${baseUrl}/api/arts-culture-performance/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success && response.data) {
        artsCultureData.value = response.data
      } else {
        error.value = response.message || 'Failed to fetch arts culture performance data'
        throw new Error(response.message || 'Failed to fetch arts culture performance data');
      }
    } catch (err: any) {
      console.error('Error fetching arts culture performance data:', err);
      error.value = err.message || 'Failed to fetch arts culture performance data';
    } finally {
      loading.value = false;
    }
  };

  // Get chart data in the format expected by Chart.js
  const getChartData = () => {
    const labels = artsCultureData.value.map(item => item.category)
    const scoreData = artsCultureData.value.map(item => Number(item.score) || 0)

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
    artsCultureData,
    loading,
    error,
    fetchArtsCulturePerformance,
    getChartData
  }
}
