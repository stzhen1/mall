import axios from 'axios'
import { useAuthStore } from '../stores/auth'

const request = axios.create({ baseURL: '/api', timeout: 15000 })

request.interceptors.request.use(config => {
  const auth = useAuthStore()
  if (auth.accessToken) config.headers.Authorization = `Bearer ${auth.accessToken}`
  return config
})

request.interceptors.response.use(
  res => res.data,
  async error => {
    if (error.response?.status === 401) {
      const auth = useAuthStore()
      if (auth.refreshToken) {
        try {
          const res = await axios.post('/api/user/refresh', { refreshToken: auth.refreshToken })
          auth.setTokens(res.data.data)
          error.config.headers.Authorization = `Bearer ${res.data.data.accessToken}`
          return request(error.config)
        } catch (e) { auth.logout() }
      } else { auth.logout() }
    }
    return Promise.reject(error)
  }
)

export default request
