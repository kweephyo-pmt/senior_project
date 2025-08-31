import { ref, readonly } from 'vue'

// MFU KPI API composable for fetching percentage weights
export const useMfuKpiApi = () => {
  const kpiData = ref<any>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  // API Configuration using Nuxt runtime config
  const runtimeConfig = useRuntimeConfig()
  
  const API_BASE_URL = runtimeConfig.public.apiBaseUrl || 'https://eport.mfu.ac.th/api/master'
  const API_CREDENTIALS = {
    username: runtimeConfig.public.apiUsername || 'sombi',
    password: runtimeConfig.public.apiPassword || 'kTzQmR7pWv9LbYD'
  }

  // Authentication token (reuse from existing API)
  const authToken = ref<string | null>(null)

  // Extract staff code from email using the existing mapping
  const extractStaffCode = async (email: string): Promise<string> => {
    if (!email) return ''
    
    // Known mapping from the user's example
    if (email === '6531503172@lamduan.mfu.ac.th') {
      return '65212167' // Maps to "Ajarn Dr. Supansa Chaising"
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

      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 15000)

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
          console.log('✅ Successfully authenticated with MFU API for KPI data')
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

  // Fetch KPI percentage data from MFU API
  const fetchKpiPercentages = async (email: string, evaluateId: string | number = '9') => {
    try {
      isLoading.value = true
      error.value = null

      // Ensure we have a token
      if (!authToken.value) {
        await login()
      }

      if (!authToken.value) {
        throw new Error('Failed to authenticate')
      }

      const staffCode = await extractStaffCode(email)
      if (!staffCode) {
        throw new Error('Could not extract staff code from email')
      }

      console.log(`Fetching KPI percentages for staff code: ${staffCode}, evaluation period: ${evaluateId}`)

      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 30000)

      try {
        const response = await fetch(`${API_BASE_URL}/get_Percentage`, {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${authToken.value}`,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'evaluateid': evaluateId.toString(),
            'lang': 'en',
            'staffcode': staffCode
          },
          signal: controller.signal
        })

        clearTimeout(timeoutId)
        const responseText = await response.text()
        
        if (response.ok) {
          const apiResponse = JSON.parse(responseText)
          
          if (apiResponse.code === 200 && apiResponse.data && Array.isArray(apiResponse.data)) {
            // Find the staff member's data by staffcode
            const staffData = apiResponse.data.find((item: any) => item.staffcode === staffCode)
            
            if (staffData) {
              // Check if all weights are 0 or null/undefined (no data for this period)
              const hasValidData = staffData.domain1weight > 0 || staffData.domain2weight > 0 || 
                                 staffData.domain3weight > 0 || staffData.domain4weight > 0 || 
                                 staffData.domain5weight > 0
              
              if (!hasValidData) {
                // No data available for this evaluation period
                kpiData.value = null
                console.log('⚠️ No KPI data available for evaluation period:', evaluateId)
                return null
              }

              // Transform the API data into the format expected by the UI
              const transformedData = {
                staffCode: staffData.staffcode,
                staffName: staffData.staffname,
                categories: [
                  {
                    id: 'teaching',
                    name: 'Teaching',
                    weight: staffData.domain1weight || 0,
                    value: staffData.domain1weight || 0,
                    percent: staffData.domain1weight || 0,
                    color: '#1e40af'
                  },
                  {
                    id: 'research',
                    name: 'Research',
                    weight: staffData.domain2weight || 0,
                    value: staffData.domain2weight || 0,
                    percent: staffData.domain2weight || 0,
                    color: '#0891b2'
                  },
                  {
                    id: 'academic-service',
                    name: 'Academic Service',
                    weight: staffData.domain3weight || 0,
                    value: staffData.domain3weight || 0,
                    percent: staffData.domain3weight || 0,
                    color: '#059669'
                  },
                  {
                    id: 'administration',
                    name: 'Administration',
                    weight: staffData.domain4weight || 0,
                    value: staffData.domain4weight || 0,
                    percent: staffData.domain4weight || 0,
                    color: '#7c3aed'
                  },
                  {
                    id: 'arts-culture',
                    name: 'Arts and Culture',
                    weight: staffData.domain5weight || 0,
                    value: staffData.domain5weight || 0,
                    percent: staffData.domain5weight || 0,
                    color: '#dc2626'
                  }
                ]
              }

              kpiData.value = transformedData
              console.log('✅ Successfully fetched KPI percentages from MFU API:', transformedData)
              return transformedData
            } else {
              throw new Error(`No data found for staff code: ${staffCode}`)
            }
          } else {
            throw new Error('Invalid API response format')
          }
        } else {
          throw new Error(`API request failed: ${response.status} - ${responseText}`)
        }
      } catch (fetchError: any) {
        clearTimeout(timeoutId)
        
        if (fetchError.name === 'AbortError') {
          throw new Error('Request timeout: KPI percentage fetch took longer than 30 seconds')
        }
        
        if (fetchError.code === 'ECONNRESET' || fetchError.message.includes('ECONNRESET')) {
          throw new Error('Connection reset by server. The MFU API server may be temporarily unavailable.')
        }
        
        throw fetchError
      }
    } catch (err: any) {
      error.value = err.message
      console.error('Error fetching KPI percentages:', err)
      kpiData.value = null
      throw err
    } finally {
      isLoading.value = false
    }
  }

  return {
    // State
    kpiData: readonly(kpiData),
    isLoading: readonly(isLoading),
    error: readonly(error),
    
    // Methods
    fetchKpiPercentages,
    extractStaffCode
  }
}
