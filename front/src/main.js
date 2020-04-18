import Vue from 'vue'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import App from './App.vue'
import { LayoutPlugin, CardPlugin, AlertPlugin, CollapsePlugin, FormPlugin, FormGroupPlugin, NavbarPlugin, NavPlugin, JumbotronPlugin, ListGroupPlugin,
  ButtonPlugin, FormTextareaPlugin, FormInputPlugin, BadgePlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import routes from './routes'
import './registerServiceWorker'

Vue.config.productionTip = false
Vue.use(VueRouter)
Vue.use(Vuex)

Vue.use(LayoutPlugin);
Vue.use(CardPlugin);
Vue.use(AlertPlugin);
Vue.use(CollapsePlugin);
Vue.use(FormPlugin);
Vue.use(FormGroupPlugin);
Vue.use(NavbarPlugin);
Vue.use(NavPlugin);
Vue.use(JumbotronPlugin);
Vue.use(ListGroupPlugin);
Vue.use(ButtonPlugin);
Vue.use(FormTextareaPlugin);
Vue.use(FormInputPlugin);
Vue.use(BadgePlugin);

const router = new VueRouter({
  mode: 'history',
  routes: routes
});

const store = new Vuex.Store({
  state: {
    currentUser: {
      id: null,
      email: 'guest'
    },

    messageCounter: {
    },
  },
  mutations: {
    login(state, payload) {
      console.log(payload);
      state.currentUser.id = payload.id
      state.currentUser.email = payload.email
    },

    logout(state) {
      state.currentUser.id = null
      state.currentUser.email = 'guest'
    },

    messageReceived (state, room) {
      if(state.messageCounter[room] == null){
         Vue.set(state.messageCounter, room, 0);
      }
      state.messageCounter[room] = state.messageCounter[room] + 1;
    },

    resetMessageCounter(state, room) {
      Vue.set(state.messageCounter, room, 0);
    }
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
