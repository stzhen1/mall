<template>
  <el-container>
    <el-header class="top-nav">
      <span class="brand-text">Mall Seller</span>
      <div class="nav-actions">
        <el-button @click="$router.push('/products')">Products</el-button>
        <el-button @click="$router.push('/orders')">Orders</el-button>
        <el-button @click="$router.push('/chat')">Chat</el-button>
        <el-button @click="auth.logout()">Logout</el-button>
      </div>
    </el-header>

    <el-main>
      <!-- Page Header -->
      <div class="page-header anim-fade-up">
        <h1 class="page-title">Dashboard</h1>
        <p class="page-subtitle">Overview of your store performance and recent activity</p>
      </div>

      <!-- Stats Row -->
      <div class="stats-row">
        <div class="stat-card glass-card anim-fade-up" style="animation-delay: 0.05s">
          <div class="stat-icon stat-icon--products">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
              <polyline points="3.27 6.96 12 12.01 20.73 6.96"/>
              <line x1="12" y1="22.08" x2="12" y2="12"/>
            </svg>
          </div>
          <div class="stat-content">
            <div class="stat-value">0</div>
            <div class="stat-label">Total Products</div>
          </div>
        </div>

        <div class="stat-card glass-card anim-fade-up" style="animation-delay: 0.1s">
          <div class="stat-icon stat-icon--orders">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
              <polyline points="14 2 14 8 20 8"/>
              <line x1="16" y1="13" x2="8" y2="13"/>
              <line x1="16" y1="17" x2="8" y2="17"/>
            </svg>
          </div>
          <div class="stat-content">
            <div class="stat-value">0</div>
            <div class="stat-label">Total Orders</div>
          </div>
        </div>

        <div class="stat-card glass-card anim-fade-up" style="animation-delay: 0.15s">
          <div class="stat-icon stat-icon--revenue">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <line x1="12" y1="1" x2="12" y2="23"/>
              <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
            </svg>
          </div>
          <div class="stat-content">
            <div class="stat-value">$0</div>
            <div class="stat-label">Total Revenue</div>
          </div>
        </div>

        <div class="stat-card glass-card anim-fade-up" style="animation-delay: 0.2s">
          <div class="stat-icon stat-icon--messages">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/>
            </svg>
          </div>
          <div class="stat-content">
            <div class="stat-value">0</div>
            <div class="stat-label">Unread Messages</div>
          </div>
        </div>
      </div>

      <!-- Content Grid -->
      <div class="content-grid">
        <!-- Recent Orders -->
        <div class="content-card glass-card anim-fade-up" style="animation-delay: 0.25s">
          <div class="card-header">
            <h3 class="card-title">Recent Orders</h3>
            <el-button text type="primary" @click="$router.push('/orders')">View All &rarr;</el-button>
          </div>
          <el-table :data="[]" style="width:100%">
            <el-table-column prop="orderNo" label="Order No." min-width="180" />
            <el-table-column label="Total" width="120">
              <template #default><span class="text-muted">&mdash;</span></template>
            </el-table-column>
            <el-table-column label="Status" width="130">
              <template #default><span class="text-muted">&mdash;</span></template>
            </el-table-column>
            <el-table-column label="Date" width="180">
              <template #default><span class="text-muted">&mdash;</span></template>
            </el-table-column>
          </el-table>
        </div>

        <!-- Quick Actions -->
        <div class="content-card glass-card anim-fade-up" style="animation-delay: 0.3s">
          <div class="card-header">
            <h3 class="card-title">Quick Actions</h3>
          </div>
          <div class="quick-actions">
            <div class="action-item glass-subtle action-item--products" @click="$router.push('/products')">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="16"/>
                <line x1="8" y1="12" x2="16" y2="12"/>
              </svg>
              <span>Add Product</span>
            </div>
            <div class="action-item glass-subtle action-item--orders" @click="$router.push('/orders')">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                <line x1="3" y1="9" x2="21" y2="9"/>
                <line x1="9" y1="21" x2="9" y2="9"/>
              </svg>
              <span>Manage Orders</span>
            </div>
            <div class="action-item glass-subtle action-item--chat" @click="$router.push('/chat')">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
              </svg>
              <span>Open Chat</span>
            </div>
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
/* ============================================================
   Dashboard — Page Layout Styles
   ============================================================ */

/* --- Top Nav --- */
.top-nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.brand-text {
  font-family: var(--font-display);
  font-size: 1.15rem;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

.nav-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* --- Page Header --- */
.page-header {
  margin-bottom: 28px;
}

.page-title {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0 0 6px 0;
  letter-spacing: -0.01em;
  line-height: 1.2;
}

.page-subtitle {
  font-family: var(--font-body);
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin: 0;
  font-weight: 400;
}

/* --- Stats Row --- */
.stats-row {
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
  width: 48px;
  height: 48px;
  border-radius: var(--radius);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  transition: transform var(--transition);
}

.stat-card:hover .stat-icon {
  transform: scale(1.08);
}

.stat-content {
  min-width: 0;
}

.stat-value {
  font-family: var(--font-display);
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1.2;
}

.stat-label {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-top: 2px;
  white-space: nowrap;
}

/* Stat icon color variants */
.stat-icon--products {
  background: rgba(123, 167, 224, 0.12);
  color: var(--color-primary-dark);
}

.stat-icon--orders {
  background: rgba(232, 213, 181, 0.2);
  color: #b8956a;
}

.stat-icon--revenue {
  background: rgba(103, 194, 58, 0.1);
  color: #5a9e32;
}

.stat-icon--messages {
  background: rgba(244, 195, 176, 0.15);
  color: #d4896e;
}

/* --- Content Grid --- */
.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
  align-items: start;
}

/* --- Content Card --- */
.content-card {
  padding: 0;
  overflow: hidden;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 24px 0 24px;
  margin-bottom: 12px;
}

.card-title {
  font-family: var(--font-display);
  font-size: 1.15rem;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0;
  letter-spacing: -0.01em;
}

/* --- Quick Actions --- */
.quick-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 0 24px 24px 24px;
}

.action-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 18px;
  cursor: pointer;
  font-size: 0.925rem;
  font-weight: 500;
  color: var(--text-primary);
  transition:
    transform var(--transition),
    box-shadow var(--transition),
    background var(--transition);
  user-select: none;
}

.action-item:hover {
  transform: translateY(-1px);
  box-shadow: var(--shadow-sm);
  background: rgba(255, 255, 255, 0.55);
}

.action-item--products {
  color: var(--color-primary-dark);
}

.action-item--orders {
  color: #b8956a;
}

.action-item--chat {
  color: #d4896e;
}

/* --- Utilities --- */
.text-muted {
  color: var(--text-muted);
}

/* --- Responsive --- */
@media (max-width: 1200px) {
  .stats-row {
    grid-template-columns: repeat(2, 1fr);
  }

  .content-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 640px) {
  .stats-row {
    grid-template-columns: 1fr;
  }

  .page-title {
    font-size: 1.5rem;
  }

  .stat-card {
    padding: 16px 18px;
  }

  .stat-value {
    font-size: 1.4rem;
  }

  .top-nav {
    flex-wrap: wrap;
    gap: 8px;
  }
}
</style>
