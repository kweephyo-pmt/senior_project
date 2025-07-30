import { ref, computed } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

export const useLecturerResearch = () => {
  const { user } = useFirebaseAuth()
  const researchAreas = ref<string[]>([])
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const staffCode = computed(() => {
    if (!user.value?.email) return null
    const match = user.value.email.match(/^(\d+)@/)
    return match ? match[1] : null
  })

  const fetchResearchAreas = async () => {
    if (!staffCode.value) {
      error.value = 'No staff code found in email'
      return
    }

    isLoading.value = true
    error.value = null

    try {
      const response = await fetch(`http://localhost:4000/api/lecturer/research/${staffCode.value}`)
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      
      const data = await response.json()
      researchAreas.value = data
    } catch (err) {
      console.error('Error fetching lecturer research areas:', err)
      error.value = 'Failed to fetch research areas data'
      
      // Fallback to mock data
      researchAreas.value = [
        'Business Intelligence and Data Analytics',
        'Machine Learning Applications in Management',
        'Higher Education Administration',
        'Research Collaboration Networks',
      ]
    } finally {
      isLoading.value = false
    }
  }

  return {
    researchAreas: computed(() => researchAreas.value),
    isLoading: computed(() => isLoading.value),
    error: computed(() => error.value),
    staffCode,
    fetchResearchAreas
  }
}
