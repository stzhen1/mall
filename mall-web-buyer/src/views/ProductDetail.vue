<template>
  <div class="detail-page">
    <!-- Decorative background accent -->
    <div class="detail-bg-accent"></div>

    <header class="detail-topbar glass-panel">
      <el-button @click="$router.push('/')">Back</el-button>
      <span class="topbar-title">{{ product.name }}</span>
    </header>

    <main class="detail-main" v-if="product.id">
      <div class="detail-layout anim-fade-up">
        <div class="image-frame glass-card">
          <img
            :src="product.mainImage || 'https://placehold.co/400x400?text=No+Image'"
            :alt="product.name"
          />
        </div>

        <div class="info-panel glass-panel">
          <h1 class="product-title">{{ product.name }}</h1>

          <p class="product-price-large">${{ product.price }}</p>

          <div class="product-meta-row">
            <span class="meta-label">Stock</span>
            <span class="meta-value">{{ product.stock }}</span>
          </div>

          <el-divider />

          <p class="product-desc">{{ product.description }}</p>

          <div class="action-row">
            <el-input-number
              v-model="quantity"
              :min="1"
              :max="product.stock"
            />
            <el-button
              type="primary"
              size="large"
              @click="buyNow"
              :disabled="!auth.isLoggedIn"
            >
              Buy Now
            </el-button>
            <el-button
              size="large"
              @click="chatSeller"
              :disabled="!auth.isLoggedIn"
              :loading="chatLoading"
            >
              Chat Seller
            </el-button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { getProductDetail } from '../api/product'
import { placeOrder } from '../api/order'
import { getOrCreateConversation } from '../api/chat'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const auth = useAuthStore()
const product = ref({})
const quantity = ref(1)
const chatLoading = ref(false)

onMounted(async () => {
  const res = await getProductDetail(route.params.id)
  product.value = res.data
})

async function buyNow() {
  try {
    const order = {
      items: [{ productId: product.value.id, quantity: quantity.value }],
      addressSnapshot: JSON.stringify({ address: 'Default address' })
    }
    await placeOrder(order)
    ElMessage.success('Order placed!')
    router.push('/orders')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Order failed')
  }
}

async function chatSeller() {
  chatLoading.value = true
  try {
    await getOrCreateConversation(Number(auth.user.id), product.value.sellerId)
    router.push({ path: `/chat/${product.value.sellerId}`, query: { peerName: product.value.sellerName || 'Seller' } })
  } catch (e) {
    ElMessage.error(e.response?.data?.message || e.message || 'Failed to start chat')
  } finally {
    chatLoading.value = false
  }
}
</script>

<style scoped>
/* ===== Page Layout ===== */
.detail-page {
  position: relative;
  min-height: 100vh;
}

/* ===== Decorative Background Accent ===== */
.detail-bg-accent {
  position: absolute;
  top: 0;
  right: 0;
  width: 420px;
  height: 420px;
  pointer-events: none;
  z-index: 0;
  background:
    radial-gradient(circle at center, rgba(123, 167, 224, 0.09) 0%, transparent 60%),
    radial-gradient(circle at 70% 30%, rgba(244, 195, 176, 0.07) 0%, transparent 55%);
}

/* ===== Top Bar ===== */
.detail-topbar {
  position: sticky;
  top: 12px;
  z-index: 100;
  display: flex;
  align-items: center;
  gap: 16px;
  margin: 0 20px;
  padding: 14px 24px;
  border-radius: var(--radius-xl);
}

.topbar-title {
  font-family: var(--font-display);
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ===== Main Layout ===== */
.detail-main {
  position: relative;
  z-index: 1;
  padding: 28px 28px 60px;
}

.detail-layout {
  display: flex;
  gap: 28px;
  align-items: flex-start;
}

/* ===== Image Frame ===== */
.image-frame {
  flex: 0 0 420px;
  max-width: 420px;
  padding: 20px;
}

.image-frame img {
  display: block;
  width: 100%;
  height: auto;
  border-radius: var(--radius);
  object-fit: cover;
}

/* ===== Info Panel ===== */
.info-panel {
  flex: 1;
  min-width: 0;
  padding: 32px 36px;
}

.product-title {
  font-family: var(--font-display);
  font-size: 30px;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 16px;
  line-height: 1.25;
  letter-spacing: -0.015em;
}

.product-price-large {
  font-family: var(--font-body);
  font-size: 32px;
  font-weight: 700;
  color: var(--color-accent);
  filter: saturate(1.3);
  margin: 0 0 16px;
}

.product-meta-row {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.meta-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-muted);
}

.meta-value {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
}

.product-desc {
  font-size: 15px;
  line-height: 1.7;
  color: var(--text-secondary);
  margin: 0 0 28px;
}

/* ===== Action Row ===== */
.action-row {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

/* ===== Responsive ===== */
@media (max-width: 860px) {
  .detail-layout {
    flex-direction: column;
  }

  .image-frame {
    flex: none;
    max-width: 100%;
    width: 100%;
  }

  .info-panel {
    padding: 24px 20px;
  }

  .product-title {
    font-size: 24px;
  }

  .product-price-large {
    font-size: 26px;
  }
}
</style>
