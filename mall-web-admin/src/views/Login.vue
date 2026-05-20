<template>
  <div class="glass-auth-page">
    <div class="decorative-circle"></div>
    <div class="decorative-circle-secondary"></div>

    <div class="glass-auth-card login-card">
      <div class="login-header anim-fade-up" style="animation-delay: 0ms">
        <div class="portal-icon">
          <el-icon :size="22"><Monitor /></el-icon>
        </div>
        <h1 class="portal-title">Admin Portal</h1>
        <p class="portal-subtitle">Sign in to manage your store</p>
        <div class="portal-divider"></div>
      </div>

      <el-form
        :model="form"
        label-position="top"
        class="login-form"
      >
        <el-form-item label="Username" class="form-item-stagger anim-fade-up" style="animation-delay: 100ms">
          <el-input
            v-model="form.username"
            placeholder="Enter username"
            :prefix-icon="User"
            size="large"
          />
        </el-form-item>

        <el-form-item label="Password" class="form-item-stagger anim-fade-up" style="animation-delay: 200ms">
          <el-input
            v-model="form.password"
            type="password"
            placeholder="Enter password"
            :prefix-icon="Lock"
            size="large"
            show-password
          />
        </el-form-item>

        <div class="form-item-stagger anim-fade-up" style="animation-delay: 300ms">
          <el-button
            type="primary"
            size="large"
            class="login-button"
            @click="handleLogin"
            :loading="loading"
          >
            <span v-if="!loading">Sign In</span>
          </el-button>
        </div>
      </el-form>

      <p class="default-hint anim-fade-up" style="animation-delay: 400ms">
        Default credentials: admin / admin123
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { login } from '../api/auth'
import { ElMessage } from 'element-plus'
import { Monitor, User, Lock } from '@element-plus/icons-vue'

const router = useRouter()
const auth = useAuthStore()
const loading = ref(false)
const form = ref({ username: '', password: '' })

async function handleLogin() {
  loading.value = true
  try {
    const res = await login(form.value.username, form.value.password)
    auth.setTokens(res.data)
    router.push('/')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Login failed')
  } finally { loading.value = false }
}
</script>

<style scoped>
/* ============================================================
   Decorative background circles
   ============================================================ */
.decorative-circle {
  position: fixed;
  width: 580px;
  height: 580px;
  border-radius: 50%;
  background: radial-gradient(circle at 50% 50%,
    rgba(123, 167, 224, 0.12) 0%,
    rgba(155, 142, 196, 0.06) 40%,
    transparent 70%
  );
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  pointer-events: none;
  z-index: 0;
  animation: float 7s ease-in-out infinite;
}

.decorative-circle-secondary {
  position: fixed;
  width: 340px;
  height: 340px;
  border-radius: 50%;
  background: radial-gradient(circle at 50% 50%,
    rgba(244, 195, 176, 0.14) 0%,
    rgba(232, 213, 181, 0.06) 40%,
    transparent 70%
  );
  top: 58%;
  left: 54%;
  transform: translate(-50%, -50%);
  pointer-events: none;
  z-index: 0;
  animation: float 9s ease-in-out infinite reverse;
}

@keyframes float {
  0%, 100% { transform: translate(-50%, -50%) translateY(0); }
  50%      { transform: translate(-50%, -50%) translateY(-14px); }
}

/* ============================================================
   Login card custom overrides
   ============================================================ */
.login-card {
  position: relative;
  z-index: 1;
  padding: 44px 40px;
}

/* ============================================================
   Header styles
   ============================================================ */
.login-header {
  text-align: center;
  margin-bottom: 32px;
}

.portal-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 52px;
  height: 52px;
  border-radius: 16px;
  background: linear-gradient(135deg,
    rgba(123, 167, 224, 0.18) 0%,
    rgba(155, 142, 196, 0.12) 100%
  );
  border: 1px solid rgba(123, 167, 224, 0.18);
  margin-bottom: 16px;
  color: var(--color-primary-dark, #5B8BC8);
}

.portal-title {
  font-family: var(--font-display, 'Georgia', serif);
  font-size: 28px;
  font-weight: 600;
  color: var(--text-primary, #2E2E2E);
  margin: 0 0 6px 0;
  letter-spacing: -0.01em;
}

.portal-subtitle {
  font-family: var(--font-body, 'Inter', sans-serif);
  font-size: 14px;
  color: var(--text-muted, #9A9AA6);
  margin: 0 0 18px 0;
  font-weight: 400;
}

.portal-divider {
  width: 48px;
  height: 3px;
  border-radius: 3px;
  background: linear-gradient(90deg,
    var(--color-primary, #7BA7E0) 0%,
    var(--color-accent, #F4C3B0) 100%
  );
  margin: 0 auto;
}

/* ============================================================
   Form styles
   ============================================================ */
.login-form {
  margin-top: 4px;
}

.login-form :deep(.el-form-item__label) {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-secondary, #6B6B76);
  margin-bottom: 2px;
}

.login-button {
  width: 100%;
  height: 46px;
  font-size: 15px;
  font-weight: 500;
  letter-spacing: 0.02em;
  margin-top: 8px;
}

/* ============================================================
   Default hint
   ============================================================ */
.default-hint {
  text-align: center;
  margin-top: 20px;
  margin-bottom: 0;
  font-size: 12.5px;
  color: var(--text-muted, #9A9AA6);
}
</style>
