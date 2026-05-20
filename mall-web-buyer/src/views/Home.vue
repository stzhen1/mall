<template>
  <div class="home-page">
    <!-- Decorative top gradient bar -->
    <div class="header-gradient"></div>

    <header class="home-header glass-panel">
      <div class="header-brand">
        <h1 class="app-name">Mall</h1>
        <p class="tagline">Discover Curated Elegance</p>
      </div>
      <div class="header-tools">
        <el-input
          v-model="keyword"
          placeholder="Search products..."
          class="header-search"
          @keyup.enter="search"
        />
        <nav class="header-nav">
          <el-button v-if="!auth.isLoggedIn" @click="$router.push('/login')">Login</el-button>
          <template v-else>
            <el-button @click="$router.push('/orders')">My Orders</el-button>
            <el-button @click="$router.push('/chat')">Chat</el-button>
            <el-button @click="$router.push('/profile')">My Account</el-button>
          </template>
        </nav>
      </div>
    </header>

    <section class="product-grid-section">
      <el-row :gutter="20">
        <el-col
          v-for="(p, index) in products"
          :key="p.id"
          :span="6"
          class="product-col"
        >
          <div
            class="product-card glass-card anim-fade-up"
            :style="{ animationDelay: index * 50 + 'ms' }"
            @click="$router.push(`/product/${p.id}`)"
          >
            <div class="product-img-wrap">
              <img
                :src="p.mainImage || 'https://placehold.co/300x200?text=No+Image'"
                :alt="p.name"
              />
            </div>
            <div class="product-body">
              <h3 class="product-name">{{ p.name }}</h3>
              <p class="product-seller" v-if="p.sellerName">{{ p.sellerName }}</p>
              <div class="product-footer">
                <span class="product-price">${{ p.price }}</span>
                <span class="product-stock">Stock: {{ p.stock }}</span>
              </div>
            </div>
          </div>
        </el-col>
      </el-row>

      <div class="pagination-wrap" v-if="total > 10">
        <el-pagination
          v-model:current-page="page"
          :page-size="10"
          layout="prev, pager, next"
          :total="total"
          @current-change="loadProducts"
        />
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getProducts } from '../api/product'

const auth = useAuthStore()
const products = ref([])
const page = ref(1)
const total = ref(0)
const keyword = ref('')

async function loadProducts() {
  const res = await getProducts({ page: page.value, size: 10, keyword: keyword.value })
  products.value = res.data.records
  total.value = res.data.total
}

function search() {
  page.value = 1
  loadProducts()
}

onMounted(loadProducts)
</script>

<style scoped>
/* ===== Page Layout ===== */
.home-page {
  position: relative;
  min-height: 100vh;
}

/* ===== Decorative Gradient ===== */
.header-gradient {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 220px;
  pointer-events: none;
  z-index: 0;
  background:
    radial-gradient(ellipse at 50% 0%, rgba(123, 167, 224, 0.10) 0%, transparent 60%),
    radial-gradient(ellipse at 80% 0%, rgba(244, 195, 176, 0.08) 0%, transparent 50%),
    linear-gradient(180deg, rgba(255, 255, 255, 0.55) 0%, transparent 100%);
}

/* ===== Header ===== */
.home-header {
  position: sticky;
  top: 12px;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 16px;
  margin: 0 20px;
  padding: 18px 28px;
  border-radius: var(--radius-xl);
}

.header-brand {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.app-name {
  font-family: var(--font-display);
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0;
  line-height: 1.15;
  letter-spacing: -0.02em;
  background: linear-gradient(135deg, var(--text-primary) 20%, var(--color-primary-dark) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.tagline {
  margin: 0;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-muted);
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.header-tools {
  display: flex;
  align-items: center;
  gap: 14px;
  flex-wrap: wrap;
}

.header-search {
  width: 280px;
}

.header-nav {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* ===== Product Grid ===== */
.product-grid-section {
  position: relative;
  z-index: 1;
  padding: 24px 28px 48px;
}

.product-col {
  margin-bottom: 20px;
}

/* ===== Product Card ===== */
.product-card {
  cursor: pointer;
  overflow: hidden;
}

.product-img-wrap {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
  border-radius: var(--radius-lg) var(--radius-lg) 0 0;
}

.product-img-wrap::after {
  content: '';
  position: absolute;
  inset: 0;
  border-radius: inherit;
  border: 1px solid rgba(255, 255, 255, 0.4);
  pointer-events: none;
}

.product-img-wrap img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.product-card:hover .product-img-wrap img {
  transform: scale(1.06);
}

.product-body {
  padding: 14px 16px 16px;
}

.product-name {
  font-family: var(--font-body);
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0 0 4px;
  line-height: 1.35;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-seller {
  margin: 0 0 8px;
  font-size: 12px;
  color: var(--text-muted);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.product-price {
  font-family: var(--font-body);
  font-size: 18px;
  font-weight: 600;
  color: var(--color-accent);
  filter: saturate(1.3);
}

.product-stock {
  font-size: 12px;
  color: var(--text-muted);
}

/* ===== Pagination ===== */
.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 12px;
}
</style>
