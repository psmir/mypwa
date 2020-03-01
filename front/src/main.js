import Vue from 'vue'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import App from './App.vue'
import ActionCableVue from 'actioncable-vue';
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import InfiniteLoading from 'vue-infinite-loading';

import routes from './routes'
import './registerServiceWorker'

const actioncableUrl = process.env.VUE_APP_ACTIONCABLE_URL;

Vue.config.productionTip = false
Vue.use(VueRouter)
Vue.use(Vuex)
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: actioncableUrl,
  connectImmediately: true
});

Vue.use(BootstrapVue);
Vue.use(InfiniteLoading, {
  system: {
    throttleLimit: 1000
  },
});

const router = new VueRouter({
  mode: 'history',
  routes: routes
});

const store = new Vuex.Store({
  state: {
    currentUser: {
      id: null,
      email: 'guest'
    }
  },
  mutations: {
    login (state, payload) {
      console.log(payload);
      state.currentUser.id = payload.id
      state.currentUser.email = payload.email
    },

    logout (state) {
      state.currentUser.id = null
      state.currentUser.email = 'guest'
    }
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
