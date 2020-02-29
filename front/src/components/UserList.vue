<template>
  <b-list-group>
    <b-list-group-item v-for="user in users" v-bind:key="user.id">
      <span :class="user.online ? 'online' : 'offline'"></span> {{ user.email }}
    </b-list-group-item>
  </b-list-group>
</template>

<script>
import serverOp from '../server_operation'

export default {
  name: 'UserList',
  data: function() {
    return {
      users: []
    }
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
  .offline:before {
    content: ' \25CF';
    color: gray;
  }
  .online:before {
    content: ' \25CF';
    color: green;
  }
</style>
