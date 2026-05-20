import request from './request'

export function login(username, password) { return request.post('/user/login', { username, password }) }
export function register(username, password, role) { return request.post('/user/register', { username, password, role }) }
export function getProfile() { return request.get('/user/me') }
