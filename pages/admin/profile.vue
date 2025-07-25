<template>
  <div class="min-h-screen bg-gray-100">
    <div class="container mx-auto px-4 py-6">
    <!-- Header -->
    <div class="flex items-center mb-6">
      <button @click="goBack" class="mr-4 text-gray-600 hover:text-blue-600 focus:outline-none" aria-label="Back">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
      </button>
      <h1 class="text-2xl font-bold text-gray-800">Edit Profile</h1>
    </div>

    <!-- Profile Info -->
    <div class="bg-white shadow rounded-xl p-6 mb-8">
      <div class="flex flex-col items-center justify-center mb-6">
        <div class="w-24 h-24 rounded-full overflow-hidden">
          <img :src="profile.photoUrl" alt="Profile Photo" class="w-full h-full object-cover" />
        </div>
        <div class="mt-2 flex items-center gap-2">
          <label class="flex items-center gap-1 cursor-pointer">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path d="M4 7V6a2 2 0 012-2h3V2h6v2h3a2 2 0 012 2v1" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
              <rect x="4" y="7" width="16" height="13" rx="2" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
              <circle cx="12" cy="13.5" r="3.5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <span class="text-sm text-[#036E94] font-medium hover:underline">Change Photo</span>
            <input type="file" @change="onFileChange" class="hidden" />
          </label>
        </div>
      </div>
      <div class="mt-6">
        <h2 class="text-lg font-semibold mb-4 text-gray-800">Information</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <template v-for="(field, idx) in [
            { label: 'Full Name', model: 'fullName' },
            { label: 'Email', model: 'email' },
            { label: 'Phone Number', model: 'phone' },
            { label: 'Department', model: 'department' },
            { label: 'Faculty / Position', model: 'position' },
            { label: 'Office Location', model: 'office' }
          ]" :key="field.model">
            <div>
              <label class="block text-sm font-medium text-gray-700">{{ field.label }}</label>
              <div class="relative flex items-center mt-2">
                <template v-if="field.model === 'phone'">
                  <span class="absolute left-3 text-gray-400">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <rect x="7" y="2" width="10" height="20" rx="2" stroke="currentColor" stroke-width="2" fill="none" />
                      <circle cx="12" cy="18" r="1" fill="currentColor" />
                    </svg>
                  </span>
                  <input
                    v-model="profile[field.model]"
                    class="input pl-10 pr-16 py-1 ring-1 ring-inset ring-gray-300 rounded-md focus:ring-2 focus:ring-inset focus:ring-[#036E94] transition-colors border-0 w-full"
                  />
                </template>
                <template v-else-if="field.model === 'department'">
                  <div class="relative w-full">
                    <select
                      v-model="profile.department"
                      class="input pl-10 pr-10 py-1 ring-1 ring-inset ring-gray-300 rounded-md focus:ring-2 focus:ring-inset focus:ring-[#036E94] transition-colors border-0 w-full appearance-none bg-white text-gray-700"
                    >
                      <option disabled value="">Select department</option>
                      <option value="Accounting Program">Accounting Program</option>
                      <option value="Business Administration">Business Administration</option>
                      <option value="Finance">Finance</option>
                      <option value="Marketing">Marketing</option>
                      <option value="International Business">International Business</option>
                      <option value="Tourism Management">Tourism Management</option>
                      <option value="Other">Other</option>
                    </select>
                    <span class="absolute right-3 top-2 text-gray-400 pointer-events-none">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                      </svg>
                    </span>
                  </div>
                </template>
                <template v-else-if="field.model === 'office'">
                  <span class="absolute left-3 text-gray-400">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5A2.5 2.5 0 1 1 12 6a2.5 2.5 0 0 1 0 5.5z" />
                    </svg>
                  </span>
                  <input
                    v-model="profile[field.model]"
                    class="input pl-10 pr-16 py-1 ring-1 ring-inset ring-gray-300 rounded-md focus:ring-2 focus:ring-inset focus:ring-[#036E94] transition-colors border-0 w-full"
                  />
                </template>
                <template v-else>
                  <input
                    v-model="profile[field.model]"
                    class="input pl-10 pr-16 py-1 ring-1 ring-inset ring-gray-300 rounded-md focus:ring-2 focus:ring-inset focus:ring-[#036E94] transition-colors border-0 w-full"
                  />
                </template>
              </div>
            </div>
          </template>
        </div>
      </div>
    </div>

    <!-- Education & Research Area Side by Side -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
      <!-- Education -->
      <div class="bg-white shadow rounded-xl p-6 h-full flex flex-col">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-lg font-semibold">Education</h2>
          <button
            @click="addEducation"
            class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors"
            style="background-color: #036E94;"
          >
            + Add Degree
          </button>
        </div>
        <div v-if="profile.education.length" class="space-y-4 flex-1">
          <div style="max-height: 288px; overflow-y: auto;" class="space-y-4 flex-1">
            <div v-for="(edu, index) in profile.education" :key="index" class="border p-4 rounded-md">
              <div class="flex justify-between items-center">
                <div>
                  <p class="font-medium">{{ edu.degree || 'No degree entered' }}</p>
                  <p class="text-sm text-gray-500">{{ edu.university || 'No university' }}<span v-if="edu.year"> — Graduated {{ edu.year }}</span></p>
                </div>
                <div class="flex space-x-2">
                  <button @click="editEducation(index)" class="text-blue-600" title="Edit">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                    </svg>
                  </button>
                  <button @click="removeEducation(index)" class="text-red-600" title="Delete">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                    </svg>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="text-gray-400 text-center py-4 flex-1 flex items-center justify-center">No education records. Click "+ Add Degree" to add one.</div>
      </div>
      <!-- Research Area -->
      <div class="bg-white shadow rounded-xl p-6 h-full flex flex-col">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-lg font-semibold">Research Area</h2>
          <button
            @click="addResearchArea"
            class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors"
            style="background-color: #036E94;"
          >
            + Add Research
          </button>
        </div>
        <div v-if="profile.researchAreas.length" class="space-y-4 flex-1">
          <div style="max-height: 192px; overflow-y: auto;" class="space-y-4 flex-1">
            <div v-for="(area, index) in profile.researchAreas" :key="index" class="border p-4 rounded-md flex justify-between items-center">
              <div class="flex-1">
                <p class="font-medium">{{ area || 'No research area entered' }}</p>
              </div>
              <div class="flex space-x-2">
                <button @click="editResearchArea(index)" class="text-blue-600" title="Edit">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                  </svg>
                </button>
                <button @click="removeResearchArea(index)" class="text-red-600" title="Delete">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="text-gray-400 text-center py-4 flex-1 flex items-center justify-center">No research areas. Click "+ Add Research" to add one.</div>
      </div>
    </div>

    <!-- Publications -->
    <div class="bg-white shadow rounded-xl p-6 mb-8">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold">Recent Publications</h2>
        <button
          @click="addPublication"
          class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors"
          style="background-color: #036E94;"
        >
          + Add Publication
        </button>
      </div>
      <div v-if="profile.publications.length">
        <div v-for="(pub, index) in profile.publications" :key="index" class="border p-4 rounded-md mb-2">
          <div class="flex justify-between">
            <div>
              <p class="font-medium text-blue-700 hover:underline cursor-pointer">{{ pub.title || 'No title' }}</p>
              <p class="text-sm text-gray-500">{{ pub.year || 'No year' }}</p>
              <div class="flex items-center gap-1 mt-1">
                <span class="text-blue-600 text-sm">Link</span>
                <button
                  @click="openPublicationLink(pub)"
                  class="focus:outline-none"
                  title="Open publication link"
                  type="button"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 3h7v7m0 0L10 21l-7-7 11-11z" />
                  </svg>
                </button>
              </div>
            </div>
            <div class="flex space-x-2">
              <button @click="editPublication(index)" class="text-blue-600" title="Edit">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                </svg>
              </button>
              <button @click="removePublication(index)" class="text-red-600" title="Delete">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div v-else class="text-gray-400 text-center py-4">No publications. Click "+ Add Publication" to add one.</div>
    </div>

    <!-- Action Buttons -->
    <div class="flex justify-end space-x-4 mt-4">
      <button
        type="button"
        class="px-6 py-2.5 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:border-[#036E94] hover:text-[#036E94] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-400 transition-colors"
      >
        Cancel
      </button>
      <button
        type="button"
        class="px-6 py-2.5 border border-transparent rounded-md shadow-sm text-sm font-medium text-white hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#036E94] transition-colors"
        style="background-color: #036E94;"
      >
        Save Changes
      </button>
    </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';

definePageMeta({
    layout: 'admin'
  });

const router = useRouter();

const profile = ref({
  photoUrl: 'https://via.placeholder.com/100',
  fullName: 'Dr. Supansa Chaising',
  email: 'supansa.cha@mfu.ac.th',
  phone: '053-916703',
  department: 'Accounting Program',
  position: 'Lecturer',
  office: 'E1-Floor 3, School of Management',
  education: [
    { degree: 'Bachelor’s degree : Accounting, Management', university: 'Mae Fah Luang University', year: '2014' },
    { degree: 'Master’s degree : Computer Engineering', university: 'Mae Fah Luang University', year: '2018' },
    { degree: 'Doctor of Philosophy : Computer Engineering', university: 'Mae Fah Luang University', year: '2021' }
  ],
  researchAreas: ['Machine Learning', 'Data Analytics', 'Accounting Information Systems'],
  publications: [
    { title: 'Classification Approach for Industry Standards Categorization', year: '2022' },
    { title: 'Blockchain-based Trusty Buyer Coalition Scheme Using a Group Signature', year: '2021' },
    { title: 'Blockchain-based Trusty Buyer Coalition Scheme Using a Group Signature', year: '2021' }
  ]
});

// ...existing code...

const goBack = () => {
  router.push('/admin/profile');
};

const addEducation = () => {
  profile.value.education.push({ degree: '', university: '', year: '' });
};

const editEducation = (index: number) => {
  console.log('Edit education:', profile.value.education[index]);
};

const removeEducation = (index: number) => {
  profile.value.education.splice(index, 1);
};

const addResearchArea = () => {
  const newArea = prompt('Enter new research area:');
  if (newArea) profile.value.researchAreas.push(newArea);
};

const removeResearchArea = (index: number) => {
  profile.value.researchAreas.splice(index, 1);
};


const editResearchArea = (index: number) => {
  const current = profile.value.researchAreas[index];
  const updated = prompt('Edit research area:', current);
  if (updated !== null && updated.trim() !== '') {
    profile.value.researchAreas[index] = updated.trim();
  }
};

const addPublication = () => {
  profile.value.publications.push({ title: '', year: '' });
};

const editPublication = (index: number) => {
  console.log('Edit publication:', profile.value.publications[index]);
};

const removePublication = (index: number) => {
  profile.value.publications.splice(index, 1);
};

const onFileChange = (e: Event) => {
  const file = (e.target as HTMLInputElement).files?.[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = () => {
      profile.value.photoUrl = reader.result as string;
    };
    reader.readAsDataURL(file);
  }
};

const openPublicationLink = (pub: { title: string; year: string }) => {
  // Replace with pub.link if available
  window.open('https://example.com', '_blank');
};
</script>
