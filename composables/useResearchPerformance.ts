export const useResearchPerformance = () => {
  const researchData = ref<any[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch research performance data
  const fetchResearchPerformance = async (email: string, evaluateid?: string) => {
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
    researchData.value = [] // Clear existing data before fetching new data

    try {
      const baseUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      
      let url = `${baseUrl}/api/research-performance/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success) {
        researchData.value = response.data || []
      } else {
        researchData.value = [] // Clear data on error
        throw new Error(response.message || 'Failed to fetch research performance data');
      }
    } catch (err: any) {
      console.error('Error fetching research performance data:', err);
      error.value = err.message || 'Failed to fetch research performance data';
      researchData.value = [] // Clear data on error
    } finally {
      loading.value = false;
    }
  };

  // Get chart data in the format expected by Chart.js
  const getChartData = () => {
    const labels = researchData.value.map(item => {
      // Split long category names into multiple lines for better display
      if (item.category.length > 25) {
        const words = item.category.split(' ')
        const midpoint = Math.ceil(words.length / 2)
        return [words.slice(0, midpoint).join(' '), words.slice(midpoint).join(' ')]
      }
      return item.category
    })

    const level4Data = researchData.value.map(item => Number(item.level4_score) || 0)
    const level6Data = researchData.value.map(item => Number(item.level6_score) || 0)
    const level7Data = researchData.value.map(item => Number(item.level7_score) || 0)

    return {
      labels,
      datasets: [
        {
          label: "Level 4 (Score)",
          data: level4Data,
          backgroundColor: "#172554",
          borderWidth: 0,
          borderRadius: 4,
          stack: 'Stack 0',
        },
        {
          label: "Level 6 (Score)",
          data: level6Data,
          backgroundColor: "#a21a5b",
          borderWidth: 0,
          borderRadius: 4,
          stack: 'Stack 0',
        },
        {
          label: "Level 7 (Score)",
          data: level7Data,
          backgroundColor: "#dc2626",
          borderWidth: 0,
          borderRadius: 4,
          stack: 'Stack 0',
        },
      ],
    }
  }

  return {
    researchData,
    loading,
    error,
    fetchResearchPerformance,
    getChartData
  }
}
