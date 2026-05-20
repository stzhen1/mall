<template>
  <div class="form-page">
    <!-- Glass Header -->
    <div class="page-header glass-panel">
      <div class="header-left">
        <el-button @click="$router.push('/products')">Back</el-button>
        <h1 class="page-title">{{ isEdit ? 'Edit Product' : 'Add Product' }}</h1>
      </div>
    </div>

    <!-- Form Panel -->
    <div class="form-panel glass-panel anim-fade-up">
      <el-form :model="form" label-position="top">
        <el-form-item label="Name">
          <el-input v-model="form.name" placeholder="Product name" />
        </el-form-item>
        <el-form-item label="Description">
          <el-input v-model="form.description" type="textarea" :rows="4" placeholder="Describe your product" />
        </el-form-item>
        <el-form-item label="Price">
          <el-input-number v-model="form.price" :min="0" :precision="2" :controls="true" style="width:100%;" />
        </el-form-item>
        <el-form-item label="Stock">
          <el-input-number v-model="form.stock" :min="0" :controls="true" style="width:100%;" />
        </el-form-item>
        <el-form-item label="Category">
          <el-select v-model="form.categoryId" placeholder="Select category" style="width:100%;">
            <el-option v-for="c in flatCategories" :key="c.id" :label="c.name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="Main Image URL">
          <el-input v-model="form.mainImage" placeholder="https://example.com/image.jpg" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" @click="save" :loading="saving" style="width:100%;">
            {{ isEdit ? 'Update Product' : 'Create Product' }}
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { createProduct, updateProduct, getProductDetail, getCategories } from '../api/product'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const isEdit = computed(() => !!route.params.id)
const saving = ref(false)
const form = ref({ name: '', description: '', price: 0, stock: 0, categoryId: null, mainImage: '' })
const flatCategories = ref([])

function flatten(cats, prefix = '') {
  for (const c of cats) {
    flatCategories.value.push({ id: c.id, name: prefix + c.name })
    if (c.children) flatten(c.children, prefix + '-- ')
  }
}

onMounted(async () => {
  const res = await getCategories()
  flatten(res.data)
  if (isEdit.value) {
    const prod = await getProductDetail(route.params.id)
    Object.assign(form.value, prod.data)
  }
})

async function save() {
  saving.value = true
  try {
    if (isEdit.value) await updateProduct(route.params.id, form.value)
    else await createProduct(form.value)
    ElMessage.success(isEdit.value ? 'Updated' : 'Created')
    router.push('/products')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Failed')
  } finally { saving.value = false }
}
</script>

<style scoped>
.form-page {
  max-width: 640px;
  margin: 0 auto;
  padding: 24px 20px 40px;
}

/* --- Header --- */
.page-header {
  padding: 20px 28px;
  margin-bottom: 24px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.page-title {
  margin: 0;
  font-family: var(--font-display);
  font-size: 26px;
  font-weight: 600;
  color: var(--text-primary);
  letter-spacing: -0.01em;
}

/* --- Form Panel --- */
.form-panel {
  padding: 32px 28px;
}
</style>
