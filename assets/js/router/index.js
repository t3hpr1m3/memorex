import Vue from 'vue';
import Router from 'vue-router'
import Dashboard from '../pages/dashboard'

Vue.use(Router);

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: Dashboard
    }
  ]
});

export default router;
