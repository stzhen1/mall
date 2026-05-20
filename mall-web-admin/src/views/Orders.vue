<template>
  <el-container>
    <el-header>
      <div class="nav-left">
        <el-button @click="$router.push('/')" text>Dashboard</el-button>
        <span class="nav-sep">/</span>
        <span class="nav-cur">Orders</span>
      </div>
    </el-header>
    <el-main>
      <!-- Page Header -->
      <div class="page-header glass-panel anim-fade-up">
        <h1 class="page-title">Order Management</h1>
        <p class="page-subtitle">Track, review, and monitor all platform orders</p>
      </div>

      <!-- Table -->
      <div class="anim-fade-up" style="animation-delay: 0.1s">
        <el-table :data="orders" style="width:100%" v-loading="loading">
          <el-table-column prop="orderNo" label="Order No." width="200" />
          <el-table-column prop="buyerId" label="Buyer ID" width="100" />
          <el-table-column prop="sellerId" label="Seller ID" width="100" />
          <el-table-column label="Total" width="120"><template #default="{ row }">${{ row.totalAmount }}</template></el-table-column>
          <el-table-column prop="status" label="Status" width="120">
            <template #default="{ row }"><el-tag :type="statusType(row.status)">{{ row.status }}</el-tag></template>
          </el-table-column>
          <el-table-column prop="createdAt" label="Date" width="180" />
        </el-table>
        <el-pagination style="margin-top:16px;justify-content:center;"
          v-model:current-page="page" v-model:page-size="size"
          :total="total" layout="total, prev, pager, next" @current-change="fetchOrders" />
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getOrders } from '../api/admin'
import { ElMessage } from 'element-plus'

const orders = ref([])
const loading = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)

function statusType(status) {
  const map = { PENDING: 'info', PAID: 'warning', SHIPPED: '', RECEIVED: 'success', CANCELLED: 'danger', REFUNDING: 'warning', REFUNDED: 'info' }
  return map[status] || 'info'
}

async function fetchOrders() {
  loading.value = true
  try {
    const res = await getOrders({ page: page.value, size: size.value })
    orders.value = res.data.records
    total.value = res.data.total
  } catch (e) {
    ElMessage.error('Failed to load orders')
  } finally { loading.value = false }
}

onMounted(fetchOrders)
</script>

<style scoped>
/* --- Page Header --- */
.page-header {
  padding: 26px 30px;
  margin-bottom: 24px;
}

.page-title {
  font-family: var(--font-display);
  font-size: 1.85rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 5px;
  letter-spacing: -0.02em;
  line-height: 1.2;
}

.page-subtitle {
  font-size: 0.92rem;
  color: var(--text-secondary);
  margin: 0;
  font-weight: 400;
}

/* --- Nav --- */
.nav-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-sep {
  color: var(--text-muted);
  font-size: 0.9rem;
}

.nav-cur {
  font-size: 0.95rem;
  font-weight: 500;
  color: var(--text-secondary);
}

@media (max-width: 560px) {
  .page-header {
    padding: 20px 18px;
  }

  .page-title {
    font-size: 1.4rem;
  }
}
</style>
