<template>
  <div class="glass-auth-page">

    <!-- Decorative gradient blobs behind the card -->
    <div class="decor-blob decor-blob--1"></div>
    <div class="decor-blob decor-blob--2"></div>

    <div class="glass-auth-card">

      <!-- Header -->
      <div class="auth-header">
        <h1 class="auth-title">Mall</h1>
        <p class="auth-subtitle">Create your account and get started.</p>
      </div>

      <!-- Form -->
      <el-form :model="form" label-position="top" class="auth-form">

        <!-- Role selector -->
        <el-form-item
          label="Account Type"
          class="anim-fade-up"
          style="animation-delay: 0s"
        >
          <el-radio-group v-model="form.role" class="role-group">
            <el-radio-button value="BUYER">
              <span class="role-label">
                <el-icon><User /></el-icon>
                Buyer
              </span>
            </el-radio-button>
            <el-radio-button value="SELLER">
              <span class="role-label">
                <el-icon><Shop /></el-icon>
                Seller
              </span>
            </el-radio-button>
          </el-radio-group>
        </el-form-item>

        <el-form-item
          label="Username"
          class="anim-fade-up"
          style="animation-delay: 0.1s"
        >
          <el-input
            v-model="form.username"
            placeholder="Choose a username"
            prefix-icon="User"
          />
        </el-form-item>

        <el-form-item
          label="Password"
          class="anim-fade-up"
          style="animation-delay: 0.2s"
        >
          <el-input
            v-model="form.password"
            type="password"
            placeholder="Create a strong password"
            prefix-icon="Lock"
            show-password
          />
        </el-form-item>

        <div class="anim-fade-up" style="animation-delay: 0.3s">
          <el-button
            type="primary"
            class="auth-submit-btn"
            @click="handleRegister"
            :loading="loading"
          >
            Create Account
          </el-button>
        </div>
      </el-form>

      <!-- Footer -->
      <p class="auth-footer anim-fade-up" style="animation-delay: 0.35s">
        Already have an account?
        <router-link to="/login">Sign in</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { register } from '../api/auth'
import { ElMessage } from 'element-plus'

const router = useRouter()
const auth = useAuthStore()
const loading = ref(false)
const form = ref({ username: '', password: '', role: 'BUYER' })

async function handleRegister() {
  loading.value = true
  try {
    const res = await register(form.value.username, form.value.password, form.value.role)
    auth.setTokens(res.data)
    router.push('/')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Registration failed')
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

/* ---- Role selector ---- */
.role-group {
  width: 100%;
  display: flex;
}

.role-group :deep(.el-radio-button) {
  flex: 1;
}

.role-group :deep(.el-radio-button__inner) {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 6px;
  background: var(--glass-bg);
  backdrop-filter: var(--glass-blur);
  -webkit-backdrop-filter: var(--glass-blur);
  border: 1px solid var(--glass-border);
  border-radius: var(--radius);
  padding: 10px 0;
  font-weight: 500;
  color: var(--text-secondary);
  transition: all var(--transition);
}

.role-group :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #fff;
  box-shadow: 0 4px 14px rgba(123, 167, 224, 0.35);
}

.role-group :deep(.el-radio-button__inner:hover) {
  color: var(--color-primary-dark);
  border-color: var(--color-primary-light);
}

.role-label {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 0.925rem;
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
