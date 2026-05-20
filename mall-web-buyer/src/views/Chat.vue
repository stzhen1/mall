<template>
  <div class="chat-page">
    <header class="page-header glass-panel">
      <el-button @click="$router.push('/')">Back</el-button>
      <h2 class="page-title">Messages</h2>
    </header>
    <div class="page-main">
      <div
        v-for="(c, index) in conversations"
        :key="c.id"
        class="conversation-item glass-card anim-fade-up"
        :style="{ animationDelay: `${index * 0.06}s` }"
        @click="$router.push({ path: `/chat/${c.peerId}`, query: { peerName: c.peerName } })"
      >
        <div class="conv-avatar glass-subtle">
          <span class="avatar-letter">{{ c.peerName?.charAt(0) || '?' }}</span>
        </div>
        <div class="conv-content">
          <div class="conv-top">
            <span class="conv-name">{{ c.peerName }}</span>
            <span class="conv-time">{{ c.lastMessageTime }}</span>
          </div>
          <div class="conv-preview">{{ c.lastMessage || 'No messages yet' }}</div>
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
onMounted(async () => {
  const res = await getConversations()
  conversations.value = res.data
})
</script>

<style scoped>
.chat-page {
  max-width: 700px;
  margin: 0 auto;
  padding: 28px 24px 48px;
  min-height: 100vh;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px 28px;
  margin-bottom: 28px;
}

.page-title {
  font-family: var(--font-display);
  font-size: 28px;
  font-weight: 700;
  margin: 0;
  color: var(--text-primary);
  letter-spacing: -0.015em;
}

.page-main {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.conversation-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 18px;
  cursor: pointer;
}

.conv-avatar {
  width: 46px;
  height: 46px;
  min-width: 46px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-letter {
  font-family: var(--font-display);
  font-size: 20px;
  font-weight: 600;
  color: var(--color-primary-dark);
}

.conv-content {
  flex: 1;
  min-width: 0;
}

.conv-top {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 12px;
}

.conv-name {
  font-family: var(--font-display);
  font-size: 16px;
  font-weight: 700;
  color: var(--text-primary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
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
  margin-top: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
