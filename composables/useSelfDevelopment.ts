// Self-development API composable
export const useSelfDevelopment = () => {
  const config = useRuntimeConfig()
  const baseURL = 'https://senior-project-backend-51782680110.asia-southeast1.run.app/api'

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Get self-development data by staff code and evaluation period
  const getSelfDevelopmentData = async (email: string, evaluateid?: number) => {
    try {
      const staffCode = extractStaffCode(email)
      if (!staffCode) {
        throw new Error('Invalid email format')
      }

      let url = `${baseURL}/self-development/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url)
      return response
    } catch (error) {
      console.error('Error fetching self-development data:', error)
      throw error
    }
  }

  return {
    getSelfDevelopmentData,
    extractStaffCode
  }
}
