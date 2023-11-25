import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Proposals from '../views/Proposals.vue';
import Treasury from '../views/Treasury.vue';
import Roles from '../views/Roles.vue';
import Whitepaper from '../views/Whitepaper.vue';
import Gallery from '../views/Gallery.vue';
import Wallet from '../views/Wallet.vue';
import NotFound from '../views/NotFound.vue';
import { useAuthStore } from '../store/auth';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/whitepaper',
    name: 'Whitepaper',
    component: Whitepaper,
  },
  {
    path: '/proposals',
    name: 'Proposals',
    component: Proposals,
  },
  {
    path: '/treasury',
    name: 'Treasury',
    component: Treasury,
  },
  {
    path: '/roles',
    name: 'Roles',
    component: Roles,
  },
  {
    path: '/gallery',
    name: 'Gallery',
    component: Gallery,
  },
  {
    path: '/account',
    beforeEnter: async (to, from, next) => {
      const authStore = useAuthStore();

      if (!authStore.isReady) {
        await authStore.init();
      }

      if (!authStore.isAuthenticated) {
        next('/');
      } else {
        next();
      }
    },
    children: [
      {
        path: '/account/wallet',
        name: 'Wallet',
        component: Wallet,
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*', // Catch-all route
    name: 'NotFound',
    component: NotFound,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    // always scroll to top
    return { top: 0 };
  },
})

export default router;