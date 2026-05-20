import request from './request'

export function getProducts(params) {
  return request.get('/product/list', { params })
}

export function getProductDetail(id) {
  return request.get(`/product/${id}`)
}

export function getCategories() {
  return request.get('/product/categories')
}
