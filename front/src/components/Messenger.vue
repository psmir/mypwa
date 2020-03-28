<template>
  <b-row>
    <b-col cols='12' md='4'>
      <Rooms />
    </b-col>
    <b-col cols='12' md='8'>
      <div class='p-3'>
        <MessageList v-bind:current_room='current_room' />
        <ChatForm v-bind:current_room='current_room' />
      </div>
    </b-col>
  </b-row>
</template>

<script>
import Rooms from './Rooms'
import MessageList from './MessageList'
import ChatForm from './ChatForm'

export default {
  name: 'Messenger',

  components: {
    Rooms,
    MessageList,
    ChatForm
  },

  props: ['current_room'],

  mounted() {
    console.log("Mounting Messenger!!!");
  }
}
</script>
