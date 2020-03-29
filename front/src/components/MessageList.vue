<template>
  <div>
    <ul id='message_list' ref='message_list'>
      <li><infinite-loading direction="top" @infinite="infiniteHandler"></infinite-loading></li>
      <li v-for="msg in messages" v-bind:key="msg.id">
        {{ msg.author }} : {{ msg.body }}
      </li>
    </ul>
    <audio ref='notification_player' :src="require('../assets/plucky.mp3')"></audio>
  </div>
</template>

<script>
import serverOp from '../server_operation'
import { mapState } from 'vuex';

export default {
  name: 'MessageList',
  props: ['current_room'],
  watch: {
    current_room: function(newVal, oldVal) { // watch it
      console.log('Prop changed in MessageList: ', newVal, ' | was: ', oldVal);
      this.messages = [];
      this.page = 2;
      this.$store.commit('resetMessageCounter', newVal || 'general');
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

  computed: {
    ...mapState({
      currentUser: state => state.currentUser
    })
  },

  methods: {
    getLatestMessages: function(){
      serverOp.run('Message::Latest', {
        user_id: this.current_room
      })
      .then(payload => {
        this.messages = payload
      })
    },

    scrollToBottom: function(){
      var container = this.$refs.message_list;
      container.scrollTop = container.scrollHeight;
    },

    playSound: function(){
      var player = this.$refs.notification_player;
      player.currentTime = 0;
      player.play();
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
        if(this.current_room == null) {
          this.messages.push(data.message);
          setTimeout(() => this.scrollToBottom(), 500);
        }

        if (this.currentUser.id != data.message.user_id && this.current_room != null) {
          this.$store.commit('messageReceived', 'general');
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
        if(this.current_room == data.message.user_id || this.current_room == data.message.addressee_id) {
          this.messages.push(data.message);
          setTimeout(() => this.scrollToBottom(), 500);
        }
        console.log(`Current user id: ${this.currentUser.id}. Message user_id: ${data.message.user_id}`);
        if (this.currentUser.id != data.message.user_id && this.current_room != data.message.user_id) {
          this.$store.commit('messageReceived', data.message.user_id);
          this.playSound();
        }
      }

    }
  },

  mounted() {
    console.log(`MessageList mounted. current_room: ${this.current_room}`);

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
