export const useResearchStudies = () => {
  const BACKEND_URL = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
  
  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    return email.split('@')[0]
  }

  // Fetch research studies for a staff member
  const fetchResearchStudies = async (staffCode: string, evaluateid: number = 9) => {
    try {
      const response = await $fetch(`${BACKEND_URL}/api/research-studies/${staffCode}`, {
        query: { evaluateid }
      }) as { success: boolean; data: any[]; message: string }
      
      return {
        success: true,
        data: response.data || [],
        message: response.message || 'Research studies fetched successfully'
      }
    } catch (error: any) {
      console.error('Error fetching research studies:', error)
      
      if (error.status === 404) {
        return {
          success: false,
          data: [],
          message: 'No research studies found for this staff member'
        }
      }
      
      return {
        success: false,
        data: [],
        message: error.message || 'Failed to fetch research studies'
      }
    }
  }

  // Get research studies for authenticated user
  const getResearchStudies = async (userEmail: string, evaluateid: number = 9) => {
    const staffCode = extractStaffCode(userEmail)
    if (!staffCode) {
      return {
        success: false,
        data: [],
        message: 'Invalid user email format'
      }
    }
    
    return await fetchResearchStudies(staffCode, evaluateid)
  }

  // Format research studies data for display
  const formatResearchStudiesData = (data: any[]) => {
    return data.map(item => ({
      id: item.id,
      level: parseFloat(item.level),
      projectName: item.project_name,
      staffCode: item.staff_code,
      evaluateid: item.evaluateid,
      createdAt: item.created_at,
      updatedAt: item.updated_at
    }))
  }

  return {
    fetchResearchStudies,
    getResearchStudies,
    formatResearchStudiesData,
    extractStaffCode
  }
}
