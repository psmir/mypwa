<template>
  <ul id='message_list' ref='message_list'>
    <li><infinite-loading direction="top" @infinite="infiniteHandler"></infinite-loading></li>
    <li v-for="msg in messages" v-bind:key="msg.id">
      {{ msg.author }} : {{ msg.body }}
    </li>
  </ul>

</template>

<script>
import serverOp from '../server_operation'

export default {
  name: 'MessageList',
  props: ['user_id'],
  watch: {
    user_id: function(newVal, oldVal) { // watch it
      console.log('Prop changed in MessageList: ', newVal, ' | was: ', oldVal);
      this.messages = [];
      this.page = 2;
      this.getLatestMessages();
      setTimeout(() => this.scrollToBottom(), 500);
    }
  },
  data: function() {
    return {
      messages: [],
      page: 2
    }
  },

  methods: {
    getLatestMessages: function(){
      serverOp.run('Message::Latest', {
        user_id: this.user_id
      })
      .then(payload => {
        this.messages = payload
      })
    },

    scrollToBottom: function(){
      var container = this.$refs.message_list;
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
        console.log('Data received');
        console.log(data);
        if(this.user_id == null) {
          this.messages.push(data.message);
          setTimeout(() => this.scrollToBottom(), 500);
        }
      }
    },
    PrivateChatChannel: {
      connected() {
        console.log('I am connected to PrivateChatChannel.');
      },

      received(data) {
        console.log('Data received to private channel');
        console.log(data);
        if(this.user_id == data.message.user_id || this.user_id == data.message.addressee_id) {
          this.messages.push(data.message);
          setTimeout(() => this.scrollToBottom(), 500);
        }
      }

    }
  },

  mounted() {
    console.log(`MessageList mounted. user_id: ${this.user_id}`);

    this.$cable.subscribe({ channel: 'ChatChannel' });
    this.$cable.subscribe({ channel: 'PrivateChatChannel' });
    this.getLatestMessages();
    setTimeout(() => this.scrollToBottom(), 1000)
  }
}
</script>

<style scoped>
  #message_list {
    list-style-type: none;
    padding: 0;
    height: 300px;
    overflow-y: scroll;
  }
</style>
