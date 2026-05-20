<template>
  <div class="products-page">
    <!-- Glass Header -->
    <div class="page-header glass-panel">
      <div class="header-left">
        <el-button class="back-btn" @click="$router.push('/')">Dashboard</el-button>
        <h1 class="page-title">My Products</h1>
      </div>
      <el-button type="primary" size="large" @click="$router.push('/products/add')">
        Add Product
      </el-button>
    </div>

    <!-- Product List -->
    <div class="product-list">
      <div
        v-for="(product, index) in products"
        :key="product.id"
        class="product-item glass-card anim-fade-up"
        :style="{ animationDelay: `${index * 0.06}s` }"
      >
        <div class="product-image">
          <img :src="product.mainImage || 'https://placehold.co/80x80'" alt="product image" />
        </div>
        <div class="product-info">
          <span class="product-name">{{ product.name }}</span>
          <span class="product-meta">Stock: {{ product.stock }}</span>
        </div>
        <span class="product-price">${{ product.price }}</span>
        <el-tag :type="product.status === 'ON' ? 'success' : 'info'" class="product-status-tag">
          {{ product.status }}
        </el-tag>
        <div class="product-actions">
          <el-button size="small" @click="$router.push(`/products/${product.id}/edit`)">Edit</el-button>
          <el-button size="small" @click="toggleStatus(product)">
            {{ product.status === 'ON' ? 'Off Shelf' : 'On Shelf' }}
          </el-button>
          <el-button size="small" type="danger" @click="del(product)">Delete</el-button>
        </div>
      </div>

      <el-empty v-if="products.length === 0" description="No products yet" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getProducts, updateProductStatus, deleteProduct } from '../api/product'
import { ElMessage, ElMessageBox } from 'element-plus'

const products = ref([])

onMounted(async () => {
  const res = await getProducts({ page: 1, size: 100 })
  products.value = res.data.records
})

async function toggleStatus(row) {
  const newStatus = row.status === 'ON' ? 'OFF' : 'ON'
  await updateProductStatus(row.id, newStatus)
  row.status = newStatus
  ElMessage.success('Status updated')
}

async function del(row) {
  try {
    await ElMessageBox.confirm('Delete this product?', 'Confirm', { type: 'warning' })
    await deleteProduct(row.id)
    products.value = products.value.filter(p => p.id !== row.id)
    ElMessage.success('Deleted')
  } catch (e) { if (e !== 'cancel') ElMessage.error('Failed') }
}
</script>

<style scoped>
.products-page {
  max-width: 960px;
  margin: 0 auto;
  padding: 24px 20px 40px;
}

/* --- Header --- */
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px 28px;
  margin-bottom: 24px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.back-btn {
  flex-shrink: 0;
}

.page-title {
  margin: 0;
  font-family: var(--font-display);
  font-size: 26px;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

/* --- Product List --- */
.product-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.product-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 20px;
  opacity: 0;
}

.product-image {
  flex-shrink: 0;
  width: 60px;
  height: 60px;
  border-radius: var(--radius-sm);
  overflow: hidden;
  background: rgba(255, 255, 255, 0.45);
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-info {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.product-name {
  font-weight: 600;
  color: var(--text-primary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.product-meta {
  font-size: 13px;
  color: var(--text-secondary);
}

.product-price {
  font-weight: 600;
  font-size: 16px;
  color: var(--color-primary);
  white-space: nowrap;
  min-width: 70px;
  text-align: right;
}

.product-status-tag {
  flex-shrink: 0;
}

.product-actions {
  display: flex;
  gap: 6px;
  flex-shrink: 0;
}

@media (max-width: 720px) {
  .product-item {
    flex-wrap: wrap;
  }
  .product-actions {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
