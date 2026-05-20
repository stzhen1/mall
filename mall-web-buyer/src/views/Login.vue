<template>
  <div class="glass-auth-page">

    <!-- Decorative gradient blobs behind the card -->
    <div class="decor-blob decor-blob--1"></div>
    <div class="decor-blob decor-blob--2"></div>

    <div class="glass-auth-card">

      <!-- Header -->
      <div class="auth-header">
        <h1 class="auth-title">Mall</h1>
        <p class="auth-subtitle">Welcome back. Sign in to continue.</p>
      </div>

      <!-- Form -->
      <el-form :model="form" label-position="top" class="auth-form">
        <el-form-item
          label="Username"
          class="anim-fade-up"
          style="animation-delay: 0s"
        >
          <el-input
            v-model="form.username"
            placeholder="Enter your username"
            prefix-icon="User"
          />
        </el-form-item>

        <el-form-item
          label="Password"
          class="anim-fade-up"
          style="animation-delay: 0.1s"
        >
          <el-input
            v-model="form.password"
            type="password"
            placeholder="Enter your password"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>

        <div class="anim-fade-up" style="animation-delay: 0.2s">
          <el-button
            type="primary"
            class="auth-submit-btn"
            @click="handleLogin"
            :loading="loading"
          >
            Sign In
          </el-button>
        </div>
      </el-form>

      <!-- Footer -->
      <p class="auth-footer anim-fade-up" style="animation-delay: 0.3s">
        Don't have an account?
        <router-link to="/register">Create one</router-link>
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
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
/* ---- Decorative gradient blobs ---- */
.decor-blob {
  position: fixed;
  border-radius: 50%;
  pointer-events: none;
  z-index: 0;
  filter: blur(120px);
  opacity: 0.45;
}

.decor-blob--1 {
  width: 420px;
  height: 420px;
  top: -120px;
  right: -100px;
  background: radial-gradient(circle, var(--color-primary-light), transparent 70%);
}

.decor-blob--2 {
  width: 360px;
  height: 360px;
  bottom: -80px;
  left: -90px;
  background: radial-gradient(circle, var(--color-accent-soft), transparent 70%);
  filter: blur(140px);
  opacity: 0.5;
}

/* ---- Auth header ---- */
.auth-header {
  text-align: center;
  margin-bottom: 32px;
}

.auth-title {
  font-family: var(--font-display);
  font-size: 2.25rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 6px;
  letter-spacing: 0.04em;
}

.auth-subtitle {
  font-family: var(--font-body);
  font-size: 0.925rem;
  color: var(--text-secondary);
  margin: 0;
  font-weight: 400;
}

/* ---- Form ---- */
.auth-form {
  margin-top: 8px;
}

.auth-form :deep(.el-form-item__label) {
  font-weight: 500;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.auth-submit-btn {
  width: 100%;
  margin-top: 12px;
  height: 44px;
  font-size: 1rem;
  font-weight: 600;
  letter-spacing: 0.02em;
}

/* ---- Footer ---- */
.auth-footer {
  text-align: center;
  margin: 22px 0 0;
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.auth-footer a {
  color: var(--color-primary-dark);
  text-decoration: none;
  font-weight: 600;
  transition: color var(--transition);
}

.auth-footer a:hover {
  color: var(--color-primary);
  text-decoration: underline;
}
</style>
