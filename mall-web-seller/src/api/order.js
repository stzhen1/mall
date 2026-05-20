import request from './request'

export function getSellerOrders(page = 1, size = 10) { return request.get('/order/seller', { params: { page, size } }) }
export function shipOrder(id) { return request.put(`/order/${id}/ship`) }
