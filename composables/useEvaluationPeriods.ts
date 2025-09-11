interface EvaluationPeriod {
  evaluateid: number;
  evaluatename: string;
  evaluatestartdate: string;
  evaluateenddate: string;
}

export const useEvaluationPeriods = () => {
  const evaluationPeriods = ref<EvaluationPeriod[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);

  const fetchEvaluationPeriods = async () => {
    loading.value = true;
    error.value = null;
    
    try {
      const config = useRuntimeConfig();
      // Use fallback values for production reliability
      const apiBaseUrl = config.public.apiBaseUrl || 'https://eport.mfu.ac.th/api/master';
      const username = config.public.apiUsername || 'sombi';
      const password = config.public.apiPassword || 'kTzQmR7pWv9LbYD';
      
      console.log('Fetching evaluation periods with config:', { apiBaseUrl, username });
      
      // First, get authentication token
      console.log('Attempting authentication...');
      const authResponse = await $fetch(`${apiBaseUrl}/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username,
          password
        })
      }) as any;
      
      // Authentication successful
      
      if (!authResponse || authResponse.success !== 1) {
        console.error('Authentication failed:', authResponse);
        throw new Error(`Authentication failed: ${authResponse?.message || 'Invalid credentials'}`);
      }
      
      // Then fetch evaluation periods
      console.log('Fetching evaluation periods...');
      const response = await $fetch(`${apiBaseUrl}/get_Evaluate`, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${authResponse.token}`,
          'Content-Type': 'application/json',
          'evaluateid': '9',
          'lang': 'en'
        }
      }) as any;
      
      console.log('Evaluation periods response:', response);
      
      if (response.code === 200) {
        evaluationPeriods.value = response.data;
      } else {
        throw new Error(response.message?.en || 'Failed to fetch evaluation periods');
      }
    } catch (err: any) {
      console.error('Error fetching evaluation periods:', err);
      error.value = err.message || 'Failed to fetch evaluation periods';
      
      // Fallback to mock data if API fails
      console.log('Using fallback evaluation periods data');
      evaluationPeriods.value = [
        {
          evaluateid: 9,
          evaluatename: 'Round 1/2025',
          evaluatestartdate: '2025-01-01',
          evaluateenddate: '2025-06-30'
        },
        {
          evaluateid: 8,
          evaluatename: 'Round 2/2024',
          evaluatestartdate: '2024-07-01',
          evaluateenddate: '2024-12-31'
        },
        {
          evaluateid: 7,
          evaluatename: 'Round 1/2024',
          evaluatestartdate: '2024-01-01',
          evaluateenddate: '2024-06-30'
        }
      ];
    } finally {
      loading.value = false;
    }
  };

  // Get the currently active evaluation period (most recent one with data)
  const activeEvaluationPeriod = computed(() => {
    if (evaluationPeriods.value.length === 0) return null;
    
    // Find the current evaluation period based on current date
    const now = new Date();
    const currentPeriod = evaluationPeriods.value.find(period => {
      const startDate = new Date(period.evaluatestartdate);
      const endDate = new Date(period.evaluateenddate);
      return now >= startDate && now <= endDate;
    });
    
    // If current period found and it's not future periods (11+), use it
    if (currentPeriod && currentPeriod.evaluateid <= 10) {
      return currentPeriod;
    }
    
    // Otherwise, return evaluateid 9 (1/2025) as default since it has data
    return evaluationPeriods.value.find(period => period.evaluateid === 9) || 
           evaluationPeriods.value[0];
  });

  return {
    evaluationPeriods: readonly(evaluationPeriods),
    loading: readonly(loading),
    error: readonly(error),
    activeEvaluationPeriod,
    fetchEvaluationPeriods
  };
};
