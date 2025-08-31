import { ref, readonly } from 'vue'

export const useMfuKpiApi = () => {
  const kpiData = ref<any>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)

  const runtimeConfig = useRuntimeConfig()
  const API_BASE_URL = runtimeConfig.public.apiBaseUrl || 'https://eport.mfu.ac.th/api/master'
  const API_CREDENTIALS = {
    username: runtimeConfig.public.apiUsername || 'sombi',
    password: runtimeConfig.public.apiPassword || 'kTzQmR7pWv9LbYD'
  }

  const authToken = ref<string | null>(null)

  const extractStaffCode = async (email: string): Promise<string> => {
    if (!email) return ''
    
    try {
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
      const match = email.match(/^(\d+)@/)
      return match ? match[1] : ''
    }
  }

  const login = async (): Promise<string | null> => {
    try {
      isLoading.value = true
      error.value = null

      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 15000)

      const response = await fetch(`${API_BASE_URL}/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify(API_CREDENTIALS),
        signal: controller.signal
      })

      clearTimeout(timeoutId)
      const responseText = await response.text()
      
      if (response.ok) {
        const data = JSON.parse(responseText)
        authToken.value = data.token || data.access_token || data.bearer_token
        return authToken.value
      } else {
        throw new Error(`Authentication failed: ${response.status}`)
      }
    } catch (err: any) {
      if (err.name === 'AbortError') {
        error.value = 'Login timeout'
      } else {
        error.value = err.message
      }
      return null
    } finally {
      isLoading.value = false
    }
  }

  const fetchKpiPercentages = async (email: string, evaluateId: string | number = '9') => {
    try {
      isLoading.value = true
      error.value = null

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

      const controller = new AbortController()
      const timeoutId = setTimeout(() => controller.abort(), 30000)

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
          const staffData = apiResponse.data.find((item: any) => item.staffcode === staffCode)
          
          if (staffData) {
            const hasValidData = staffData.domain1weight > 0 || staffData.domain2weight > 0 || 
                               staffData.domain3weight > 0 || staffData.domain4weight > 0 || 
                               staffData.domain5weight > 0
            
            if (!hasValidData) {
              kpiData.value = null
              return null
            }

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
            return transformedData
          } else {
            throw new Error(`No data found for staff code: ${staffCode}`)
          }
        } else {
          throw new Error('Invalid API response format')
        }
      } else {
        throw new Error(`API request failed: ${response.status}`)
      }
    } catch (err: any) {
      if (err.name === 'AbortError') {
        error.value = 'Request timeout'
      } else {
        error.value = err.message
      }
      kpiData.value = null
      throw err
    } finally {
      isLoading.value = false
    }
  }

  return {
    kpiData: readonly(kpiData),
    isLoading: readonly(isLoading),
    error: readonly(error),
    fetchKpiPercentages,
    extractStaffCode
  }
}
