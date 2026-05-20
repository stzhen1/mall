import request from './request'

export function placeOrder(order) {
  return request.post('/order', order)
}

export function payOrder(id) {
  return request.put(`/order/${id}/pay`)
}

export function getBuyerOrders(page = 1, size = 10) {
  return request.get('/order/buyer', { params: { page, size } })
}

export function receiveOrder(id) {
  return request.put(`/order/${id}/receive`)
}

export function requestAfterSale(id, afterSale) {
  return request.post(`/order/${id}/after-sale`, afterSale)
}
