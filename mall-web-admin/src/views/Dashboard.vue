<template>
  <el-container>
    <el-header>
      <div class="nav-left">
        <span class="nav-brand">Mall Admin</span>
      </div>
      <div class="nav-right">
        <el-button @click="auth.logout()">Logout</el-button>
      </div>
    </el-header>
    <el-main>
      <!-- Page Header -->
      <div class="page-header glass-panel anim-fade-up">
        <h1 class="page-title">Admin Dashboard</h1>
        <p class="page-subtitle">Platform overview and key metrics at a glance</p>
      </div>

      <!-- Stats Row -->
      <div class="stats-grid">
        <div
          class="stat-card glass-card anim-fade-up"
          style="animation-delay: 0.05s"
        >
          <div class="stat-icon" style="background: var(--color-primary-light)">
            <svg viewBox="0 0 24 24" width="22" height="22" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="9" cy="7" r="4"/>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
          </div>
          <div class="stat-body">
            <span class="stat-value">0</span>
            <span class="stat-label">Total Users</span>
          </div>
        </div>

        <div
          class="stat-card glass-card anim-fade-up"
          style="animation-delay: 0.15s"
        >
          <div class="stat-icon" style="background: var(--color-accent)">
            <svg viewBox="0 0 24 24" width="22" height="22" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
              <polyline points="3.27 6.96 12 12.01 20.73 6.96"/>
              <line x1="12" y1="22.08" x2="12" y2="12"/>
            </svg>
          </div>
          <div class="stat-body">
            <span class="stat-value">0</span>
            <span class="stat-label">Total Products</span>
          </div>
        </div>

        <div
          class="stat-card glass-card anim-fade-up"
          style="animation-delay: 0.25s"
        >
          <div class="stat-icon" style="background: var(--color-gold)">
            <svg viewBox="0 0 24 24" width="22" height="22" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
              <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
              <line x1="12" y1="11" x2="12" y2="17"/>
              <line x1="9" y1="14" x2="15" y2="14"/>
            </svg>
          </div>
          <div class="stat-body">
            <span class="stat-value">0</span>
            <span class="stat-label">Total Orders</span>
          </div>
        </div>

        <div
          class="stat-card glass-card anim-fade-up"
          style="animation-delay: 0.35s"
        >
          <div class="stat-icon" style="background: var(--color-primary-dark)">
            <svg viewBox="0 0 24 24" width="22" height="22" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <line x1="12" y1="1" x2="12" y2="23"/>
              <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
            </svg>
          </div>
          <div class="stat-body">
            <span class="stat-value">$0</span>
            <span class="stat-label">Total Revenue</span>
          </div>
        </div>
      </div>

      <!-- Quick Links -->
      <div
        class="quick-links glass-card anim-fade-up"
        style="animation-delay: 0.45s"
      >
        <h2 class="section-title">Quick Actions</h2>
        <div class="action-list">
          <div class="action-item glass-subtle" @click="$router.push('/users')">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="var(--color-primary)" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="9" cy="7" r="4"/>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
            <span>Manage Users</span>
            <svg viewBox="0 0 24 24" width="16" height="16" stroke="var(--text-muted)" stroke-width="2" fill="none" class="action-arrow">
              <polyline points="9 18 15 12 9 6"/>
            </svg>
          </div>
          <div class="action-item glass-subtle" @click="$router.push('/products')">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="var(--color-primary)" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
              <polyline points="3.27 6.96 12 12.01 20.73 6.96"/>
              <line x1="12" y1="22.08" x2="12" y2="12"/>
            </svg>
            <span>Manage Products</span>
            <svg viewBox="0 0 24 24" width="16" height="16" stroke="var(--text-muted)" stroke-width="2" fill="none" class="action-arrow">
              <polyline points="9 18 15 12 9 6"/>
            </svg>
          </div>
          <div class="action-item glass-subtle" @click="$router.push('/orders')">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="var(--color-primary)" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
              <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
            </svg>
            <span>Manage Orders</span>
            <svg viewBox="0 0 24 24" width="16" height="16" stroke="var(--text-muted)" stroke-width="2" fill="none" class="action-arrow">
              <polyline points="9 18 15 12 9 6"/>
            </svg>
          </div>
        </div>
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { useAuthStore } from '../stores/auth'
const auth = useAuthStore()
</script>

<style scoped>
/* --- Page Header --- */
.page-header {
  padding: 28px 32px;
  margin-bottom: 24px;
}

.page-title {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 6px;
  letter-spacing: -0.02em;
  line-height: 1.2;
}

.page-subtitle {
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin: 0;
  font-weight: 400;
}

/* --- Stats Grid --- */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 28px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 18px;
  padding: 22px 24px;
  cursor: default;
}

.stat-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-body {
  display: flex;
  flex-direction: column;
  gap: 3px;
  min-width: 0;
}

.stat-value {
  font-family: var(--font-display);
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1.1;
}

.stat-label {
  font-size: 0.85rem;
  color: var(--text-secondary);
  font-weight: 500;
}

/* --- Quick Links --- */
.quick-links {
  padding: 26px 30px;
}

.section-title {
  font-family: var(--font-display);
  font-size: 1.3rem;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0 0 18px;
  letter-spacing: -0.01em;
}

.action-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.action-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 15px 20px;
  cursor: pointer;
  user-select: none;
  transition: transform var(--transition, 0.25s), box-shadow var(--transition, 0.25s);
}

.action-item:hover {
  transform: translateX(6px);
}

.action-item span {
  flex: 1;
  font-size: 0.95rem;
  font-weight: 500;
  color: var(--text-primary);
}

.action-arrow {
  flex-shrink: 0;
  transition: transform var(--transition, 0.25s);
}

.action-item:hover .action-arrow {
  transform: translateX(3px);
}

/* --- Nav --- */
.nav-left {
  display: flex;
  align-items: center;
}

.nav-brand {
  font-family: var(--font-display);
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

.nav-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 8px;
}

/* --- Responsive --- */
@media (max-width: 960px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 560px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }

  .page-header {
    padding: 22px 20px;
  }

  .page-title {
    font-size: 1.5rem;
  }
}
</style>
