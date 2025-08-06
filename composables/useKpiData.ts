// KPI Data API composable
export const useKpiData = () => {
  const baseURL = 'https://senior-project-backend-51782680110.asia-southeast1.run.app/api'

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Get KPI data by staff code
  const getKpiData = async (email: string) => {
    try {
      const staffCode = extractStaffCode(email)
      if (!staffCode) {
        throw new Error('Invalid email format - cannot extract staff code')
      }

      const response = await $fetch(`${baseURL}/kpi/${staffCode}`)
      return response
    } catch (error) {
      console.error('Error fetching KPI data:', error)
      
      // Return fallback mock data if API fails
      return {
        staffCode: extractStaffCode(email),
        staffName: 'Dr. Supansa',
        categories: [
          { name: 'Teaching', weight: 60, value: 60, color: '#1e40af', bgColor: '#dbeafe', textColor: '#1e40af' },
          { name: 'Research', weight: 15, value: 15, color: '#0891b2', bgColor: '#cffafe', textColor: '#0891b2' },
          { name: 'Academic Service', weight: 10, value: 10, color: '#059669', bgColor: '#d1fae5', textColor: '#059669' },
          { name: 'Administration', weight: 5, value: 5, color: '#7c3aed', bgColor: '#ede9fe', textColor: '#7c3aed' },
          { name: 'Arts and Culture', weight: 10, value: 3.75, color: '#dc2626', bgColor: '#fecaca', textColor: '#dc2626' }
        ],
        totalScore: '93.75',
        performanceLevel: 'Excellent'
      }
    }
  }

  return {
    getKpiData,
    extractStaffCode
  }
}
