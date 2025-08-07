<template>
  <div class="min-h-screen bg-gradient-to-b from-gray-50 to-gray-100">
    <!-- Background Patterns -->
    <div class="fixed inset-0 -z-10">
      <div class="absolute inset-0 bg-[radial-gradient(45rem_50rem_at_top,theme(colors.indigo.100),white)] opacity-20"></div>
      <div class="absolute inset-0 opacity-10" style="background-image: radial-gradient(circle, rgba(255,255,255,0.8) 1px, transparent 1px), linear-gradient(45deg, rgba(4,110,147,0.05) 25%, transparent 25%, transparent 50%, rgba(4,110,147,0.05) 50%, rgba(4,110,147,0.05) 75%, transparent 75%); background-size: 20px 20px, 40px 40px;"></div>
    </div>

    <!-- Header/Navigation -->
    <nav class="bg-white/80 backdrop-blur-md shadow-md sticky top-0 z-50">
      <div class="max-w-7xl mx-auto px-3 sm:px-4 md:px-6 lg:px-8">
        <div class="flex justify-between h-16 sm:h-18 md:h-20">
          <div class="flex items-center" :class="{ 'animate__animated animate__fadeInLeft': isLoaded }">
            <mfulogo/>
            <div class="w-0.5 h-10 bg-[#18345c] mx-3"></div>
            <div>
              <h2 class="text-xl font-bold text-[#18345c] mb-1">SoM.BI</h2>
              <div class="w-full h-0.5 bg-[#18345c] mb-1"></div>
              <p class="text-xs text-[#17688f]">School of Management</p>
            </div>
          </div>
          <div class="flex items-center space-x-2 sm:space-x-4 md:space-x-6">
            <a href="#features" class="hidden sm:block text-gray-600 hover:text-[#046e93] transition-colors duration-300">Features</a>
            <a href="#stats" class="hidden sm:block text-gray-600 hover:text-[#046e93] transition-colors duration-300">Statistics</a>
            <a href="#testimonials" class="hidden sm:block text-gray-600 hover:text-[#046e93] transition-colors duration-300">Testimonials</a>
            <button
              @click="signInWithGoogle"
              class="hidden md:inline-flex ml-4 items-center px-5 py-2.5 border border-transparent text-sm font-medium rounded-md text-white bg-gradient-to-r from-[#046e93] to-[#035475] hover:from-[#035e80] hover:to-[#024a64] shadow-lg transition duration-300 ease-in-out transform hover:scale-105"
            >
              <svg class="h-5 w-5 mr-2" viewBox="0 0 48 48"><g><path fill="#4285F4" d="M24 9.5c3.54 0 6.36 1.53 7.82 2.81l5.77-5.77C34.5 3.9 29.78 1.5 24 1.5 14.82 1.5 6.87 7.97 3.55 16.09l6.91 5.36C12.36 15.33 17.73 9.5 24 9.5z"/><path fill="#34A853" d="M46.14 24.5c0-1.64-.15-3.22-.43-4.74H24v9.11h12.46c-.54 2.91-2.18 5.38-4.66 7.04l7.18 5.59C43.93 37.43 46.14 31.45 46.14 24.5z"/><path fill="#FBBC05" d="M10.46 28.45a14.44 14.44 0 0 1 0-8.9l-6.91-5.36A23.93 23.93 0 0 0 0 24.5c0 3.83.92 7.45 2.55 10.61l7.91-6.66z"/><path fill="#EA4335" d="M24 46.5c6.48 0 11.93-2.15 15.9-5.84l-7.18-5.59c-2.01 1.35-4.6 2.16-8.72 2.16-6.27 0-11.64-5.83-13.54-13.43l-7.91 6.66C6.87 41.03 14.82 46.5 24 46.5z"/><path fill="none" d="M0 0h48v48H0z"/></g></svg>
              Sign in with Google
            </button>
          </div>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <div class="relative overflow-hidden">
      <div class="absolute inset-0 bg-gradient-to-r from-[#046e93] via-[#03799f] to-[#024a64] opacity-10"></div>
      
      <div class="max-w-7xl mx-auto pt-24 pb-32 px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="text-center">
          <h1 class="text-5xl tracking-tight font-extrabold text-gray-900 sm:text-6xl md:text-7xl" :class="{ 'animate__animated animate__fadeInUp': isLoaded }">
            <span class="block">School of Management</span>
            <span class="block bg-clip-text text-transparent bg-gradient-to-r from-[#046e93] to-[#03799f]">Business Intelligence</span>
          </h1>
          <p class="mt-8 max-w-2xl mx-auto text-xl text-gray-600 sm:text-2xl md:mt-10" :class="{ 'animate__animated animate__fadeIn animate__delay-1s': isLoaded }">
            Empowering future business leaders with data-driven insights. Join MFU's premier Business Intelligence program at the School of Management.
          </p>
          <div class="mt-12 flex flex-col sm:flex-row justify-center gap-4" :class="{ 'animate__animated animate__fadeInUp animate__delay-1s': isLoaded }">
            <button @click="signInWithGoogle" class="px-8 py-4 border border-transparent text-base font-medium rounded-md text-white bg-gradient-to-r from-[#046e93] to-[#035475] hover:from-[#035e80] hover:to-[#024a64] shadow-lg transition duration-300 ease-in-out transform hover:scale-105">
              Get Started
            </button>
            <a href="#features" class="px-8 py-4 border border-[#046e93] text-base font-medium rounded-md text-[#046e93] hover:bg-[#046e93]/5 transition duration-300 ease-in-out">
              Learn More
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- Features Section -->
    <div id="features" class="py-24 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900">Program Highlights</h2>
          <p class="mt-4 text-xl text-gray-600 max-w-2xl mx-auto">Discover what makes our Business Intelligence program unique at Mae Fah Luang University.</p>
        </div>
        
        <div class="grid grid-cols-1 gap-12 sm:grid-cols-2 lg:grid-cols-3" :class="{ 'animate__animated animate__fadeInUp animate__delay-2s': isLoaded }">
          <!-- Feature 1 -->
          <div class="group relative p-8 bg-white rounded-2xl shadow-lg border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-[#046e93]/5 to-[#035475]/5 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left"></div>
            <div class="rounded-full p-4 bg-[#eaf4f8] inline-block mb-6">
              <DocumentTextIcon class="h-8 w-8 text-[#046e93]" />
            </div>
            <h3 class="text-2xl font-semibold text-gray-900">Data Analytics</h3>
            <p class="mt-4 text-gray-600 leading-relaxed">
              Master the latest tools and techniques in data analytics, from statistical analysis to machine learning applications.
            </p>
          </div>

          <!-- Feature 2 -->
          <div class="group relative p-8 bg-white rounded-2xl shadow-lg border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-[#046e93]/5 to-[#035475]/5 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left"></div>
            <div class="rounded-full p-4 bg-[#eaf4f8] inline-block mb-6">
              <UserGroupIcon class="h-8 w-8 text-[#046e93]" />
            </div>
            <h3 class="text-2xl font-semibold text-gray-900">Industry Projects</h3>
            <p class="mt-4 text-gray-600 leading-relaxed">
              Work on real-world projects with leading companies, gaining practical experience in business intelligence implementation.
            </p>
          </div>

          <!-- Feature 3 -->
          <div class="group relative p-8 bg-white rounded-2xl shadow-lg border border-gray-100 hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-[#046e93]/5 to-[#035475]/5 transform scale-x-0 group-hover:scale-x-100 transition-transform duration-500 origin-left"></div>
            <div class="rounded-full p-4 bg-[#eaf4f8] inline-block mb-6">
              <ChartBarIcon class="h-8 w-8 text-[#046e93]" />
            </div>
            <h3 class="text-2xl font-semibold text-gray-900">Career Opportunities</h3>
            <p class="mt-4 text-gray-600 leading-relaxed">
              Graduate ready for roles in business analytics, data science, and strategic management across various industries.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Statistics Section -->
    <div id="stats" class="py-24 bg-gradient-to-r from-[#046e93] to-[#035475] text-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 gap-12 sm:grid-cols-2 lg:grid-cols-4">
          <div class="text-center">
            <div class="text-5xl font-bold mb-2" :class="{ 'animate__animated animate__fadeInUp': isLoaded }">95%</div>
            <div class="text-xl">Graduation Rate</div>
          </div>
          <div class="text-center">
            <div class="text-5xl font-bold mb-2" :class="{ 'animate__animated animate__fadeInUp animate__delay-1s': isLoaded }">100+</div>
            <div class="text-xl">Industry Partners</div>
          </div>
          <div class="text-center">
            <div class="text-5xl font-bold mb-2" :class="{ 'animate__animated animate__fadeInUp animate__delay-2s': isLoaded }">85%</div>
            <div class="text-xl">Employment Rate</div>
          </div>
          <div class="text-center">
            <div class="text-5xl font-bold mb-2" :class="{ 'animate__animated animate__fadeInUp animate__delay-3s': isLoaded }">50+</div>
            <div class="text-xl">Research Projects</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Testimonials Section -->
    <div id="testimonials" class="py-24 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900">What Our Students Say</h2>
          <p class="mt-4 text-xl text-gray-600 max-w-2xl mx-auto">Hear from our graduates about their experience in the Business Intelligence program.</p>
        </div>
        
        <div class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
          <div class="bg-white p-8 rounded-2xl shadow-lg border border-gray-100">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 rounded-full bg-[#eaf4f8] flex items-center justify-center">
                <span class="text-xl font-bold text-[#046e93]">JD</span>
              </div>
              <div class="ml-4">
                <h4 class="font-semibold text-gray-900">John Doe</h4>
                <p class="text-sm text-gray-600">Class of 2022</p>
              </div>
            </div>
            <p class="text-gray-600 leading-relaxed">"The Business Intelligence program at MFU provided me with the skills and knowledge needed to excel in the data analytics field. The hands-on projects were particularly valuable."</p>
          </div>
          
          <div class="bg-white p-8 rounded-2xl shadow-lg border border-gray-100">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 rounded-full bg-[#eaf4f8] flex items-center justify-center">
                <span class="text-xl font-bold text-[#046e93]">AS</span>
              </div>
              <div class="ml-4">
                <h4 class="font-semibold text-gray-900">Alice Smith</h4>
                <p class="text-sm text-gray-600">Class of 2021</p>
              </div>
            </div>
            <p class="text-gray-600 leading-relaxed">"The industry connections and practical experience I gained through this program were instrumental in landing my dream job at a leading tech company."</p>
          </div>
          
          <div class="bg-white p-8 rounded-2xl shadow-lg border border-gray-100">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 rounded-full bg-[#eaf4f8] flex items-center justify-center">
                <span class="text-xl font-bold text-[#046e93]">RB</span>
              </div>
              <div class="ml-4">
                <h4 class="font-semibold text-gray-900">Robert Brown</h4>
                <p class="text-sm text-gray-600">Class of 2023</p>
              </div>
            </div>
            <p class="text-gray-600 leading-relaxed">"The faculty's expertise and the program's focus on real-world applications made my learning experience both challenging and rewarding."</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gradient-to-r from-[#046e93] to-[#035475] text-white">
      <div class="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div class="col-span-1 md:col-span-2">
            <div class="flex items-center mb-6">
              <mfulogo class="h-10 w-auto mr-4"/>
              <div>
                <h3 class="text-xl font-bold">SOM Business Intelligence</h3>
                <p class="text-sm text-[#a5d8e9] mt-1">School of Management - Mae Fah Luang University</p>
              </div>
            </div>
            <p class="text-[#a5d8e9] max-w-md">Empowering future business leaders with data-driven insights through our premier Business Intelligence program.</p>
          </div>
          
          <div>
            <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
            <ul class="space-y-2">
              <li><a href="#features" class="text-[#a5d8e9] hover:text-white transition-colors">Features</a></li>
              <li><a href="#stats" class="text-[#a5d8e9] hover:text-white transition-colors">Statistics</a></li>
              <li><a href="#testimonials" class="text-[#a5d8e9] hover:text-white transition-colors">Testimonials</a></li>
            </ul>
          </div>
          
          <div>
            <h4 class="text-lg font-semibold mb-4">Contact</h4>
            <ul class="space-y-2 text-[#a5d8e9]">
              <li>School of Management</li>
              <li>Mae Fah Luang University</li>
              <li>Chiang Rai, Thailand</li>
              <li>Email: som@mfu.ac.th</li>
            </ul>
          </div>
        </div>
        
        <div class="mt-12 pt-8 border-t border-[#a5d8e9]/20">
          <p class="text-center text-sm text-[#a5d8e9]">
            © {{ new Date().getFullYear() }} School of Management, Mae Fah Luang University. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { DocumentTextIcon, UserGroupIcon, ChartBarIcon } from '@heroicons/vue/24/outline'
import { useFirebaseAuth } from '@/composables/useFirebaseAuth'
import 'animate.css'
import { onMounted, ref } from 'vue'

const { signInWithGoogle } = useFirebaseAuth()
const isLoaded = ref(false)

onMounted(() => {
  isLoaded.value = true
})
</script>
