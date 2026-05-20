import request from './request'

export function getProfile() {
  return request.get('/user/me')
}

export function updateProfile(data) {
  return request.put('/user/me', data)
}

export function changePassword(oldPassword, newPassword) {
  return request.put('/user/password', { oldPassword, newPassword })
}

export function getAddresses() {
  return request.get('/user/addresses')
}

export function addAddress(address) {
  return request.post('/user/addresses', address)
}

export function updateAddress(id, address) {
  return request.put(`/user/addresses/${id}`, address)
}

export function deleteAddress(id) {
  return request.delete(`/user/addresses/${id}`)
}
