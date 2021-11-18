<template>
  <div style="width: 90vw; margin: 0 auto">
    <div class="card">
      <div class="container">
        <form>
          <div>
            <label for="username">Username</label>
            <input type="text" name="username" id="username" v-model="form.username" required>
          </div>
          <div>
            <label for="email">Email</label>
            <input
              type="email"
              name="email"
              id="email"
              v-model="form.email"
              required
            />
          </div>
          <div>
            <label for="password">Password</label>
            <input
              type="password"
              name="password"
              id="password"
              v-model="form.password"
              required
            />
          </div>
          <div>
            <button @click.prevent="handleRegister()">Login</button>
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
        username: '',
        email: '',
        password: '',
      }
    }
  },
  methods: {
    handleRegister() {
      this.$store.dispatch('auth/register', this.form).then(() => {
        this.$toast.success(`Welcome ${this.username}!`);
      }).catch(error => {
          this.$toast.error(error);
      });
    }
  }
};
</script>

<style>
</style>