// Budget API composable
export const useBudget = () => {
  const config = useRuntimeConfig()
  const baseURL = config.public.backendApiUrl || 'https://senior-project-backend-51782680110.asia-southeast1.run.app/api'

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Get budget overview data by staff code
  const getBudgetOverview = async (staffCode: string, year: number = 2025) => {
    try {
      const response = await $fetch(`${baseURL}/budget/overview/${staffCode}?year=${year}`)
      return response
    } catch (error) {
      console.error('Error fetching budget overview:', error)
      throw error
    }
  }

  // Get budget projects/details by staff code
  const getBudgetProjects = async (staffCode: string, year: number = 2025) => {
    try {
      const response = await $fetch(`${baseURL}/budget/projects/${staffCode}?year=${year}`)
      return response
    } catch (error) {
      console.error('Error fetching budget projects:', error)
      throw error
    }
  }

  // Create new budget project
  const createBudgetProject = async (projectData: {
    title: string
    categoryName: string
    budgetAmount: number
    duration: string
    staffCode: string
    year?: number
    owners?: string[]
  }) => {
    try {
      const response = await $fetch(`${baseURL}/budget/projects`, {
        method: 'POST',
        body: projectData
      })
      return response
    } catch (error) {
      console.error('Error creating budget project:', error)
      throw error
    }
  }

  // Update budget project
  const updateBudgetProject = async (projectId: number, projectData: {
    title: string
    budgetAmount: number
    duration: string
    owners?: string[]
  }) => {
    try {
      const response = await $fetch(`${baseURL}/budget/projects/${projectId}`, {
        method: 'PUT',
        body: projectData
      })
      return response
    } catch (error) {
      console.error('Error updating budget project:', error)
      throw error
    }
  }

  // Delete budget project
  const deleteBudgetProject = async (projectId: number) => {
    try {
      const response = await $fetch(`${baseURL}/budget/projects/${projectId}`, {
        method: 'DELETE'
      })
      return response
    } catch (error) {
      console.error('Error deleting budget project:', error)
      throw error
    }
  }

  return {
    extractStaffCode,
    getBudgetOverview,
    getBudgetProjects,
    createBudgetProject,
    updateBudgetProject,
    deleteBudgetProject
  }
}
