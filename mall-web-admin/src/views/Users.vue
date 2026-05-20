<template>
  <el-container>
    <el-header>
      <div class="nav-left">
        <el-button @click="$router.push('/')" text>Dashboard</el-button>
        <span class="nav-sep">/</span>
        <span class="nav-cur">Users</span>
      </div>
    </el-header>
    <el-main>
      <!-- Page Header -->
      <div class="page-header glass-panel anim-fade-up">
        <h1 class="page-title">User Management</h1>
        <p class="page-subtitle">Manage user accounts, roles, and access status</p>
      </div>

      <!-- Table -->
      <div class="anim-fade-up" style="animation-delay: 0.1s">
        <el-table :data="users" style="width:100%" v-loading="loading">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="username" label="Username" />
          <el-table-column prop="role" label="Role" width="120">
            <template #default="{ row }">
              <el-tag :type="row.role === 'ADMIN' ? 'danger' : row.role === 'SELLER' ? 'warning' : 'success'">{{ row.role }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="phone" label="Phone" width="150" />
          <el-table-column prop="status" label="Status" width="120">
            <template #default="{ row }">
              <el-switch :model-value="row.status === 1" @change="toggleStatus(row)"
                active-text="Active" inactive-text="Disabled" />
            </template>
          </el-table-column>
          <el-table-column prop="createdAt" label="Registered" width="180" />
        </el-table>
        <el-pagination style="margin-top:16px;justify-content:center;"
          v-model:current-page="page" v-model:page-size="size"
          :total="total" layout="total, prev, pager, next" @current-change="fetchUsers" />
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getUsers, toggleUserStatus } from '../api/admin'
import { ElMessage } from 'element-plus'

const users = ref([])
const loading = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)

async function fetchUsers() {
  loading.value = true
  try {
    const res = await getUsers({ page: page.value, size: size.value })
    users.value = res.data.records
    total.value = res.data.total
  } catch (e) {
    ElMessage.error('Failed to load users')
  } finally { loading.value = false }
}

async function toggleStatus(row) {
  try {
    await toggleUserStatus(row.id)
    row.status = row.status === 1 ? 0 : 1
    ElMessage.success('Status updated')
  } catch (e) {
    ElMessage.error('Failed to update status')
  }
}

onMounted(fetchUsers)
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
