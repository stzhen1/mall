<template>
  <el-container>
    <el-header>
      <div class="nav-left">
        <el-button @click="$router.push('/')" text>Dashboard</el-button>
        <span class="nav-sep">/</span>
        <span class="nav-cur">Products</span>
      </div>
    </el-header>
    <el-main>
      <!-- Page Header -->
      <div class="page-header glass-panel anim-fade-up">
        <h1 class="page-title">Product Management</h1>
        <p class="page-subtitle">Oversee, review, and moderate product listings across the platform</p>
      </div>

      <!-- Table -->
      <div class="anim-fade-up" style="animation-delay: 0.1s">
        <el-table :data="products" style="width:100%">
          <el-table-column label="Image" width="80">
            <template #default="{ row }">
              <img :src="row.mainImage || 'https://placehold.co/60x60'" style="width:50px;height:50px;object-fit:cover;border-radius:8px;" />
            </template>
          </el-table-column>
          <el-table-column prop="name" label="Name" />
          <el-table-column label="Price" width="120"><template #default="{ row }">${{ row.price }}</template></el-table-column>
          <el-table-column prop="stock" label="Stock" width="80" />
          <el-table-column prop="status" label="Status" width="100">
            <template #default="{ row }"><el-tag :type="row.status === 'ON' ? 'success' : 'info'">{{ row.status }}</el-tag></template>
          </el-table-column>
          <el-table-column label="Actions" width="120">
            <template #default="{ row }">
              <el-button size="small" type="danger" @click="forceDelist(row)">Force Delist</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getProducts, updateProductStatus } from '../api/admin'
import { ElMessage } from 'element-plus'

const products = ref([])

onMounted(async () => {
  const res = await getProducts({ page: 1, size: 100 })
  products.value = res.data.records
})

async function forceDelist(row) {
  await updateProductStatus(row.id, 'OFF')
  row.status = 'OFF'
  ElMessage.success('Product delisted')
}
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
