import { ref } from 'vue'

interface MfuActivity {
  id: number
  staff_code: string
  staff_name: string
  project_name: string
  activity_type: string
  activity_level: number
  description?: string
  start_date?: string
  end_date?: string
  location?: string
  organizer?: string
  evaluateid: number
  domain: number
  raw_score: number
  weighted_score: number
  status: string
  created_at: string
}

export const useMfuArrangedActivities = () => {
  const mfuArrangedActivities = ref<MfuActivity[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Extract staff code from email
  const extractStaffCode = (email: string): string => {
    if (!email) return ''
    const match = email.match(/^(\d+)@/)
    return match ? match[1] : ''
  }

  // Fetch MFU arranged activities
  const fetchMfuArrangedActivities = async (email: string, evaluateid?: string) => {
    if (!email) {
      error.value = 'Email is required'
      return
    }

    const staffCode = extractStaffCode(email)
    if (!staffCode) {
      error.value = 'Invalid email format'
      return
    }

    loading.value = true
    error.value = null

    try {
      const baseUrl = 'https://senior-project-backend-51782680110.asia-southeast1.run.app'
      
      let url = `${baseUrl}/api/mfu-arranged-activities/${staffCode}`
      if (evaluateid) {
        url += `?evaluateid=${evaluateid}`
      }

      const response = await $fetch(url) as any
      
      if (response.success && response.data) {
        mfuArrangedActivities.value = response.data
      } else {
        error.value = response.message || 'Failed to fetch MFU arranged activities'
        // Provide fallback mock data when API fails
        mfuArrangedActivities.value = [
          {
            id: 1,
            staff_code: staffCode,
            staff_name: 'Staff Member',
            project_name: 'Cultural Heritage Preservation Workshop',
            activity_type: 'workshop',
            activity_level: 1,
            description: 'Workshop on preserving local cultural heritage',
            evaluateid: parseInt(evaluateid || '9'),
            domain: 5,
            raw_score: 25.00,
            weighted_score: 15.00,
            status: 'completed',
            created_at: new Date().toISOString()
          },
          {
            id: 2,
            staff_code: staffCode,
            staff_name: 'Staff Member',
            project_name: 'Traditional Arts Festival',
            activity_type: 'festival',
            activity_level: 2,
            description: 'Festival showcasing traditional arts',
            evaluateid: parseInt(evaluateid || '9'),
            domain: 5,
            raw_score: 35.00,
            weighted_score: 21.00,
            status: 'completed',
            created_at: new Date().toISOString()
          }
        ]
      }
    } catch (err: any) {
      console.error('Error fetching MFU arranged activities:', err)
      error.value = err.message || 'Failed to fetch MFU arranged activities'
      
      // Provide fallback mock data for development
      mfuArrangedActivities.value = [
        {
          id: 1,
          staff_code: staffCode,
          staff_name: 'Staff Member',
          project_name: 'Cultural Heritage Preservation Workshop',
          activity_type: 'workshop',
          activity_level: 1,
          description: 'Workshop on preserving local cultural heritage',
          evaluateid: parseInt(evaluateid || '9'),
          domain: 5,
          raw_score: 25.00,
          weighted_score: 15.00,
          status: 'completed',
          created_at: new Date().toISOString()
        },
        {
          id: 2,
          staff_code: staffCode,
          staff_name: 'Staff Member',
          project_name: 'Traditional Arts Festival',
          activity_type: 'festival',
          activity_level: 2,
          description: 'Festival showcasing traditional arts',
          evaluateid: parseInt(evaluateid || '9'),
          domain: 5,
          raw_score: 35.00,
          weighted_score: 21.00,
          status: 'completed',
          created_at: new Date().toISOString()
        },
        {
          id: 3,
          staff_code: staffCode,
          staff_name: 'Staff Member',
          project_name: 'Community Cultural Development Program',
          activity_type: 'program',
          activity_level: 3,
          description: 'Community outreach program for cultural development',
          evaluateid: parseInt(evaluateid || '9'),
          domain: 5,
          raw_score: 30.00,
          weighted_score: 18.00,
          status: 'completed',
          created_at: new Date().toISOString()
        }
      ]
    } finally {
      loading.value = false
    }
  }

  return {
    mfuArrangedActivities,
    loading,
    error,
    fetchMfuArrangedActivities
  }
}
