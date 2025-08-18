export const useAcademicServicePerformance = () => {
  const academicServiceData = ref<any[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch academic service performance data
  const fetchAcademicServicePerformance = async (email: string, evaluateid?: string) => {
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
      
      let url = `${baseUrl}/api/academic-service-performance/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success && response.data) {
        academicServiceData.value = response.data
      } else {
        error.value = response.message || 'Failed to fetch academic service performance data'
        throw new Error(response.message || 'Failed to fetch academic service performance data');
      }
    } catch (err: any) {
      console.error('Error fetching academic service performance data:', err);
      error.value = err.message || 'Failed to fetch academic service performance data';
      

    } finally {
      loading.value = false;
    }
  };

  // Get chart data in the format expected by Chart.js
  const getChartData = () => {
    const labels = academicServiceData.value.map(item => item.category)

    const internalData = academicServiceData.value.map(item => Number(item.internal_score) || 0)
    const externalData = academicServiceData.value.map(item => Number(item.external_score) || 0)
    const nonRevenueData = academicServiceData.value.map(item => Number(item.non_revenue_score) || 0)

    return {
      labels,
      datasets: [
        {
          label: "Internal (Score)",
          data: internalData,
          backgroundColor: "#1D3555",
          borderWidth: 0,
          borderRadius: 4,
        },
        {
          label: "External (Score)",
          data: externalData,
          backgroundColor: "#AC0078",
          borderWidth: 0,
          borderRadius: 4,
        },
        {
          label: "Non-Revenue (Score)",
          data: nonRevenueData,
          backgroundColor: "#1D3555",
          borderWidth: 0,
          borderRadius: 4,
        },
      ],
    }
  }

  return {
    academicServiceData,
    loading,
    error,
    fetchAcademicServicePerformance,
    getChartData
  }
}
