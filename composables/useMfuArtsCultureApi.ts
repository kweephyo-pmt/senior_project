import { ref, readonly } from 'vue'

// MFU Arts and Culture API composable (Domain 5)
export const useMfuArtsCultureApi = () => {
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
      throw err
    }
  }

  // Get Self Development data
  const getSelfDevelopment = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_Selfdevelopment', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get MFU Arranged Activities data (for table)
  const getMFUArrangedActivities = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_MFUarrangedactivities', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get MFU Arranged Activities Raw Score data (for chart)
  const getMFUArrangedActivitiesRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_MFUarrangedactivitiesRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get Student Development Activities Raw Score data (for chart)
  const getStudentDevelopmentActivitiesRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_StudentdevelopmentactivitiesRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get Self Development Raw Score data (for chart)
  const getSelfDevelopmentRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_SelfdevelopmentRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get Organization Development or Participation Raw Score data (for chart)
  const getOrganizationDevelopmentOrParticipationRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_OrganizationdevelopmentorparticipationRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get Arts and Culture Conservation Performance Raw Score data (for chart)
  const getArtsAndCultureConservationPerformanceRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ArtsandCultureConservationPerformanceRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get all Arts and Culture chart data from the five rawscore API endpoints
  const getAllArtsCultureChartData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const [
        mfuArrangedActivitiesRawscore,
        studentDevelopmentActivitiesRawscore,
        selfDevelopmentRawscore,
        organizationDevelopmentRawscore,
        artsCultureConservationRawscore
      ] = await Promise.all([
        getMFUArrangedActivitiesRawscore(email, evaluateId),
        getStudentDevelopmentActivitiesRawscore(email, evaluateId),
        getSelfDevelopmentRawscore(email, evaluateId),
        getOrganizationDevelopmentOrParticipationRawscore(email, evaluateId),
        getArtsAndCultureConservationPerformanceRawscore(email, evaluateId)
      ])

      return {
        mfuArrangedActivitiesRawscore: mfuArrangedActivitiesRawscore.data,
        studentDevelopmentActivitiesRawscore: studentDevelopmentActivitiesRawscore.data,
        selfDevelopmentRawscore: selfDevelopmentRawscore.data,
        organizationDevelopmentRawscore: organizationDevelopmentRawscore.data,
        artsCultureConservationRawscore: artsCultureConservationRawscore.data,
        staffCode,
        evaluateId
      }
    } catch (err) {
      return { 
        mfuArrangedActivitiesRawscore: [],
        studentDevelopmentActivitiesRawscore: [],
        selfDevelopmentRawscore: [],
        organizationDevelopmentRawscore: [],
        artsCultureConservationRawscore: [],
        staffCode, 
        evaluateId 
      }
    }
  }

  return {
    // State
    authToken: readonly(authToken),
    isLoading: readonly(isLoading),
    error: readonly(error),
    
    // Methods
    login,
    extractStaffCode,
    getSelfDevelopment,
    getMFUArrangedActivities,
    getMFUArrangedActivitiesRawscore,
    getStudentDevelopmentActivitiesRawscore,
    getSelfDevelopmentRawscore,
    getOrganizationDevelopmentOrParticipationRawscore,
    getArtsAndCultureConservationPerformanceRawscore,
    getAllArtsCultureChartData
  }
}

export default useMfuArtsCultureApi
