import request from './request'
export function login(username, password) { return request.post('/user/login', { username, password }) }
export function getProfile() { return request.get('/user/me') }
