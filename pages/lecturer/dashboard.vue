<template>
  <!-- Overview Banner with background image -->
  <div class="relative h-56 overflow-hidden">
    <div class="absolute inset-0">
      <img :src="bgImage" alt="Background" class="w-full h-full object-cover opacity-60" />
    </div>
    <div class="absolute inset-0 bg-black/30"></div>
    <div class="relative container mx-auto px-20 pt-8 z-10">
      <h1 class="text-[82px] font-bold text-[#1D3555] leading-tight">Overview</h1>
      <h2 class="text-2xl text-[#1D3555] px-1.5 mt-1">Welcome back, {{ user?.displayName || 'User' }}</h2>
    </div>
  </div>

  <!-- Content Area -->
  <div class="px-6 py-8 max-w-7xl mx-auto min-h-[calc(100vh-14rem)]">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8">
      <!-- Left Column: Education & Research Area -->
      <div class="md:col-span-1">
        <div class="bg-white rounded-xl shadow-lg p-6 mb-6">
          <h3 class="text-xl font-bold text-gray-800 mb-3 border-b pb-2">Education</h3>
          <ul class="space-y-3">
            <li v-for="(edu, idx) in education" :key="idx" class="relative pl-8">
              <span class="absolute left-0 top-1.5 w-3 h-3 rounded-full bg-blue-500"></span>
              <div class="flex flex-col">
                <span class="font-bold text-lg text-gray-900">{{ edu.year }}</span>
                <span class="font-semibold text-gray-800">{{ edu.degree }}</span>
                <span class="text-gray-600 text-sm">{{ edu.institution }}</span>
              </div>
            </li>
          </ul>
        </div>
        <div class="bg-white rounded-xl shadow p-4">
          <h3 class="text-xl font-bold text-gray-800 mb-2 border-b pb-2">Research Area</h3>
          <ul class="space-y-3 list-disc list-inside ml-2">
            <li v-for="(area, idx) in researchAreas" :key="idx" class="text-gray-700 text-base">{{ area }}</li>
          </ul>
        </div>
      </div>
      <!-- Right Column: Contact & Publications -->
      <div class="md:col-span-2 flex flex-col gap-4">
        <!-- Contact Card -->
        <div class="flex flex-col md:flex-row items-center bg-white rounded-xl shadow p-4 gap-4 mb-3">
          <div class="flex-shrink-0">
            <div class="w-20 h-20 rounded-full overflow-hidden border-4 border-blue-300 bg-white shadow">
              <img :src="user?.photoURL || 'https://ui-avatars.com/api/?name=' + encodeURIComponent(user?.displayName || 'User')" :alt="user?.displayName || 'User'" class="w-full h-full object-cover" />
            </div>
          </div>
          <div class="flex-1 min-w-0">
            <h2 class="text-2xl font-bold text-gray-800">{{ user?.displayName || 'User' }}(SA)</h2>
            <p class="text-gray-600 mb-2">Accounting Program</p>
            <div class="flex flex-col gap-4 mt-4 text-gray-700">
              <!-- Email -->
              <div class="flex items-center gap-3">
                <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-blue-100">
                  <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4 4h16v16H4V4zm0 0l8 8 8-8"/></svg>
                </span>
                <span class="text-base">{{ user?.email || 'n/a' }}</span>
              </div>
              <!-- Phone -->
              <div class="flex items-center gap-3">
                <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-green-100">
                  <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 5a2 2 0 012-2h2.28a2 2 0 011.7 1.06l1.1 2.21a2 2 0 01-.45 2.32l-.7.7a16.06 16.06 0 006.58 6.58l.7-.7a2 2 0 012.32-.45l2.21 1.1A2 2 0 0121 18.72V21a2 2 0 01-2 2h-1C7.82 23 1 16.18 1 8V7a2 2 0 012-2z"/></svg>
                </span>
                <span class="text-base">{{ userInfo.phone || 'n/a' }}</span>
              </div>
              <!-- Location -->
              <div class="flex items-center gap-3">
                <span class="inline-flex items-center justify-center w-9 h-9 rounded-full bg-purple-100">
                  <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 21s-6-5.686-6-10a6 6 0 1112 0c0 4.314-6 10-6 10zm0-8a2 2 0 100-4 2 2 0 000 4z"/></svg>
                </span>
                <span class="text-base">{{ userInfo.location || 'n/a' }}</span>
              </div>
            </div>
          </div>
        </div>
        <!-- Publications Card -->
        <div class="bg-white rounded-xl shadow p-4">
          <div class="flex justify-between items-center mb-3">
            <h3 class="text-xl font-bold text-gray-800">Recent Publications</h3>
            <NuxtLink to="/lecturer/publications" class="text-blue-600 text-base hover:underline">View All</NuxtLink>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
            <div v-for="(pub, idx) in publications" :key="idx" class="bg-blue-50 rounded-lg p-3 flex flex-col justify-between shadow hover:shadow-lg transition">
              <div>
                <p class="font-semibold text-blue-900 text-base mb-1">{{ pub.title }}</p>
                <p class="text-gray-600 text-sm mb-2">{{ pub.venue }} &bull; {{ pub.year }}</p>
                <a :href="pub.link" v-if="pub.link" class="inline-block px-2 py-0.5 bg-blue-200 text-blue-800 rounded text-xs font-semibold mb-2">Link</a>
              </div>
              <div class="flex items-center gap-2 mt-4">
                <img :src="user?.photoURL || 'https://ui-avatars.com/api/?name=' + encodeURIComponent(user?.displayName || 'User')" class="w-7 h-7 rounded-full border border-blue-300" />
                <span class="text-sm text-gray-700 font-medium">{{ user?.displayName || 'User' }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import bgImage from '~/assets/background.png'

definePageMeta({
  layout: 'lecturer'
})

// Mockup data
const { user } = useFirebaseAuth()

// Example user info (replace with real data or API call as needed)
const userInfo = ref({
  phone: '081-234-5678',
  location: 'Chiang Rai, Thailand',
})

const education = ref([
  { degree: 'Ph.D. in Management', institution: 'Mae Fah Luang University', year: 2020 },
  { degree: 'M.B.A.', institution: 'Chulalongkorn University', year: 2015 },
  { degree: 'B.B.A.', institution: 'Chiang Mai University', year: 2012 },
])

const researchAreas = ref([
  'Business Intelligence and Data Analytics',
  'Machine Learning Applications in Management',
  'Higher Education Administration',
  'Research Collaboration Networks',
])

const publications = ref([
  { title: 'A Novel Approach to Sentiment Analysis', venue: 'Journal of Data Science', year: 2024, link: '#' },
  { title: 'Machine Learning in Education', venue: 'International Conference on AI', year: 2023, link: '#' },
  { title: 'Optimizing Research Collaboration', venue: 'Research Management Review', year: 2023, link: '#' },
])
</script>
