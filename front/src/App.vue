<template>
  <b-container fluid class='px-0'>
    <b-row no-gutters>
      <b-col cols='12'>
        <b-navbar toggleable="lg" type="dark" variant="info">
          <b-navbar-brand href="#">MyPWA 1.0.2</b-navbar-brand>

          <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

          <b-collapse id="nav-collapse" is-nav>
            <b-navbar-nav>
              <b-nav-item to='/'>Home</b-nav-item>
              <b-nav-item to='/messenger'  v-if="currentUser.email != 'guest'">Messenger</b-nav-item>
            </b-navbar-nav>


            <b-navbar-nav class="ml-auto">
              <template v-if="currentUser.email == 'guest'">
                <b-nav-item to='/login'>Login</b-nav-item>
                <b-nav-item to='/signup'>Sign Up</b-nav-item>
              </template>
              <template v-else>
                <b-nav-text>{{ currentUser.email }}</b-nav-text>
                <b-nav-item href='#' v-on:click.prevent="signOut">Logout</b-nav-item>
              </template>
            </b-navbar-nav>
          </b-collapse>
        </b-navbar>
        <router-view></router-view>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import serverOp from './server_operation';
import { mapState } from 'vuex';

export default {
  name: 'app',
  components: {
  },

  data: function() {
    return {
    }
  },
  computed: {
    ...mapState({
      currentUser: state => state.currentUser
    })
  },

  methods: {
    signOut: function(){
      serverOp.run('User::SignOut')
      .then(() => {
        this.$store.commit('logout')
        this.$router.push({ path: '/' })
      })
      .catch(errors => {
        console.log(errors);
      });
    }
  },

  mounted() {
    console.log('****************');
    console.log(process.env.VUE_APP_SERVER_URL)
    serverOp.run('User::FetchCurrent')
    .then(payload => {
      this.$store.commit('login', { email: payload.email, id: payload.id })
    })
    .catch(errors => {
      console.log('Cannot obtain current user:')
      console.log(errors)
    })

  }
}
</script>

<style>
</style>
