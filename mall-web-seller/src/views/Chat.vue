<template>
  <div class="chat-page">
    <!-- Glass Header -->
    <div class="page-header glass-panel">
      <div class="header-left">
        <el-button @click="$router.push('/')">Dashboard</el-button>
        <h1 class="page-title">Messages</h1>
      </div>
    </div>

    <!-- Conversation List -->
    <div class="conversation-list">
      <div
        v-for="(c, index) in conversations"
        :key="c.id"
        class="conversation-item glass-card anim-fade-up"
        :style="{ animationDelay: `${index * 0.05}s` }"
        @click="$router.push({ path: `/chat/${c.peerId}`, query: { peerName: c.peerName } })"
      >
        <div class="conv-avatar glass-subtle">{{ c.peerName?.charAt(0)?.toUpperCase() || '?' }}</div>
        <div class="conv-content">
          <div class="conv-top">
            <span class="conv-name">{{ c.peerName }}</span>
            <span class="conv-time">{{ c.lastMessageTime }}</span>
          </div>
          <span class="conv-preview">{{ c.lastMessage || 'No messages yet' }}</span>
        </div>
      </div>

      <el-empty v-if="conversations.length === 0" description="No conversations" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getConversations } from '../api/chat'
const conversations = ref([])
onMounted(async () => { const res = await getConversations(); conversations.value = res.data })
</script>

<style scoped>
.chat-page {
  max-width: 720px;
  margin: 0 auto;
  padding: 24px 20px 40px;
}

/* --- Header --- */
.page-header {
  padding: 20px 28px;
  margin-bottom: 24px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.page-title {
  margin: 0;
  font-family: var(--font-display);
  font-size: 26px;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

/* --- Conversation List --- */
.conversation-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.conversation-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 14px 18px;
  cursor: pointer;
  opacity: 0;
}

.conversation-item:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}

.conv-avatar {
  flex-shrink: 0;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
  background: rgba(255, 255, 255, 0.45);
}

.conv-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.conv-top {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
}

.conv-name {
  font-family: var(--font-display);
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
}

.conv-time {
  font-size: 12px;
  color: var(--text-muted);
  white-space: nowrap;
  flex-shrink: 0;
}

.conv-preview {
  font-size: 13px;
  color: var(--text-secondary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
