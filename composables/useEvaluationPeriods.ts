interface EvaluationPeriod {
  evaluateid: number;
  evaluatename: string;
  evaluatestartdate: string;
  evaluateenddate: string;
  is_active: number;
}

export const useEvaluationPeriods = () => {
  const evaluationPeriods = ref<EvaluationPeriod[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);

  const fetchEvaluationPeriods = async () => {
    loading.value = true;
    error.value = null;
    
    try {
      const response = await $fetch('https://senior-project-backend-51782680110.asia-southeast1.run.app/api/evaluation-periods') as any;
      
      if (response.success) {
        evaluationPeriods.value = response.data;
      } else {
        throw new Error(response.message || 'Failed to fetch evaluation periods');
      }
    } catch (err: any) {
      console.error('Error fetching evaluation periods:', err);
      error.value = err.message || 'Failed to fetch evaluation periods';
      
      // Fallback to mock data
      evaluationPeriods.value = [
        {
          evaluateid: 9,
          evaluatename: '1/2025',
          evaluatestartdate: '2025-01-01',
          evaluateenddate: '2025-06-30',
          is_active: 1
        },
        {
          evaluateid: 8,
          evaluatename: '2/2024',
          evaluatestartdate: '2024-07-01',
          evaluateenddate: '2024-12-31',
          is_active: 0
        },
        {
          evaluateid: 7,
          evaluatename: '1/2024',
          evaluatestartdate: '2024-01-01',
          evaluateenddate: '2024-06-30',
          is_active: 0
        }
      ];
    } finally {
      loading.value = false;
    }
  };

  // Get the currently active evaluation period
  const activeEvaluationPeriod = computed(() => {
    return evaluationPeriods.value.find(period => period.is_active === 1) || evaluationPeriods.value[0];
  });

  return {
    evaluationPeriods: readonly(evaluationPeriods),
    loading: readonly(loading),
    error: readonly(error),
    activeEvaluationPeriod,
    fetchEvaluationPeriods
  };
};
