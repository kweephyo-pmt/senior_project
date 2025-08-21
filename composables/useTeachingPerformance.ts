import { ref } from 'vue'
import { useFirebaseAuth } from './useFirebaseAuth' // Make sure to import useFirebaseAuth from the correct location
import { $fetch } from 'ofetch' // Make sure to import $fetch from the correct location

interface TeachingPerformanceData {
  category: string;
  lecture_score: number;
  lab_score: number;
  display_order: number;
}

export const useTeachingPerformance = () => {
  const { user } = useFirebaseAuth();
  const teachingData = ref<TeachingPerformanceData[]>([]);
  const loading = ref(false);
  const error = ref<string | null>(null);

  // Extract staff code from email (e.g., 6531503172@lamduan.mfu.ac.th -> 6531503172)
  const extractStaffCode = (email: string): string => {
    const match = email.match(/^(\d+)@/);
    return match ? match[1] : '';
  };

  const fetchTeachingPerformance = async (evaluateId?: number) => {
    if (!user.value?.email) {
      error.value = 'User email not available';
      return;
    }

    loading.value = true;
    error.value = null;
    teachingData.value = []; // Clear existing data before fetching new data
    
    try {
      const staffCode = extractStaffCode(user.value.email);
      if (!staffCode) {
        throw new Error('Invalid email format - cannot extract staff code');
      }

      // Build URL with optional evaluateid query parameter
      let url = `https://senior-project-backend-51782680110.asia-southeast1.run.app/api/teaching-performance/${staffCode}`;
      if (evaluateId) {
        url += `?evaluateid=${evaluateId}`;
      }

      const response = await $fetch(url);
      
      if (response.success) {
        teachingData.value = response.data || [];
      } else {
        teachingData.value = []; // Clear data on error
        throw new Error(response.message || 'Failed to fetch teaching performance data');
      }
    } catch (err: any) {
      console.error('Error fetching teaching performance data:', err);
      error.value = err.message || 'Failed to fetch teaching performance data';
      teachingData.value = []; // Clear data on error
    } finally {
      loading.value = false;
    }
  };

  // Get chart data in the format expected by Chart.js
  const getChartData = () => {
    const labels = teachingData.value.map(item => {
      // Split long category names into multiple lines for better display
      if (item.category.length > 25) {
        const words = item.category.split(' ')
        const midpoint = Math.ceil(words.length / 2)
        return [words.slice(0, midpoint).join(' '), words.slice(midpoint).join(' ')]
      }
      return item.category
    })

    const lectureData = teachingData.value.map(item => Number(item.lecture_score) || 0)
    const labData = teachingData.value.map(item => Number(item.lab_score) || 0)

    return {
      labels,
      datasets: [
        {
          label: "Lecture (Score)",
          data: lectureData,
          backgroundColor: "#172554",
          borderWidth: 0,
          borderRadius: 0,
          stack: 'Stack 0',
        },
        {
          label: "Lab (Score)",
          data: labData,
          backgroundColor: "#a21a5b",
          borderWidth: 0,
          borderRadius: 0,
          stack: 'Stack 0',
        },
      ],
    }
  }

  return {
    teachingData,
    loading,
    error,
    fetchTeachingPerformance,
    getChartData
  }
}
