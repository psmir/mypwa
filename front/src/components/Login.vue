<template>
  <b-row align-h='center'>
    <b-col cols='12' md='4'>
      <div class='p-3'>
        <h1>Login</h1>
        <b-alert :show="errors.base != null" variant="danger">
          {{ errors.base }}
        </b-alert>
        <b-form v-on:submit.prevent="performLogin">
          <b-form-group>
            <b-form-input v-model="email" id="email" type="email" :state="emailState" placeholder='Email'></b-form-input>
            <b-form-invalid-feedback id="email-feedback">
              {{ errors.email }}
            </b-form-invalid-feedback>
          </b-form-group>

          <b-form-group>
            <b-form-input v-model='password' id="password" type="password" :state="passwordState" placeholder='Password'></b-form-input>
            <b-form-invalid-feedback id="password-feedback">
              {{ errors.password }}
            </b-form-invalid-feedback>
          </b-form-group>

          <b-button type='submit' variant='primary'>Log In</b-button>
        </b-form>
      </div>
    </b-col>
  </b-row>
</template>

<script>
import serverOp from '../server_operation'

export default {
  name: 'Login',

  computed: {
    emailState() {
      return this.errors.email == null ? null : false
    },
    passwordState() {
      return this.errors.password == null ? null : false
    }
  },
  data: function() {
    return {
      email: null,
      password: null,
      errors: {}
    }
  },

  methods: {
    performLogin: function(){
      serverOp.run('User::SignIn', {
        email: this.email,
        password: this.password
      }).then(payload => {
        console.log(payload)
        this.$store.commit('login', { email: this.email, id: payload.id })
        this.$router.push({ path: '/' })
      })
      .catch(errors => {
        this.errors = errors;
      });
    }
  }
}
</script>
