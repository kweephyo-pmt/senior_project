// Budget API composable
export const useBudget = () => {
  const config = useRuntimeConfig()
  const baseURL = 'http://localhost:4000/api'

  // Get budget overview data
  const getBudgetOverview = async (lecturerId: string, year: number = 2025) => {
    try {
      const response = await $fetch(`${baseURL}/budget/overview/${lecturerId}?year=${year}`)
      return response
    } catch (error) {
      console.error('Error fetching budget overview:', error)
      throw error
    }
  }

  // Get budget projects/details
  const getBudgetProjects = async (lecturerId: string, year: number = 2025) => {
    try {
      const response = await $fetch(`${baseURL}/budget/projects/${lecturerId}?year=${year}`)
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
    lecturerId: string
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
    getBudgetOverview,
    getBudgetProjects,
    createBudgetProject,
    updateBudgetProject,
    deleteBudgetProject
  }
}
