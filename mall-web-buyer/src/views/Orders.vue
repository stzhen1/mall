<template>
  <div class="orders-page">
    <header class="page-header glass-panel">
      <el-button @click="$router.push('/')">Back</el-button>
      <h2 class="page-title">My Orders</h2>
    </header>
    <div class="page-main anim-fade-up">
      <el-table :data="orders" style="width:100%">
        <el-table-column prop="orderNo" label="Order No." width="200" />
        <el-table-column label="Total" width="120">
          <template #default="{ row }">${{ row.totalAmount }}</template>
        </el-table-column>
        <el-table-column prop="status" label="Status" width="120">
          <template #default="{ row }">
            <el-tag :type="statusType(row.status)">{{ row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="Date" width="180" />
        <el-table-column label="Actions" width="250">
          <template #default="{ row }">
            <el-button v-if="row.status === 'PENDING'" type="success" size="small" @click="pay(row)">Pay</el-button>
            <el-button v-if="row.status === 'SHIPPED'" type="primary" size="small" @click="receive(row)">Confirm Receipt</el-button>
            <el-button v-if="['PAID','SHIPPED','RECEIVED'].includes(row.status)" size="small" @click="openAfterSale(row)">After-Sale</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getBuyerOrders, payOrder, receiveOrder, requestAfterSale } from '../api/order'
import { ElMessage, ElMessageBox } from 'element-plus'

const orders = ref([])

onMounted(async () => {
  const res = await getBuyerOrders()
  orders.value = res.data
})

function statusType(status) {
  const map = { PENDING: 'warning', PAID: 'info', SHIPPED: '', RECEIVED: 'success', REFUNDING: 'danger' }
  return map[status] || ''
}

async function pay(row) {
  await payOrder(row.id)
  ElMessage.success('Payment successful')
  orders.value = (await getBuyerOrders()).data
}

async function receive(row) {
  await receiveOrder(row.id)
  ElMessage.success('Confirmed receipt')
  orders.value = (await getBuyerOrders()).data
}

async function openAfterSale(row) {
  try {
    const { value } = await ElMessageBox.prompt('Reason for after-sales?', 'After-Sales', { inputType: 'textarea' })
    await requestAfterSale(row.id, { type: 'REFUND', reason: value })
    ElMessage.success('After-sales request submitted')
    orders.value = (await getBuyerOrders()).data
  } catch (e) {
    if (e !== 'cancel') ElMessage.error(e.response?.data?.message || 'Failed')
  }
}
</script>

<style scoped>
.orders-page {
  max-width: 1100px;
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
  /* container for the animated table */
}
</style>
