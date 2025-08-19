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

  // Get KPI data by staff code and evaluation period
  const getKpiData = async (email: string, evaluateid?: number) => {
    try {
      const staffCode = extractStaffCode(email)
      if (!staffCode) {
        throw new Error('Invalid email format - cannot extract staff code')
      }

      const url = evaluateid 
        ? `${baseURL}/kpi/${staffCode}?evaluateid=${evaluateid}`
        : `${baseURL}/kpi/${staffCode}`
      
      const response = await $fetch(url)
      return response
    } catch (error) {
      console.error('Error fetching KPI data:', error)
      
      // Return empty data if API fails
      return {
        staffCode: extractStaffCode(email),
        staffName: 'Unknown',
        categories: [
          { name: 'Teaching', weight: 0, value: 0, color: '#1e40af', bgColor: '#dbeafe', textColor: '#1e40af' },
          { name: 'Research', weight: 0, value: 0, color: '#0891b2', bgColor: '#cffafe', textColor: '#0891b2' },
          { name: 'Academic Service', weight: 0, value: 0, color: '#059669', bgColor: '#d1fae5', textColor: '#059669' },
          { name: 'Administration', weight: 0, value: 0, color: '#7c3aed', bgColor: '#ede9fe', textColor: '#7c3aed' },
          { name: 'Arts and Culture', weight: 0, value: 0, color: '#dc2626', bgColor: '#fecaca', textColor: '#dc2626' }
        ],
        totalScore: '0',
        performanceLevel: 'No Data'
      }
    }
  }

  return {
    getKpiData,
    extractStaffCode
  }
}
