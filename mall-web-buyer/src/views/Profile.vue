<template>
  <div class="profile-page">
    <header class="page-header glass-panel">
      <el-button @click="$router.push('/')">Back</el-button>
      <h1 class="page-title">My Account</h1>
    </header>

    <div class="profile-content">
      <!-- Profile Info -->
      <section class="section-card glass-card anim-fade-up">
        <div class="section-head">
          <h2 class="section-title">Personal Info</h2>
          <el-button v-if="!editingInfo" text type="primary" @click="startEditInfo">Edit</el-button>
        </div>
        <el-form v-if="editingInfo" :model="infoForm" label-position="top" class="section-form">
          <el-form-item label="Username">
            <el-input v-model="infoForm.username" placeholder="Username" />
          </el-form-item>
          <el-form-item label="Phone">
            <el-input v-model="infoForm.phone" placeholder="Phone number" />
          </el-form-item>
          <div class="form-actions">
            <el-button @click="editingInfo = false">Cancel</el-button>
            <el-button type="primary" :loading="infoSaving" @click="saveInfo">Save</el-button>
          </div>
        </el-form>
        <div v-else class="info-display">
          <div class="info-row"><span class="info-label">Username</span><span class="info-value">{{ profile.username }}</span></div>
          <div class="info-row"><span class="info-label">Role</span><el-tag>{{ profile.role }}</el-tag></div>
          <div class="info-row"><span class="info-label">Phone</span><span class="info-value">{{ profile.phone || '—' }}</span></div>
        </div>
      </section>

      <!-- Change Password -->
      <section class="section-card glass-card anim-fade-up" style="animation-delay:0.08s">
        <h2 class="section-title">Change Password</h2>
        <el-form :model="pwdForm" label-position="top" class="section-form">
          <el-form-item label="Current Password">
            <el-input v-model="pwdForm.oldPassword" type="password" show-password placeholder="Current password" />
          </el-form-item>
          <el-form-item label="New Password">
            <el-input v-model="pwdForm.newPassword" type="password" show-password placeholder="New password (min 6 chars)" />
          </el-form-item>
          <el-button type="primary" :loading="pwdSaving" @click="savePassword">Update Password</el-button>
        </el-form>
      </section>

      <!-- Addresses -->
      <section class="section-card glass-card anim-fade-up" style="animation-delay:0.16s">
        <div class="section-head">
          <h2 class="section-title">Addresses</h2>
          <el-button text type="primary" @click="showAddrDialog(null)">+ Add</el-button>
        </div>
        <div v-if="addresses.length === 0" class="empty-hint">No addresses yet</div>
        <div v-for="addr in addresses" :key="addr.id" class="addr-item glass-subtle">
          <div class="addr-body">
            <div class="addr-top">
              <strong>{{ addr.receiverName }}</strong>
              <span class="addr-phone">{{ addr.phone }}</span>
              <el-tag v-if="addr.isDefault" size="small" type="primary">Default</el-tag>
            </div>
            <p class="addr-text">{{ addr.province }} {{ addr.city }} {{ addr.district }} {{ addr.detail }}</p>
          </div>
          <div class="addr-actions">
            <el-button text type="primary" size="small" @click="showAddrDialog(addr)">Edit</el-button>
            <el-button text type="danger" size="small" @click="removeAddr(addr.id)">Delete</el-button>
          </div>
        </div>
      </section>

      <!-- Logout -->
      <div class="logout-section anim-fade-up" style="animation-delay:0.24s">
        <el-button type="danger" size="large" class="logout-btn" @click="handleLogout">Log Out</el-button>
      </div>
    </div>

    <!-- Address Dialog -->
    <el-dialog v-model="addrDialogVisible" :title="addrEditing ? 'Edit Address' : 'Add Address'" width="480px">
      <el-form :model="addrForm" label-position="top">
        <el-form-item label="Receiver Name">
          <el-input v-model="addrForm.receiverName" placeholder="Full name" />
        </el-form-item>
        <el-form-item label="Phone">
          <el-input v-model="addrForm.phone" placeholder="Phone number" />
        </el-form-item>
        <el-row :gutter="12">
          <el-col :span="8"><el-form-item label="Province"><el-input v-model="addrForm.province" placeholder="Province" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="City"><el-input v-model="addrForm.city" placeholder="City" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="District"><el-input v-model="addrForm.district" placeholder="District" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="Detail Address">
          <el-input v-model="addrForm.detail" placeholder="Street, building, etc." />
        </el-form-item>
        <el-form-item>
          <el-checkbox v-model="addrForm.isDefault">Set as default</el-checkbox>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="addrDialogVisible = false">Cancel</el-button>
        <el-button type="primary" :loading="addrSaving" @click="saveAddr">Save</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getProfile, updateProfile, changePassword, getAddresses, addAddress, updateAddress, deleteAddress } from '../api/user'
import { ElMessage, ElMessageBox } from 'element-plus'

const auth = useAuthStore()
const profile = ref({})
const addresses = ref([])

// ---- Info ----
const editingInfo = ref(false)
const infoSaving = ref(false)
const infoForm = ref({ username: '', phone: '' })

function startEditInfo() {
  infoForm.value = { username: profile.value.username, phone: profile.value.phone || '' }
  editingInfo.value = true
}

async function saveInfo() {
  infoSaving.value = true
  try {
    await updateProfile(infoForm.value)
    profile.value.username = infoForm.value.username
    profile.value.phone = infoForm.value.phone
    editingInfo.value = false
    ElMessage.success('Profile updated')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Failed to update')
  } finally { infoSaving.value = false }
}

// ---- Password ----
const pwdSaving = ref(false)
const pwdForm = ref({ oldPassword: '', newPassword: '' })

async function savePassword() {
  if (!pwdForm.value.oldPassword || !pwdForm.value.newPassword) {
    ElMessage.warning('Please fill both fields')
    return
  }
  if (pwdForm.value.newPassword.length < 6) {
    ElMessage.warning('New password must be at least 6 characters')
    return
  }
  pwdSaving.value = true
  try {
    await changePassword(pwdForm.value.oldPassword, pwdForm.value.newPassword)
    ElMessage.success('Password changed')
    pwdForm.value = { oldPassword: '', newPassword: '' }
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Failed to change password')
  } finally { pwdSaving.value = false }
}

// ---- Addresses ----
const addrDialogVisible = ref(false)
const addrEditing = ref(null)
const addrSaving = ref(false)
const addrForm = ref({ receiverName: '', phone: '', province: '', city: '', district: '', detail: '', isDefault: false })

function showAddrDialog(addr) {
  if (addr) {
    addrEditing.value = addr
    addrForm.value = { ...addr }
  } else {
    addrEditing.value = null
    addrForm.value = { receiverName: '', phone: '', province: '', city: '', district: '', detail: '', isDefault: false }
  }
  addrDialogVisible.value = true
}

async function saveAddr() {
  addrSaving.value = true
  try {
    if (addrEditing.value) {
      await updateAddress(addrEditing.value.id, addrForm.value)
    } else {
      await addAddress(addrForm.value)
    }
    addrDialogVisible.value = false
    await loadAddresses()
    ElMessage.success(addrEditing.value ? 'Address updated' : 'Address added')
  } catch (e) {
    ElMessage.error(e.response?.data?.message || 'Failed to save address')
  } finally { addrSaving.value = false }
}

async function removeAddr(id) {
  try {
    await ElMessageBox.confirm('Delete this address?', 'Confirm', { type: 'warning' })
    await deleteAddress(id)
    await loadAddresses()
    ElMessage.success('Address deleted')
  } catch { /* cancelled */ }
}

async function loadAddresses() {
  const res = await getAddresses()
  addresses.value = res.data
}

function handleLogout() {
  auth.logout()
}

onMounted(async () => {
  const [meRes] = await Promise.all([getProfile(), loadAddresses()])
  profile.value = meRes.data
})
</script>

<style scoped>
.profile-page {
  max-width: 640px;
  margin: 0 auto;
  padding: 24px 20px 60px;
  min-height: 100vh;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 18px 28px;
  margin-bottom: 24px;
}

.page-title {
  font-family: var(--font-display);
  font-size: 26px;
  font-weight: 700;
  margin: 0;
  color: var(--text-primary);
  letter-spacing: -0.015em;
}

.profile-content {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.section-card {
  padding: 24px 28px;
}

.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.section-title {
  font-family: var(--font-display);
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0 0 16px;
}

.section-head .section-title {
  margin-bottom: 0;
}

.section-form {
  margin-top: 4px;
}

.form-actions {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}

.info-display {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.info-label {
  width: 90px;
  font-size: 14px;
  color: var(--text-secondary);
  font-weight: 500;
  flex-shrink: 0;
}

.info-value {
  font-size: 15px;
  color: var(--text-primary);
  font-weight: 500;
}

.empty-hint {
  color: var(--text-muted);
  font-size: 14px;
  padding: 8px 0;
}

.addr-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 16px;
  margin-bottom: 10px;
  border-radius: var(--radius);
}

.addr-body {
  flex: 1;
  min-width: 0;
}

.addr-top {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 4px;
  flex-wrap: wrap;
}

.addr-top strong {
  font-size: 15px;
  color: var(--text-primary);
}

.addr-phone {
  font-size: 13px;
  color: var(--text-secondary);
}

.addr-text {
  margin: 0;
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.5;
}

.addr-actions {
  display: flex;
  gap: 4px;
  flex-shrink: 0;
  margin-left: 12px;
}

.logout-section {
  display: flex;
  justify-content: center;
  padding-top: 12px;
}

.logout-btn {
  min-width: 200px;
}
</style>
