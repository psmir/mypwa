<template>
  <b-row>
    <b-col cols='12' md='4'>
      <UserList />
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
