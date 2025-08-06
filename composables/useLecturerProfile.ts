import { ref, computed } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'

interface LecturerProfile {
  staffCode: string
  phone: string
  location: string
  program: string
  position: string
}

export const useLecturerProfile = () => {
  const { user } = useFirebaseAuth()
  const profile = ref<LecturerProfile | null>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const staffCode = computed(() => {
    if (!user.value?.email) return null
    const match = user.value.email.match(/^(\d+)@/)
    return match ? match[1] : null
  })

  const fetchProfile = async () => {
    if (!staffCode.value) {
      error.value = 'No staff code found in email'
      return
    }

    isLoading.value = true
    error.value = null

    try {
      const response = await fetch(`https://senior-project-backend-51782680110.asia-southeast1.run.app/api/lecturer/profile/${staffCode.value}`)
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }
      
      const data = await response.json()
      profile.value = data
    } catch (err) {
      console.error('Error fetching lecturer profile:', err)
      error.value = 'Failed to fetch profile data'
      
      // Fallback to mock data
      profile.value = {
        staffCode: staffCode.value,
        phone: '081-234-5678',
        location: 'Chiang Rai, Thailand',
        program: 'Accounting Program',
        position: 'Assistant Professor'
      }
    } finally {
      isLoading.value = false
    }
  }

  return {
    profile: computed(() => profile.value),
    isLoading: computed(() => isLoading.value),
    error: computed(() => error.value),
    staffCode,
    fetchProfile
  }
}
