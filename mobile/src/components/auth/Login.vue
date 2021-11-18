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
  methods: {
    handleLogin() {
      this.loading = true;

      this.$store.dispatch('auth/login', this.form).then(() => {
        //todo
        console.log("yes login in !");
      }).catch(() => {
        this.loading = false;
        console.log("no login in !");
      });
    }
  }
}
</script>

<style>

</style>