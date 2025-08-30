export const useCurricularCommittee = () => {
  const curricularData = ref<any[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch curricular committee data
  const fetchCurricularCommittee = async (email: string, evaluateid?: string) => {
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
    curricularData.value = []

    try {
      const baseUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      
      let url = `${baseUrl}/api/curricular-committee/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success) {
        curricularData.value = response.data || []
      } else {
        curricularData.value = []
        throw new Error(response.message || 'Failed to fetch curricular committee data')
      }
    } catch (err: any) {
      console.error('Error fetching curricular committee data:', err)
      error.value = err.message || 'Failed to fetch curricular committee data'
      curricularData.value = []
    } finally {
      loading.value = false
    }
  }

  return {
    curricularData,
    loading,
    error,
    fetchCurricularCommittee
  }
}
