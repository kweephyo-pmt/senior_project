import { ref } from 'vue'

// MFU Administration API composable
export const useMfuAdministrationApi = () => {
  const authToken = ref<string | null>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // API Configuration using Nuxt runtime config
  const runtimeConfig = useRuntimeConfig()

  const API_BASE_URL = runtimeConfig.public.apiBaseUrl || 'https://eport.mfu.ac.th/api/master'
  const API_CREDENTIALS = {
    username: runtimeConfig.public.apiUsername || 'sombi',
    password: runtimeConfig.public.apiPassword || 'kTzQmR7pWv9LbYD'
  }

  // Extract staff code from email by looking up in lecturer_profiles database
  const extractStaffCode = async (email: string): Promise<string> => {
    if (!email) return ''

    try {
      // Use production API URL for staff code lookup
      const response = await fetch('https://senior-project-backend-51782680110.asia-southeast1.run.app/api/lecturer/lookup-staffcode', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      })
      if (response.ok) {
        const data = await response.json()
        return data.staffCode || ''
      }
      return ''
    } catch (err) {
      console.error('Could not find staff code for email:', email)
      // Fallback: try to extract from email format (6531503172@lamduan.mfu.ac.th -> 6531503172)
      const match = email.match(/^(\d+)@/)
      return match ? match[1] : ''
    }
  }

  // Login to get authentication token
  const login = async (): Promise<string | null> => {
    try {
      isLoading.value = true
      error.value = null

      // Add timeout for login request
      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 15000) // 15 second timeout for login

      try {
        const response = await fetch(`${API_BASE_URL}/login`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify({
            username: API_CREDENTIALS.username,
            password: API_CREDENTIALS.password
          }),
          signal: controller.signal
        })

        clearTimeout(timeoutId)
        const responseText = await response.text()

        if (response.ok) {
          const data = JSON.parse(responseText)
          authToken.value = data.token || data.access_token || data.bearer_token
          return authToken.value
        } else {
          throw new Error(`Authentication failed: ${response.status} - ${responseText}`)
        }
      } catch (fetchError: any) {
        clearTimeout(timeoutId)

        if (fetchError.name === 'AbortError') {
          throw new Error('Login timeout: Authentication took longer than 15 seconds')
        }

        if (fetchError.code === 'ECONNRESET' || fetchError.message.includes('ECONNRESET')) {
          throw new Error('Connection reset during authentication. The MFU API server may be temporarily unavailable.')
        }

        throw fetchError
      }
    } catch (err: any) {
      error.value = err.message
      console.error('❌ Authentication error:', err)
      return null
    } finally {
      isLoading.value = false
    }
  }

  // Generic API call with authentication
  const makeAuthenticatedRequest = async (endpoint: string, staffCode: string, evaluateId: string = '9', lang: string = 'en') => {
    try {
      // Ensure we have a token
      if (!authToken.value) {
        await login()
      }

      if (!authToken.value) {
        throw new Error('Failed to authenticate')
      }

      const headers: Record<string, string> = {
        'Authorization': `Bearer ${authToken.value}`,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'evaluateid': evaluateId,
        'lang': lang,
        'staffcode': staffCode
      }

      // Add timeout
      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 30000) // 30 second timeout

      try {
        const response = await fetch(`${API_BASE_URL}/${endpoint}`, {
          method: 'GET',
          headers: headers,
          signal: controller.signal
        })

        clearTimeout(timeoutId)
        const responseText = await response.text()

        if (response.ok) {
          return JSON.parse(responseText)
        } else {
          throw new Error(`API request failed: ${response.status} - ${responseText}`)
        }
      } catch (fetchError: any) {
        clearTimeout(timeoutId)

        if (fetchError.name === 'AbortError') {
          throw new Error(`Request timeout: ${endpoint} took longer than 30 seconds`)
        }

        if (fetchError.code === 'ECONNRESET' || fetchError.message.includes('ECONNRESET')) {
          throw new Error(`Connection reset by server: ${endpoint}. The MFU API server may be temporarily unavailable.`)
        }

        throw fetchError
      }
    } catch (err: any) {
      error.value = err.message
      console.error(`Error calling ${endpoint}:`, err)
      throw err
    }
  }

  // Get academic administration data
  const getAcademicAdministration = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_AcademicAdministrationassignedbytheSchoolorUniversityRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching academic administration data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get guest lecturer coordination data
  const getGuestLecturerCoordination = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_CoordinationwithaGuestLecturerRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching guest lecturer coordination data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get course coordination data
  const getCourseCoordination = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_CourseCoordinationRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching course coordination data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get university committee data
  const getUniversityCommittee = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_UniversityCommitteeorCommitteeAppointedWorkingGroupRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching university committee data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get school committee data
  const getSchoolCommittee = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_SchoolCommitteeorCommitteeAppointedWorkingGroupRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching school committee data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get school committee list
  const getSchoolCommitteeList = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_SchoolCommittee',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching school committee list:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get curricular committee data
  const getCurricularCommittee = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_CurricularCommittee',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching curricular committee data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get administrative duty data
  const getAdministrativeDuty = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest(
        'get_AdministrativedutyassignedbytheSchoolRawscore',
        staffCode,
        evaluateId
      )
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching administrative duty data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get all administration data in parallel
  const getAllAdministrationData = async (email: string, evaluateId: string = '9') => {
    try {
      const [
        academicAdmin,
        guestLecturer,
        courseCoordination,
        universityCommittee,
        schoolCommittee,
        schoolCommitteeList,
        curricularCommittee,
        administrativeDuty
      ] = await Promise.all([
        getAcademicAdministration(email, evaluateId),
        getGuestLecturerCoordination(email, evaluateId),
        getCourseCoordination(email, evaluateId),
        getUniversityCommittee(email, evaluateId),
        getSchoolCommittee(email, evaluateId),
        getSchoolCommitteeList(email, evaluateId),
        getCurricularCommittee(email, evaluateId),
        getAdministrativeDuty(email, evaluateId)
      ])

      return {
        academicAdministration: academicAdmin.data,
        guestLecturer: guestLecturer.data,
        courseCoordination: courseCoordination.data,
        universityCommittee: universityCommittee.data,
        schoolCommittee: schoolCommittee.data,
        schoolCommitteeList: schoolCommitteeList.data,
        curricularCommittee: curricularCommittee.data,
        administrativeDuty: administrativeDuty.data,
        staffCode: academicAdmin.staffCode || '',
        evaluateId: academicAdmin.evaluateId || evaluateId
      }
    } catch (error) {
      console.error('Error fetching all administration data:', error)
      throw error
    }
  }

  return {
    // State
    isLoading,
    error,

    // Methods
    getAcademicAdministration,
    getGuestLecturerCoordination,
    getCourseCoordination,
    getUniversityCommittee,
    getSchoolCommittee,
    getSchoolCommitteeList,
    getCurricularCommittee,
    getAdministrativeDuty,
    getAllAdministrationData
  }
}

export default useMfuAdministrationApi