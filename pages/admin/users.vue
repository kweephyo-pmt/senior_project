<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header with gradient background -->
      <div class="flex justify-between items-center mb-8 bg-white bg-opacity-95 p-8 rounded-xl shadow-lg border border-gray-100">
        <div>
          <h1 class="text-2xl font-bold bg-gradient-to-r from-indigo-600 to-blue-600 bg-clip-text text-transparent">
            Users Management
          </h1>
          <p class="text-gray-600 mt-1 text-sm">Manage user roles and system access</p>
        </div>
        <div v-if="initialLoading" class="bg-gray-100 px-6 py-2.5 rounded-lg animate-pulse">
          <div class="h-6 bg-gray-200 rounded w-24"></div>
        </div>
        <div v-else class="bg-indigo-50 text-indigo-700 px-6 py-2.5 rounded-lg font-medium border border-indigo-100 shadow-sm flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
          </svg>
          {{ users.length }} {{ users.length === 1 ? 'user' : 'users' }} total
        </div>
      </div>

      <!-- Search and Filter with glass effect -->
      <div class="bg-white bg-opacity-95 p-8 rounded-xl shadow-lg mb-8 border border-gray-100 backdrop-blur-sm">
        <div class="flex flex-col sm:flex-row gap-6">
          <div class="flex-1">
            <label for="search" class="block text-sm font-medium text-gray-700 mb-2">Search Users</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
              </div>
              <input 
                id="search"
                v-model="searchQuery"
                type="text"
                placeholder="Search by name or email..."
                class="w-full pl-12 pr-4 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 shadow-sm hover:border-gray-300"
              />
            </div>
          </div>
          <div class="sm:w-72">
            <label for="role-filter" class="block text-sm font-medium text-gray-700 mb-2">Filter by Role</label>
            <div class="relative">
              <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                </svg>
              </div>
              <select 
                id="role-filter"
                v-model="roleFilter"
                class="w-full pl-12 pr-10 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 appearance-none transition-all duration-200 shadow-sm hover:border-gray-300 bg-white cursor-pointer"
              >
                <option value="">All Roles</option>
                <option value="admin">Admin</option>
                <option value="dean">Dean</option>
                <option value="lecturer">Lecturer</option>
              </select>
              <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                <svg class="h-4 w-4 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Users Table with improved design -->
      <div class="bg-white bg-opacity-95 rounded-xl shadow-lg overflow-hidden border border-gray-100">
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead>
              <tr class="bg-gray-50 border-b border-gray-200">
                <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">User</th>
                <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Email</th>
                <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Role</th>
                <th scope="col" class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                <th scope="col" class="px-6 py-4 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <!-- Loading skeleton rows -->
              <tr v-if="initialLoading || isLoading" v-for="i in 5" :key="i" class="animate-pulse">
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="w-12 h-12 rounded-full bg-gray-200 mr-4"></div>
                    <div>
                      <div class="h-4 bg-gray-200 rounded w-32 mb-2"></div>
                      <div class="h-3 bg-gray-200 rounded w-24"></div>
                    </div>
                  </div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="h-4 bg-gray-200 rounded w-48 mb-1"></div>
                  <div class="h-3 bg-gray-200 rounded w-20"></div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="h-6 bg-gray-200 rounded w-16"></div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="h-6 bg-gray-200 rounded w-16"></div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap text-right">
                  <div class="flex items-center justify-end space-x-3">
                    <div class="w-8 h-8 bg-gray-200 rounded"></div>
                    <div class="w-8 h-8 bg-gray-200 rounded"></div>
                    <div class="w-8 h-8 bg-gray-200 rounded"></div>
                  </div>
                </td>
              </tr>
              <!-- Actual user rows -->
              <tr v-else-if="!initialLoading && !isLoading" v-for="user in filteredUsers" :key="user.email" class="hover:bg-gray-50 transition-colors duration-150">
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="relative">
                      <img 
                        :src="getUserPhotoURL(user)"
                        :alt="user.displayName || 'User'"
                        class="h-12 w-12 rounded-full object-cover ring-4 ring-gray-100"
                        loading="lazy"
                        @error="handleImageError"
                      />
                      <span 
                        class="absolute bottom-0 right-0 h-3.5 w-3.5 rounded-full border-2 border-white"
                        :class="user.isActive ? 'bg-emerald-500' : 'bg-gray-400'"
                      ></span>
                    </div>
                    <div class="ml-4">
                      <div class="text-sm font-semibold text-gray-900">
                        {{ user.displayName || 'No Name' }}
                      </div>
                      <div class="text-xs text-gray-500 mt-0.5">
                        Added {{ user.createdAt?.toDate().toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }) || 'N/A' }}
                      </div>
                    </div>
                  </div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <div class="text-sm text-gray-900">{{ user.email }}</div>
                  <div class="text-xs text-gray-500 mt-0.5">@mfu.ac.th</div>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <span 
                    class="px-3 py-1.5 inline-flex text-xs leading-5 font-semibold rounded-lg items-center justify-center shadow-sm"
                    :class="{
                      'bg-indigo-50 text-indigo-700 ring-1 ring-indigo-200': user.role === 'admin',
                      'bg-blue-50 text-blue-700 ring-1 ring-blue-200': user.role === 'dean',
                      'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200': user.role === 'lecturer'
                    }"
                  >
                    <span class="w-1.5 h-1.5 rounded-full mr-1.5"
                      :class="{
                        'bg-indigo-500': user.role === 'admin',
                        'bg-blue-500': user.role === 'dean',
                        'bg-emerald-500': user.role === 'lecturer'
                      }"
                    ></span>
                    {{ user.role }}
                  </span>
                </td>
                <td class="px-6 py-5 whitespace-nowrap">
                  <span 
                    class="px-3 py-1.5 inline-flex text-xs leading-5 font-semibold rounded-lg items-center justify-center shadow-sm"
                    :class="user.isActive ? 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-200' : 'bg-red-50 text-red-700 ring-1 ring-red-200'"
                  >
                    <span class="w-1.5 h-1.5 rounded-full mr-1.5"
                      :class="user.isActive ? 'bg-emerald-500' : 'bg-red-500'"
                    ></span>
                    {{ user.isActive ? 'Active' : 'Inactive' }}
                  </span>
                </td>
                <td class="px-6 py-5 whitespace-nowrap text-right text-sm font-medium">
                  <div class="flex items-center justify-end space-x-3">
                    <button
                      @click="openEditModal(user)"
                      class="p-2 text-indigo-600 bg-indigo-50 hover:bg-indigo-100 border border-indigo-200 rounded-lg transition-all duration-200 group relative shadow-sm hover:shadow-md"
                      title="Edit User"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                      <span class="absolute -top-10 left-1/2 -translate-x-1/2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-200 whitespace-nowrap z-50">
                        Edit User
                      </span>
                    </button>
                    <button
                      @click="toggleUserStatus(user)"
                      :class="user.isActive 
                        ? 'p-2 text-red-600 bg-red-50 hover:bg-red-100 border border-red-200 rounded-lg transition-all duration-200 group relative shadow-sm hover:shadow-md' 
                        : 'p-2 text-emerald-600 bg-emerald-50 hover:bg-emerald-100 border border-emerald-200 rounded-lg transition-all duration-200 group relative shadow-sm hover:shadow-md'"
                      :title="user.isActive ? 'Deactivate User' : 'Activate User'"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path v-if="user.isActive" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636" />
                        <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                      <span class="absolute -top-10 left-1/2 -translate-x-1/2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-200 whitespace-nowrap z-50">
                        {{ user.isActive ? 'Deactivate User' : 'Activate User' }}
                      </span>
                    </button>
                    <button
                      v-if="auth.currentUser?.email !== user.email"
                      @click="confirmDelete(user)"
                      class="p-2 text-red-600 bg-red-50 hover:bg-red-100 border border-red-200 rounded-lg transition-all duration-200 group relative shadow-sm hover:shadow-md"
                      title="Delete User"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                      <span class="absolute -top-10 left-1/2 -translate-x-1/2 px-2 py-1 bg-gray-900 text-white text-xs rounded-lg shadow-lg opacity-0 group-hover:opacity-100 transition-opacity duration-200 whitespace-nowrap z-50">
                        Delete User
                      </span>
                    </button>
                  </div>
                </td>
              </tr>
              <!-- Empty state -->
              <tr v-else-if="!initialLoading && !isLoading && filteredUsers.length === 0">
                <td colspan="5" class="px-6 py-12 text-center">
                  <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                  </svg>
                  <h3 class="mt-2 text-sm font-medium text-gray-900">No users found</h3>
                  <p class="mt-1 text-sm text-gray-500">Try adjusting your search or filter criteria.</p>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Edit User Modal with improved design -->
      <div v-if="showEditModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 overflow-y-auto h-full w-full flex items-center justify-center backdrop-blur-sm z-50">
        <div class="relative bg-white rounded-xl shadow-2xl p-8 max-w-md w-full mx-4 transform transition-all">
          <h2 class="text-xl font-bold mb-6 text-gray-900">Edit User</h2>
          <div class="space-y-6">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Name</label>
              <input 
                :value="editingUser?.displayName"
                @input="e => editingUser && (editingUser.displayName = (e.target as HTMLInputElement).value)"
                type="text"
                class="w-full px-4 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 shadow-sm"
              />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
              <select 
                :value="editingUser?.role"
                @change="e => editingUser && (editingUser.role = (e.target as HTMLSelectElement).value as 'admin' | 'dean' | 'lecturer')"
                class="w-full px-4 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 shadow-sm appearance-none bg-white"
              >
                <option value="admin">Admin</option>
                <option value="dean">Dean</option>
                <option value="lecturer">Lecturer</option>
              </select>
            </div>
            <div class="flex justify-end space-x-4 mt-8">
              <button 
                @click="closeEditModal"
                class="px-6 py-2.5 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-all duration-200 shadow-sm hover:shadow-md"
              >
                Cancel
              </button>
              <button 
                @click="saveUser"
                class="px-6 py-2.5 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-all duration-200 shadow-sm hover:shadow-md"
              >
                Save Changes
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Delete Confirmation Modal with improved design -->
      <div v-if="showDeleteConfirm" class="fixed inset-0 bg-gray-900 bg-opacity-50 overflow-y-auto h-full w-full flex items-center justify-center backdrop-blur-sm z-50">
        <div class="relative bg-white rounded-xl shadow-2xl p-8 max-w-md w-full mx-4 transform transition-all">
          <h2 class="text-xl font-bold mb-4 text-red-600">Confirm Delete</h2>
          <p class="text-gray-600 mb-6">
            Are you sure you want to delete the user <span class="font-semibold text-gray-900">{{ userToDelete?.email }}</span>? This action cannot be undone.
          </p>
          <div class="flex justify-end space-x-4">
            <button
              @click="showDeleteConfirm = false"
              class="px-6 py-2.5 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-all duration-200 shadow-sm hover:shadow-md"
            >
              Cancel
            </button>
            <button
              @click="deleteUser"
              class="px-6 py-2.5 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-all duration-200 shadow-sm hover:shadow-md"
            >
              Delete
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { getFirestore, collection, getDocs, doc, updateDoc, deleteDoc, getDoc } from 'firebase/firestore'
import { getAuth } from 'firebase/auth'
import { useAlert } from '~/composables/useAlert'

definePageMeta({
  layout: 'admin'
})
import { Timestamp } from 'firebase/firestore'

interface User {
  email: string
  displayName: string | undefined
  photoURL: string | undefined
  role: 'admin' | 'dean' | 'lecturer'
  isActive: boolean
  createdAt: Timestamp
}

const { showAlert } = useAlert()
const auth = getAuth()
const users = ref<User[]>([])
const searchQuery = ref('')
const roleFilter = ref('')
const showEditModal = ref(false)
const editingUser = ref<User | null>(null)
const showDeleteConfirm = ref(false)
const userToDelete = ref<User | null>(null)

// Initial loading state to prevent flash of empty content
const initialLoading = ref(true)
const isLoading = ref(false)

// Get standardized photo URL with fallback
const getUserPhotoURL = (user: User): string => {
  // Priority 1: User's photoURL from Firestore
  if (user.photoURL) {
    return user.photoURL
  }
  // Priority 2: Generate fallback avatar with consistent styling
  const displayName = user.displayName || 'User'
  return `https://ui-avatars.com/api/?name=${encodeURIComponent(displayName)}&background=4F46E5&color=ffffff&size=96`
}

// Handle image loading errors by falling back to generated avatar
const handleImageError = (event: Event) => {
  const img = event.target as HTMLImageElement
  const altText = img.alt || 'User'
  const fallbackURL = `https://ui-avatars.com/api/?name=${encodeURIComponent(altText)}&background=4F46E5&color=ffffff&size=96`
  
  // Only change if it's not already the fallback URL to prevent infinite loops
  if (img.src !== fallbackURL) {
    img.src = fallbackURL
  }
}

// Fetch users on mount
onMounted(async () => {
  await fetchUsers()
})

// Fetch all users from Firestore
const fetchUsers = async () => {
  try {
    isLoading.value = true
    const db = getFirestore()
    const usersCollection = collection(db, 'users')
    const querySnapshot = await getDocs(usersCollection)
    
    users.value = querySnapshot.docs.map(doc => ({
      email: doc.id,
      ...doc.data()
    })) as User[]
  } catch (error) {
    console.error('Error fetching users:', error)
    showAlert('error', 'Error', 'Failed to load users')
  } finally {
    isLoading.value = false
    initialLoading.value = false
  }
}

// Filter users based on search query and role filter
const filteredUsers = computed(() => {
  return users.value.filter(user => {
    const matchesSearch = 
      (user.displayName?.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
       user.email.toLowerCase().includes(searchQuery.value.toLowerCase()))
    const matchesRole = !roleFilter.value || user.role === roleFilter.value
    return matchesSearch && matchesRole
  })
})

// Open edit modal for a user
const openEditModal = (user: User) => {
  editingUser.value = { ...user }
  showEditModal.value = true
}

// Close edit modal
const closeEditModal = () => {
  editingUser.value = null
  showEditModal.value = false
}

// Save user changes
const saveUser = async () => {
  if (!editingUser.value) return

  try {
    const currentUser = auth.currentUser
    const userDoc = await getDoc(doc(getFirestore(), 'users', editingUser.value.email))
    const existingData = userDoc.data()

    // Prevent changing other admin roles
    if (existingData?.role === 'admin' && editingUser.value.role !== 'admin') {
      showAlert('error', 'Not Allowed', 'You cannot change another admin\'s role')
      // Reset the role back to admin
      editingUser.value.role = 'admin'
      return
    }

    // Prevent admin from changing their own role
    if (currentUser?.email === editingUser.value.email && editingUser.value.role !== 'admin') {
      showAlert('error', 'Not Allowed', 'You cannot change your own admin role')
      // Reset the role back to admin
      editingUser.value.role = 'admin'
      return
    }
    const db = getFirestore()
    const userRef = doc(db, 'users', editingUser.value.email)
    await updateDoc(userRef, {
      displayName: editingUser.value.displayName,
      role: editingUser.value.role
    })
    
    // Update local state
    const index = users.value.findIndex(u => u.email === editingUser.value?.email)
    if (index !== -1) {
      users.value[index] = { ...editingUser.value }
    }
    
    showAlert('success', 'Success', 'User updated successfully')
    closeEditModal()
  } catch (error) {
    console.error('Error updating user:', error)
    showAlert('error', 'Error', 'Failed to update user')
  }
}

// Toggle user active status
const confirmDelete = (user: User) => {
  userToDelete.value = user
  showDeleteConfirm.value = true
}

const deleteUser = async () => {
  if (!userToDelete.value) return

  try {
    // Check if trying to delete an admin
    const userDoc = await getDoc(doc(getFirestore(), 'users', userToDelete.value.email))
    const userData = userDoc.data()

    if (userData?.role === 'admin') {
      showAlert('error', 'Not Allowed', 'You cannot delete another admin\'s account')
      showDeleteConfirm.value = false
      return
    }
    const db = getFirestore()
    await deleteDoc(doc(db, 'users', userToDelete.value.email))
    
    // Remove from local state
    users.value = users.value.filter(u => u.email !== userToDelete.value?.email)
    
    showDeleteConfirm.value = false
    showAlert('success', 'Success', 'User deleted successfully')
  } catch (error) {
    console.error('Error deleting user:', error)
    showAlert('error', 'Error', 'Failed to delete user')
  }
}

const toggleUserStatus = async (user: User) => {
  try {
    // Prevent admin from deactivating themselves or other admins
    const currentUser = auth.currentUser
    const userDoc = await getDoc(doc(getFirestore(), 'users', user.email))
    const userData = userDoc.data()

    if (currentUser?.email === user.email) {
      showAlert('error', 'Not Allowed', 'You cannot deactivate your own account')
      return
    }

    if (userData?.role === 'admin') {
      showAlert('error', 'Not Allowed', 'You cannot deactivate another admin\'s account')
      return
    }
    const db = getFirestore()
    const userRef = doc(db, 'users', user.email)
    await updateDoc(userRef, {
      isActive: !user.isActive
    })
    
    // Update local state
    const index = users.value.findIndex(u => u.email === user.email)
    if (index !== -1) {
      users.value[index] = { ...user, isActive: !user.isActive }
    }
    
    showAlert('success', 'Success', `User ${user.isActive ? 'deactivated' : 'activated'} successfully`)
  } catch (error) {
    console.error('Error toggling user status:', error)
    showAlert('error', 'Error', 'Failed to update user status')
  }
}
</script>
