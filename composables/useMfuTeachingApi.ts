import { ref, readonly } from 'vue'

// MFU Teaching API composable
export const useMfuTeachingApi = () => {
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
    
    // For development, use fallback mapping for known test email
    if (email === '6531503172@lamduan.mfu.ac.th') {
      return '65212167' // Known mapping from database
    }
    
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
          console.log('✅ Successfully authenticated with MFU API')
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

      // Add timeout and retry logic
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

  // Get undergraduate teaching data
  const getUndergraduateData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_Undergraduate', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching undergraduate data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get graduate teaching data
  const getGraduateData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_Graduate', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching graduate data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get undergraduate raw score data (for chart)
  const getUndergraduateRawScore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_UndergraduateRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching undergraduate raw score:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get graduate raw score data (for chart)
  const getGraduateRawScore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_GraduateRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching graduate raw score:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get student internships data
  const getStudentInternships = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_StudentInternships', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching student internships:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get student projects data
  const getStudentProjects = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_StudentProjects', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching student projects:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get thesis oversight duties data
  const getThesisOversightDuties = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ThesisOversightDuties', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching thesis oversight duties:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get other teaching tasks data
  const getOtherTeachingTasks = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_OtherTeachingTasks', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching other teaching tasks:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get all teaching performance data
  const getAllTeachingData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const [
        undergraduateData, 
        graduateData, 
        undergraduateRawScore, 
        graduateRawScore,
        studentInternships,
        studentProjects,
        thesisOversight,
        otherTeachingTasks
      ] = await Promise.all([
        getUndergraduateData(email, evaluateId),
        getGraduateData(email, evaluateId),
        getUndergraduateRawScore(email, evaluateId),
        getGraduateRawScore(email, evaluateId),
        getStudentInternships(email, evaluateId),
        getStudentProjects(email, evaluateId),
        getThesisOversightDuties(email, evaluateId),
        getOtherTeachingTasks(email, evaluateId)
      ])

      return {
        undergraduate: undergraduateData.data,
        graduate: graduateData.data,
        undergraduateRawScore: undergraduateRawScore.data,
        graduateRawScore: graduateRawScore.data,
        studentInternships: studentInternships.data,
        studentProjects: studentProjects.data,
        thesisOversight: thesisOversight.data,
        otherTeachingTasks: otherTeachingTasks.data,
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching all teaching data:', err)
      return { 
        undergraduate: [], 
        graduate: [], 
        undergraduateRawScore: [], 
        graduateRawScore: [],
        studentInternships: [],
        studentProjects: [],
        thesisOversight: [],
        otherTeachingTasks: [],
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
    getUndergraduateData,
    getGraduateData,
    getUndergraduateRawScore,
    getGraduateRawScore,
    getStudentInternships,
    getStudentProjects,
    getThesisOversightDuties,
    getOtherTeachingTasks,
    getAllTeachingData
  }
}
