import request from './request'

export function getConversations() {
  return request.get('/chat/conversations')
}

export function getMessages(convId, page = 1, size = 50) {
  return request.get(`/chat/messages/${convId}`, { params: { page, size } })
}

export function getOrCreateConversation(buyerId, sellerId) {
  return request.post('/chat/conversation', { buyerId, sellerId })
}
