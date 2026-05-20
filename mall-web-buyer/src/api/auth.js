import request from './request'

export function login(username, password) {
  return request.post('/user/login', { username, password })
}

export function register(username, password, role) {
  return request.post('/user/register', { username, password, role })
}

export function refreshToken(refreshToken) {
  return request.post('/user/refresh', { refreshToken })
}

export function getProfile() {
  return request.get('/user/me')
}

export function getAddresses() {
  return request.get('/user/addresses')
}

export function addAddress(address) {
  return request.post('/user/addresses', address)
}
