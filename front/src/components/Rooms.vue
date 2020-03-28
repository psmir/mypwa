<template>
  <b-card no-body header='Rooms' id='rooms'>
    <b-list-group flush>
      <b-list-group-item>
        <router-link to="/messenger" class='ml-1'># General</router-link>
        <b-badge variant="secondary" class='ml-1' v-if="messageCounter['general'] > 0">
          {{messageCounter['general']}}
        </b-badge>
      </b-list-group-item>
      <b-list-group-item v-for="user in users" v-bind:key="user.id">
        <span :class="user.online ? 'online' : 'offline'"></span>
        <router-link :to="{name: 'messenger', params: { current_room: user.id } }">
          {{ user.email }}
        </router-link>
        <b-badge variant="warning" v-if="messageCounter[user.id] > 0">
          {{messageCounter[user.id]}}
        </b-badge>
      </b-list-group-item>
    </b-list-group>
  </b-card>
</template>

<script>
import serverOp from '../server_operation'
import { mapState } from 'vuex';

export default {
  name: 'Rooms',
  data: function() {
    return {
      users: []
    }
  },

   computed: {
    ...mapState({
      messageCounter: state => state.messageCounter
    })
  },

  methods: {
    getUsers: function(){
      serverOp.run('User::List', {})
      .then(payload => {
        this.users = payload
      })
    },
  },

  channels: {
    UserListChannel: {
      connected() {
        console.log('I am connected to UserListChannel.');
      },
      received(data) {
        this.users = data.users
      }
    }
  },

  mounted() {
    this.$cable.subscribe({ channel: 'UserListChannel' });
    this.getUsers();
  }
}
</script>

<style scoped>
  #rooms .list-group-item a {
    text-decoration: none;
  }
  .router-link-exact-active {
    font-weight: 600;
  }
  .offline:before {
    content: ' \25CF';
    color: gray;
  }
  .online:before {
    content: ' \25CF';
    color: green;
  }
</style>
