import { ref, computed } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

interface Publication {
  title: string
  venue: string
  year: number
  link: string
}

export const useLecturerPublications = () => {
  const { user } = useFirebaseAuth()
  const publications = ref<Publication[]>([])
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const staffCode = computed(() => {
    if (!user.value?.email) return null
    const match = user.value.email.match(/^(\d+)@/)
    return match ? match[1] : null
  })

  const fetchPublications = async (limit: number = 3) => {
    if (!staffCode.value) {
      error.value = 'No staff code found in email'
      return
    }

    isLoading.value = true
    error.value = null

    try {
      const response = await fetch(`http://localhost:4000/api/lecturer/publications/${staffCode.value}?limit=${limit}`)
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      
      const data = await response.json()
      publications.value = data
    } catch (err) {
      console.error('Error fetching lecturer publications:', err)
      error.value = 'Failed to fetch publications data'
      
      // Fallback to mock data
      publications.value = [
        { title: 'A Novel Approach to Sentiment Analysis', venue: 'Journal of Data Science', year: 2024, link: '#' },
        { title: 'Machine Learning in Education', venue: 'International Conference on AI', year: 2023, link: '#' },
        { title: 'Optimizing Research Collaboration', venue: 'Research Management Review', year: 2023, link: '#' },
      ]
    } finally {
      isLoading.value = false
    }
  }

  return {
    publications: computed(() => publications.value),
    isLoading: computed(() => isLoading.value),
    error: computed(() => error.value),
    staffCode,
    fetchPublications
  }
}
