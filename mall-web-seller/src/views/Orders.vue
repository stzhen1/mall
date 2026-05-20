<template>
  <el-container>
    <el-header class="top-nav">
      <div class="nav-left">
        <el-button @click="$router.push('/')">&larr; Dashboard</el-button>
      </div>
      <span class="brand-text">Mall Seller</span>
      <div class="nav-right"></div>
    </el-header>

    <el-main>
      <!-- Page Header -->
      <div class="page-header anim-fade-up">
        <h1 class="page-title">Orders</h1>
        <p class="page-subtitle">Manage and track all customer orders</p>
      </div>

      <!-- Orders Table Card -->
      <div class="table-card glass-card anim-fade-up" style="animation-delay: 0.1s">
        <div class="card-header">
          <h3 class="card-title">All Orders</h3>
          <span class="order-count glass-subtle">{{ orders.length }} orders</span>
        </div>

        <el-table :data="orders" style="width:100%">
          <el-table-column prop="orderNo" label="Order No." min-width="200" />
          <el-table-column label="Total" width="120">
            <template #default="{ row }">
              <span class="amount">${{ row.totalAmount }}</span>
            </template>
          </el-table-column>
          <el-table-column label="Status" width="140">
            <template #default="{ row }">
              <el-tag
                :type="{ PAID: 'warning', SHIPPED: 'primary', DELIVERED: 'success', COMPLETED: 'success', CANCELLED: 'danger' }[row.status] || 'info'"
                class="status-tag"
              >
                {{ row.status }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="createdAt" label="Date" width="180" />
          <el-table-column label="Actions" width="150" fixed="right">
            <template #default="{ row }">
              <el-button
                v-if="row.status === 'PAID'"
                type="primary"
                size="small"
                @click="ship(row)"
              >
                Ship Order
              </el-button>
              <span v-else class="text-muted">&mdash;</span>
            </template>
          </el-table-column>
        </el-table>

        <div v-if="orders.length === 0" class="empty-state">
          <el-empty description="No orders yet" :image-size="80" />
        </div>
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getSellerOrders, shipOrder } from '../api/order'
import { ElMessage } from 'element-plus'

const orders = ref([])

onMounted(async () => {
  const res = await getSellerOrders()
  orders.value = res.data
})

async function ship(row) {
  await shipOrder(row.id)
  ElMessage.success('Shipped')
  orders.value = (await getSellerOrders()).data
}
</script>

<style scoped>
/* ============================================================
   Orders — Page Layout Styles
   ============================================================ */

/* --- Top Nav --- */
.top-nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.nav-left,
.nav-right {
  flex: 0 0 160px;
}

.nav-right {
  /* spacer for symmetry */
}

.brand-text {
  font-family: var(--font-display);
  font-size: 1.15rem;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
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

/* --- Table Card --- */
.table-card {
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

.order-count {
  display: inline-block;
  padding: 4px 14px;
  font-size: 0.8rem;
  font-weight: 500;
  color: var(--text-secondary);
  border-radius: 100px;
}

/* --- Table Cell Enhancements --- */
.amount {
  font-weight: 600;
  font-variant-numeric: tabular-nums;
  color: var(--text-primary);
}

/* --- Status Tag Refinements --- */
.status-tag {
  font-weight: 500;
  letter-spacing: 0.02em;
}

/* --- Empty State --- */
.empty-state {
  padding: 40px 0;
}

/* --- Utilities --- */
.text-muted {
  color: var(--text-muted);
}

/* --- Responsive --- */
@media (max-width: 768px) {
  .page-title {
    font-size: 1.5rem;
  }

  .nav-left,
  .nav-right {
    flex: 0 0 auto;
  }

  .brand-text {
    display: none;
  }

  .card-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }
}
</style>
