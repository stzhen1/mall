import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import router from '../router'

export const useAuthStore = defineStore('auth', () => {
  const user = ref(JSON.parse(localStorage.getItem('user') || 'null'))
  const accessToken = ref(localStorage.getItem('accessToken') || '')
  const refreshToken = ref(localStorage.getItem('refreshToken') || '')
  const isLoggedIn = computed(() => !!accessToken.value && !!user.value)

  function setTokens(data) {
    accessToken.value = data.accessToken
    refreshToken.value = data.refreshToken
    localStorage.setItem('accessToken', data.accessToken)
    localStorage.setItem('refreshToken', data.refreshToken)
    if (data.userId && data.role) {
      user.value = { id: data.userId, role: data.role }
      localStorage.setItem('user', JSON.stringify(user.value))
    }
  }

  function logout() {
    accessToken.value = ''; refreshToken.value = ''; user.value = null
    localStorage.clear(); router.push('/login')
  }

  return { user, accessToken, refreshToken, isLoggedIn, setTokens, logout }
})
