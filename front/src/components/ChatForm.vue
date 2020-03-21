<template>
  <form v-on:submit.prevent="sendMessage">
    <b-form-textarea v-model='body' id='body' placeholder='Enter your message' rows='3' max-rows='6' :state="bodyState">
    </b-form-textarea>
    <b-form-invalid-feedback id="body-feedback">
      {{ errors.body }}
    </b-form-invalid-feedback>
    <br />
    <b-button type='submit' variant='primary'>Send</b-button>
  </form>
</template>

<script>
import serverOp from '../server_operation'

export default {
  name: 'ChatForm',
  props: ['user_id'],

  data: function() {
    return {
      body: null,
      errors: {}
    }
  },

  computed: {
    bodyState() {
      return this.errors.body == null ? null : false
    },
  },

  watch: {
    user_id: function() {
      this.body = null;
      this.errors = {};
    }
  },

  methods: {
    sendMessage: function(){
      serverOp.run('User::Say', {
        body: this.body,
        addressee_id: this.user_id
      })
      .then(() => {
        this.body = null
      })
      .catch(errors => {
        this.errors = errors;
      });
    },
  },
}
</script>
