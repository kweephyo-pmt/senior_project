import { ref, readonly } from 'vue'

// MFU Research API composable
export const useMfuResearchApi = () => {
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
          // Authentication successful
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

  // Get research studies data
  const getResearchStudies = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ResearchStudies', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching research studies:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get research publications data
  const getResearchPublications = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ResearchPublication', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching research publications:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get research studies raw score data
  const getResearchStudiesRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ResearchStudiesRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching research studies rawscore:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get research publication raw score data
  const getResearchPublicationRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_ResearchPublicationRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching research publication rawscore:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get academic articles raw score data
  const getAcademicArticlesRawscore = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_AcademicArticlesRawscore', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching academic articles rawscore:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get composition of textbooks data
  const getCompositionofTextbooks = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_CompositionofTextbooks', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching composition of textbooks:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get patented inventions data
  const getPatentedInventions = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_PatentedInventions', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching patented inventions:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get other academic work data
  const getOtherAcademicWork = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_OtherAcademicWork', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching other academic work:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get other academic work assigned by the school data
  const getOtherAcademicWorkassignedbytheSchool = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_OtherAcademicWorkassignedbytheSchool', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching other academic work assigned by school:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Get percentage data (KPI weights and scores)
  const getPercentage = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const data = await makeAuthenticatedRequest('get_Percentage', staffCode, evaluateId)
      return {
        data: data?.data || [],
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching percentage data:', err)
      return { data: [], staffCode, evaluateId }
    }
  }

  // Format research studies data for display
  const formatResearchStudiesData = (data: any[]) => {
    if (!Array.isArray(data)) return []
    
    return data.map((item, index) => ({
      id: item.id || index + 1,
      level: item.level || index + 1,
      projectName: item.researchtitle || item.projectname || item.project_name || item.title || 'Untitled Research Study',
      staffCode: item.staffcode || item.staff_code,
      evaluateId: item.evaluateid || item.evaluate_id,
      // Additional fields that might be available
      description: item.description || '',
      status: item.status || '',
      startDate: item.start_date || item.startdate,
      endDate: item.end_date || item.enddate,
      budget: item.budget || 0,
      fundingSource: item.funding_source || item.fundingsource || ''
    }))
  }

  // Format research publications data for display
  const formatResearchPublicationsData = (data: any[]) => {
    if (!Array.isArray(data)) return []
    
    return data.map((item, index) => ({
      id: item.id || index + 1,
      level: item.level || index + 1,
      projectName: item.researchtitle || item.publicationtitle || item.title || item.projectname || 'Untitled Research Publication',
      staffCode: item.staffcode || item.staff_code,
      evaluateId: item.evaluateid || item.evaluate_id,
      // Additional fields that might be available
      authors: item.authors || '',
      journal: item.journal || '',
      year: item.year || '',
      doi: item.doi || '',
      isbn: item.isbn || '',
      publisher: item.publisher || ''
    }))
  }

  // Get all research chart data from the seven API endpoints
  const getAllResearchChartData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const [
        researchStudiesRawscore,
        researchPublicationRawscore,
        academicArticlesRawscore,
        compositionofTextbooks,
        patentedInventions,
        otherAcademicWork,
        otherAcademicWorkAssignedBySchool
      ] = await Promise.all([
        getResearchStudiesRawscore(email, evaluateId),
        getResearchPublicationRawscore(email, evaluateId),
        getAcademicArticlesRawscore(email, evaluateId),
        getCompositionofTextbooks(email, evaluateId),
        getPatentedInventions(email, evaluateId),
        getOtherAcademicWork(email, evaluateId),
        getOtherAcademicWorkassignedbytheSchool(email, evaluateId)
      ])

      return {
        researchStudiesRawscore: researchStudiesRawscore.data,
        researchPublicationRawscore: researchPublicationRawscore.data,
        academicArticlesRawscore: academicArticlesRawscore.data,
        compositionofTextbooks: compositionofTextbooks.data,
        patentedInventions: patentedInventions.data,
        otherAcademicWork: otherAcademicWork.data,
        otherAcademicWorkAssignedBySchool: otherAcademicWorkAssignedBySchool.data,
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching all research chart data:', err)
      return { 
        researchStudiesRawscore: [],
        researchPublicationRawscore: [],
        academicArticlesRawscore: [],
        compositionofTextbooks: [],
        patentedInventions: [],
        otherAcademicWork: [],
        otherAcademicWorkAssignedBySchool: [],
        staffCode, 
        evaluateId 
      }
    }
  }

  // Get all research data (can be extended for other research endpoints)
  const getAllResearchData = async (email: string, evaluateId: string = '9') => {
    const staffCode = await extractStaffCode(email)
    if (!staffCode) throw new Error('Invalid email format - cannot extract staff code')

    try {
      const [researchStudiesData, researchPublicationsData] = await Promise.all([
        getResearchStudies(email, evaluateId),
        getResearchPublications(email, evaluateId)
      ])

      return {
        researchStudies: researchStudiesData.data,
        researchPublications: researchPublicationsData.data,
        staffCode,
        evaluateId
      }
    } catch (err) {
      console.error('Error fetching all research data:', err)
      return { 
        researchStudies: [],
        researchPublications: [],
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
    getResearchStudies,
    getResearchPublications,
    getResearchStudiesRawscore,
    getResearchPublicationRawscore,
    getAcademicArticlesRawscore,
    getCompositionofTextbooks,
    getPatentedInventions,
    getOtherAcademicWork,
    getOtherAcademicWorkassignedbytheSchool,
    getPercentage,
    formatResearchStudiesData,
    formatResearchPublicationsData,
    getAllResearchChartData,
    getAllResearchData
  }
}
