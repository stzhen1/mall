<template>
  <div class="chat-window-page">
    <header class="chat-header glass-panel">
      <el-button @click="$router.push('/chat')">Back</el-button>
      <h2 class="peer-name-title">{{ peerName }}</h2>
    </header>
    <div class="messages-area" ref="msgContainer">
      <div
        v-for="m in messages"
        :key="m.id"
        class="message-wrapper"
        :class="m.senderId === Number(auth.user?.id) ? 'sent' : 'received'"
      >
        <div
          class="message-bubble anim-fade-up"
          :class="m.senderId === Number(auth.user?.id) ? 'sent-bubble' : 'received-bubble glass-subtle'"
        >
          {{ m.content }}
        </div>
        <div class="message-time">{{ m.createdAt }}</div>
      </div>
    </div>
    <footer class="chat-footer glass-panel">
      <el-input v-model="input" @keyup.enter="send" placeholder="Type a message..." class="chat-input" />
      <el-button type="primary" @click="send">Send</el-button>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { getMessages, getOrCreateConversation } from '../api/chat'

const route = useRoute()
const auth = useAuthStore()
const messages = ref([])
const input = ref('')
const msgContainer = ref(null)
const peerId = Number(route.params.userId)
const peerName = ref(route.query.peerName || 'User #' + peerId)
let ws = null
let convId = null

onMounted(async () => {
  const isBuyer = auth.user?.role === 'BUYER'
  const buyerId = isBuyer ? Number(auth.user.id) : peerId
  const sellerId = isBuyer ? peerId : Number(auth.user.id)
  const conv = await getOrCreateConversation(buyerId, sellerId)
  convId = conv.data.id

  const res = await getMessages(convId)
  messages.value = (res.data || []).reverse()

  const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:'
  ws = new WebSocket(`${protocol}//${window.location.host}/ws/chat?token=${auth.accessToken}`)
  ws.onmessage = (event) => {
    const msg = JSON.parse(event.data)
    if (msg.conversationId === convId) {
      messages.value.push(msg)
      nextTick(() => {
        const el = msgContainer.value?.$el || msgContainer.value
        if (el) el.scrollTop = el.scrollHeight
      })
    }
  }
})

onUnmounted(() => {
  if (ws) ws.close()
})

function send() {
  if (!input.value.trim() || !ws || ws.readyState !== WebSocket.OPEN) return
  ws.send(JSON.stringify({ receiverId: peerId, content: input.value }))
  input.value = ''
}
</script>

<style scoped>
.chat-window-page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  max-width: 750px;
  margin: 0 auto;
  background: transparent;
}

.chat-header {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 24px;
  flex-shrink: 0;
  z-index: 10;
  border-bottom: 1px solid var(--glass-border);
}

.peer-name-title {
  font-family: var(--font-display);
  font-size: 22px;
  font-weight: 700;
  margin: 0;
  color: var(--text-primary);
  letter-spacing: -0.01em;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.messages-area {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.messages-area::-webkit-scrollbar {
  width: 5px;
}
.messages-area::-webkit-scrollbar-track {
  background: transparent;
}
.messages-area::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.08);
  border-radius: 20px;
}
.messages-area::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 0, 0, 0.14);
}

.message-wrapper {
  display: flex;
  flex-direction: column;
  max-width: 75%;
}

.message-wrapper.sent {
  align-self: flex-end;
  align-items: flex-end;
}

.message-wrapper.received {
  align-self: flex-start;
  align-items: flex-start;
}

.message-bubble {
  padding: 10px 16px;
  border-radius: var(--radius);
  font-size: 14px;
  line-height: 1.5;
  word-break: break-word;
}

.sent-bubble {
  background: var(--color-primary);
  color: #fff;
  border-bottom-right-radius: 4px;
}

.received-bubble {
  color: var(--text-primary);
  border-bottom-left-radius: 4px;
}

.message-time {
  font-size: 11px;
  color: var(--text-muted);
  margin-top: 3px;
  padding: 0 4px;
}

.chat-footer {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 24px;
  flex-shrink: 0;
  z-index: 10;
}

.chat-input {
  flex: 1;
}
</style>
