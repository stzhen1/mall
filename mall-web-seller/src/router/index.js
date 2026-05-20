import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const routes = [
  { path: '/login', name: 'Login', component: () => import('../views/Login.vue') },
  { path: '/register', name: 'Register', component: () => import('../views/Register.vue') },
  { path: '/', name: 'Dashboard', component: () => import('../views/Dashboard.vue'), meta: { auth: true } },
  { path: '/products', name: 'Products', component: () => import('../views/Products.vue'), meta: { auth: true } },
  { path: '/products/add', name: 'ProductForm', component: () => import('../views/ProductForm.vue'), meta: { auth: true } },
  { path: '/products/:id/edit', name: 'ProductEdit', component: () => import('../views/ProductForm.vue'), meta: { auth: true } },
  { path: '/orders', name: 'Orders', component: () => import('../views/Orders.vue'), meta: { auth: true } },
  { path: '/chat', name: 'Chat', component: () => import('../views/Chat.vue'), meta: { auth: true } },
  { path: '/chat/:userId', name: 'ChatWindow', component: () => import('../views/ChatWindow.vue'), meta: { auth: true } }
]

const router = createRouter({ history: createWebHistory(), routes })

router.beforeEach((to, from, next) => {
  const auth = useAuthStore()
  if (to.meta.auth && !auth.isLoggedIn) next('/login')
  else next()
})

export default router
