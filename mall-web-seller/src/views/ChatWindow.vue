<template>
  <div class="chat-window">
    <!-- Glass Header -->
    <div class="chat-header glass-panel">
      <el-button @click="$router.push('/chat')">Back</el-button>
      <h2 class="chat-peer-name">{{ peerName }}</h2>
    </div>

    <!-- Messages Area -->
    <div class="chat-messages" ref="msgContainer">
      <div class="messages-inner">
        <div
          v-for="m in messages"
          :key="m.id"
          class="message-row anim-fade-up"
          :class="m.senderId === Number(auth.user?.id) ? 'message-sent' : 'message-received'"
        >
          <div class="message-bubble" :class="m.senderId === Number(auth.user?.id) ? 'bubble-sent' : 'bubble-received glass-subtle'">
            {{ m.content }}
          </div>
          <div class="message-time">{{ m.createdAt }}</div>
        </div>
      </div>
    </div>

    <!-- Glass Footer -->
    <div class="chat-footer glass-panel">
      <div class="footer-input-wrap">
        <el-input v-model="input" @keyup.enter="send" placeholder="Type a message..." />
      </div>
      <el-button type="primary" @click="send">Send</el-button>
    </div>
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

onUnmounted(() => { if (ws) ws.close() })

function send() {
  if (!input.value.trim() || !ws || ws.readyState !== WebSocket.OPEN) return
  ws.send(JSON.stringify({ receiverId: peerId, content: input.value }))
  input.value = ''
}
</script>

<style scoped>
.chat-window {
  display: flex;
  flex-direction: column;
  height: 100vh;
  max-width: 800px;
  margin: 0 auto;
}

/* --- Header --- */
.chat-header {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 14px 22px;
  flex-shrink: 0;
  margin: 8px 12px 0;
}

.chat-peer-name {
  margin: 0;
  font-family: var(--font-display);
  font-size: 22px;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

/* --- Messages --- */
.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 16px 12px;
}

.messages-inner {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.message-row {
  display: flex;
  flex-direction: column;
  max-width: 75%;
}

.message-sent {
  align-self: flex-end;
  align-items: flex-end;
}

.message-received {
  align-self: flex-start;
  align-items: flex-start;
}

.message-bubble {
  padding: 10px 16px;
  border-radius: var(--radius-lg);
  font-size: 14px;
  line-height: 1.5;
  word-break: break-word;
}

.bubble-sent {
  background: var(--color-primary);
  color: #fff;
  border-bottom-right-radius: var(--radius-sm);
  box-shadow: 0 4px 14px rgba(123, 167, 224, 0.25);
}

.bubble-received {
  color: var(--text-primary);
  border-bottom-left-radius: var(--radius-sm);
}

.message-time {
  font-size: 11px;
  color: var(--text-muted);
  margin-top: 4px;
  padding: 0 4px;
}

/* --- Footer --- */
.chat-footer {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 18px;
  flex-shrink: 0;
  margin: 0 12px 8px;
}

.footer-input-wrap {
  flex: 1;
}
</style>
