<template>
  <b-row>
    <b-col cols='12' md='4'>
      <b-card no-body header='Channels' id='channels'>
        <b-list-group flush>
          <b-list-group-item>
            <router-link to="/messenger" class='ml-1'># General</router-link>
          </b-list-group-item>
        </b-list-group>
        <UserList />
      </b-card>
    </b-col>
    <b-col cols='12' md='8'>
      <div class='p-3'>
        <MessageList v-bind:user_id='user_id' />
        <ChatForm v-bind:user_id='user_id' />
      </div>
    </b-col>
  </b-row>
</template>

<script>
import UserList from './UserList'
import MessageList from './MessageList'
import ChatForm from './ChatForm'

export default {
  name: 'Messenger',

  components: {
    UserList,
    MessageList,
    ChatForm
  },

  props: ['user_id'],

  mounted() {
    console.log("Mounting Messenger!!!");
  }
}
</script>
<style>
  #channels .list-group-item a {
    text-decoration: none;
  }
  .router-link-exact-active {
    font-weight: 600;
  }
</style>
