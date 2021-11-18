<template>
  <div style="width: 90vw; margin: 0 auto">
    <div class="card">
      <div class="container">
      <form>
        <div>
          <label for="email">Email</label>
          <input type="email" name="email" id="email" v-model="form.email" required />
        </div>
        <div>
          <label for="password">Password</label>
          <input type="password" name="password" id="password" v-model="form.password" required />
        </div>
        <div>
          <button @click.prevent="handleLogin()">Login</button>
        </div>
      </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        email: '',
        password: ''
      },
      loading: false
    }
  },
  computed: {
    currentUser() {
      return this.$store.state.auth.user;
    },
  },
  methods: {
    handleLogin() {
      this.$store.dispatch('auth/login', this.form).then(() => {
        this.$toast.success(`Hello ${this.currentUser.user.username}!`);
      }).catch((error) => {
        this.$toast.error(error);
      });
    }
  }
}
</script>

<style scoped>
.card {
  margin-top: 30vh;
  margin-left: 15vw;
  margin-right: 15vw;
  padding: 30px;
}
</style>