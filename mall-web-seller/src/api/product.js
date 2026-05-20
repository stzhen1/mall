import request from './request'

export function getProducts(params) { return request.get('/product/list', { params }) }
export function getProductDetail(id) { return request.get(`/product/${id}`) }
export function getCategories() { return request.get('/product/categories') }
export function createProduct(product) { return request.post('/product', product) }
export function updateProduct(id, product) { return request.put(`/product/${id}`, product) }
export function updateProductStatus(id, status) { return request.put(`/product/${id}/status`, { status }) }
export function deleteProduct(id) { return request.delete(`/product/${id}`) }
