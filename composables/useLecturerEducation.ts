import { ref, computed } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

interface Education {
  degree: string
  institution: string
  year: number
}

export const useLecturerEducation = () => {
  const { user } = useFirebaseAuth()
  const education = ref<Education[]>([])
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const staffCode = computed(() => {
    if (!user.value?.email) return null
    const match = user.value.email.match(/^(\d+)@/)
    return match ? match[1] : null
  })

  const fetchEducation = async () => {
    if (!staffCode.value) {
      error.value = 'No staff code found in email'
      return
    }

    isLoading.value = true
    error.value = null

    try {
      const response = await fetch(`http://localhost:4000/api/lecturer/education/${staffCode.value}`)
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      
      const data = await response.json()
      education.value = data
    } catch (err) {
      console.error('Error fetching lecturer education:', err)
      error.value = 'Failed to fetch education data'
      
      // Fallback to mock data
      education.value = [
        { degree: 'Ph.D. in Management', institution: 'Mae Fah Luang University', year: 2020 },
        { degree: 'M.B.A.', institution: 'Chulalongkorn University', year: 2015 },
        { degree: 'B.B.A.', institution: 'Chiang Mai University', year: 2012 },
      ]
    } finally {
      isLoading.value = false
    }
  }

  return {
    education: computed(() => education.value),
    isLoading: computed(() => isLoading.value),
    error: computed(() => error.value),
    staffCode,
    fetchEducation
  }
}
