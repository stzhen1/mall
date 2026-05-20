<template>
  <div class="glass-auth-page">
    <!-- Decorative gradient circles -->
    <div class="decor-circle"></div>
    <div class="decor-circle-secondary"></div>

    <!-- Auth card -->
    <div class="glass-auth-card auth-card-inner">
      <!-- Decorative header -->
      <div class="auth-header">
        <h1 class="auth-title">Seller Portal</h1>
        <p class="auth-subtitle">Create your seller account</p>
      </div>

      <!-- Registration form -->
      <el-form :model="form" label-position="top" class="auth-form">
        <el-form-item label="Username" class="form-item-stagger" style="animation-delay: 0.1s">
          <el-input v-model="form.username" placeholder="Enter username" />
        </el-form-item>
        <el-form-item label="Password" class="form-item-stagger" style="animation-delay: 0.2s">
          <el-input v-model="form.password" type="password" placeholder="Enter password" />
        </el-form-item>
        <div class="form-item-stagger" style="animation-delay: 0.3s">
          <el-button type="primary" style="width:100%" @click="handleRegister" :loading="loading">Create Account</el-button>
        </div>
      </el-form>

      <!-- Footer link -->
      <p class="auth-footer">Already have an account? <router-link to="/login">Sign in</router-link></p>
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
const form = ref({ username: '', password: '' })

async function handleRegister() {
  loading.value = true
  try {
    const res = await register(form.value.username, form.value.password, 'SELLER')
    auth.setTokens(res.data)
    router.push('/')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Registration failed')
  } finally { loading.value = false }
}
</script>

<style scoped>
.glass-auth-page {
  position: relative;
  overflow: hidden;
}

/* --- Decorative gradient circles --- */
.decor-circle {
  position: absolute;
  width: 520px;
  height: 520px;
  border-radius: 50%;
  background: radial-gradient(
    circle,
    var(--color-accent-soft) 0%,
    rgba(253, 232, 223, 0.35) 35%,
    rgba(232, 228, 223, 0.15) 65%,
    transparent 75%
  );
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 0;
  pointer-events: none;
  animation: float 6s ease-in-out infinite;
}

.decor-circle-secondary {
  position: absolute;
  width: 320px;
  height: 320px;
  border-radius: 50%;
  background: radial-gradient(
    circle,
    rgba(163, 197, 238, 0.3) 0%,
    rgba(163, 197, 238, 0.12) 45%,
    transparent 70%
  );
  top: 38%;
  left: 58%;
  transform: translate(-50%, -50%);
  z-index: 0;
  pointer-events: none;
  animation: float 8s ease-in-out 2s infinite;
}

/* --- Inner card wrapper --- */
.auth-card-inner {
  position: relative;
  z-index: 1;
}

/* --- Header --- */
.auth-header {
  text-align: center;
  margin-bottom: 32px;
}

.auth-title {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 6px;
  letter-spacing: -0.02em;
  line-height: 1.2;
}

.auth-subtitle {
  font-family: var(--font-body);
  font-size: 0.95rem;
  color: var(--text-muted);
  margin: 0;
  font-weight: 400;
}

/* --- Form --- */
.auth-form {
  margin-top: 4px;
}

.form-item-stagger {
  opacity: 0;
  animation: fadeUp 0.5s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}

/* --- Footer link --- */
.auth-footer {
  text-align: center;
  margin: 24px 0 0;
  color: var(--text-muted);
  font-size: 0.9rem;
}

.auth-footer a {
  color: var(--color-primary);
  text-decoration: none;
  font-weight: 500;
  transition: color var(--transition);
}

.auth-footer a:hover {
  color: var(--color-primary-dark);
}
</style>
