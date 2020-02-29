<template>
  <b-row align-h='center'>
    <b-col cols='12' md='4'>
      <div class='p-3'>
        <h1>Sign Up</h1>
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

          <b-form-group>
            <b-form-input v-model='password_confirmation' id="password-confirmation" type="password" :state="passwordConfirmationState" placeholder='Password Confirmation'>
            </b-form-input>
            <b-form-invalid-feedback id="password-confirmation-feedback">
              {{ errors.password_confirmation }}
            </b-form-invalid-feedback>
          </b-form-group>

          <b-button type='submit' variant='primary'>Sign Up</b-button>
        </b-form>
      </div>
    </b-col>
  </b-row>
</template>

<script>
import serverOp from '../server_operation'

export default {
  name: 'SignUp',

  computed: {
    emailState() {
      return this.errors.email == null ? null : false
    },
    passwordState() {
      return this.errors.password == null ? null : false
    },
    passwordConfirmationState() {
      return this.errors.password_confirmation == null ? null : false
    }
  },

  data: function() {
    return {
      email:                 null,
      password:              null,
      password_confirmation: null,
      errors:                {}
    }
  },

  methods: {
    performLogin: function(){
      serverOp.run('User::SignUp', {
        email:                 this.email,
        password:              this.password,
        password_confirmation: this.password_confirmation
      })
      .then(payload => {
        console.log(payload)
        this.$store.commit('login', { email: this.email })
        this.$router.push({ path: '/' })
      })
      .catch(errors => {
        this.errors = errors;
      });
    }
  }
}
</script>
