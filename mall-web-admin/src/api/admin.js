import request from './request'

export function getUsers(params) { return request.get('/admin/users', { params }) }
export function getProducts(params) { return request.get('/product/list', { params }) }
export function getOrders(params) { return request.get('/admin/orders', { params }) }
export function updateProductStatus(id, status) { return request.put(`/product/${id}/status`, { status }) }
export function toggleUserStatus(id, status) { return request.put(`/admin/users/${id}/status`, { status }) }
