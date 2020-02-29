<template>
  <b-row>
    <b-col cols='12' md='4'>
      <UserList />
    </b-col>
    <b-col cols='12' md='8'>
      <div class='p-3'>
        <ul id='messages_list'>
          <li><infinite-loading direction="top" @infinite="infiniteHandler"></infinite-loading></li>
          <li v-for="msg in messages" v-bind:key="msg.id">
            {{ msg.author }} : {{ msg.body }}
          </li>
        </ul>
        <form v-on:submit.prevent="sendMessage">
          <b-form-textarea v-model='body' id='message_textarea' placeholder='Enter your message' rows='3' max-rows='6'></b-form-textarea>
          <br />
          <b-button type='submit' variant='primary'>Send</b-button>
        </form>
      </div>
    </b-col>
  </b-row>
</template>

<script>
import serverOp from '../server_operation'
import UserList from './UserList'

export default {
  name: 'Messenger',
  components: {
    UserList
  },
  data: function() {
    return {
      body: null,
      messages: [],
      page: 2
    }
  },

  methods: {
    sendMessage: function(){
      serverOp.run('User::Say', {
        body: this.body
      }).then(() => {
        this.body = null
      })
    },

    getLatestMessages: function(){
      serverOp.run('Message::Latest', {})
      .then(payload => {
        this.messages = payload
      })
    },

    scrollToBottom: function(){
      var container = this.$el.querySelector("#messages_list");
      container.scrollTop = container.scrollHeight;
    },

    infiniteHandler($state) {
      serverOp.run('Message::Latest', { page: this.page })
      .then(payload => {
        if(payload.length) {
          this.page += 1;
          this.messages.unshift(...payload);
          $state.loaded();
        } else {
          $state.complete();
        }
      })
    }
  },

  channels: {
    ChatChannel: {
      connected() {
        console.log('I am connected to ChatChannel.');
      },

      received(data) {
        this.messages.push(data.message);
        setTimeout(() => this.scrollToBottom(), 500);
      }
    },
  },

  mounted() {
    this.$cable.subscribe({ channel: 'ChatChannel' });
    this.getLatestMessages();
  }
}
</script>

<style scoped>
  #messages_list {
    list-style-type: none;
    padding: 0;
    height: 300px;
    overflow-y: scroll;
  }
</style>
