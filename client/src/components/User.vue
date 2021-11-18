<template>
  <div style="width:90vw; margin: 0 auto">
    <div class="card">
      <div class="container">
        <!-- TEMPLATE USERS -->
        <template id="template_index" v-if="current_template === 'template_index'">
          <h2>User</h2>
          <div v-if="users">
            <span v-for="user in users" v-bind:key="user.id" style="margin-left: 0.25rem;">
              <UserChip :user="user" :withOption="true" @changeCurrentTemplate="goToTemplate($event)"></UserChip>
            </span>
          </div>
          <div v-else>
            No user
          </div>
          <hr style="margin-top: 5vh; margin-bottom: 5vh;">
          <cite style="margin-right: 5vh">Not in this list above?</cite>
          <button class="info" @click.prevent="goToTemplate({template: 'template_create', user: null})">Add me!</button>
        </template>
        <!-- TEMPLATE CREATE/UPDATE USER -->
        <template id="template_create_or_update_user" v-if="current_template === 'template_create' || current_template === 'template_update'">
          <h1 v-if="current_template === 'template_create'">Add User</h1>
          <h1 v-if="current_template === 'template_update'">Update User {{ selected_user.username }}</h1>
          <form>
            <div>
              <label for="username">Username</label>
              <input type="text" name="username" id="username" v-model="form.username" required />
            </div>
            <div>
              <label for="email">Email</label>
              <input type="text" name="email" id="email" v-model="form.email" required />
            </div>
            <div v-if="current_template === 'template_update'">
              <label for="password">Password</label>
              <input type="password" name="password" id="password" v-model="form.password" required />
            </div>
            <div>
              <label for="role">Role</label>
              <select name="role" id="role" v-model="form.role" required>
                <option value="employee">Employee</option>
                <option :selected="form.role === 'manager'" value="manager">Manager</option>
                <option value="generalmanager">General Manager</option>
                <option value="admin">Admin</option>
              </select>
            </div>
            <div>
              <button @click.prevent="goToTemplate({template: 'template_index', user: null})">Back</button>
              <button class="success" v-if="current_template === 'template_create'" @click.prevent="handleRegister()">Done</button>
              <button class="success" v-if="current_template === 'template_update'" @click.prevent="updateUser(selected_user.id)">Done</button>
            </div>
          </form>
        </template>
        <!-- TEMPLATE DELETE USER -->
        <template id="template_delete" v-if="current_template === 'template_delete'">
          <h1>Delete User {{ selected_user.username }}</h1>
          <p>Please retype the username {{ selected_user.username }} of user for confirm deletion</p>
          <form action="" method="post">
            <div>
              <label for="username">Username</label>
              <input type="text" name="username" id="username" v-model="form.username" required />
            </div>
            <div>
              <button @click.prevent="goToTemplate({template: 'template_index', user: null})">Back</button>
              <button class="danger" :disabled="!!form.username == '' || form.username != selected_user.username" @click.prevent="deleteUser(selected_user.id)">Delete</button>
            </div>
          </form>
        </template>
      </div>
    </div>      
  </div>
</template>

<script>
import UserChip from './base/UserChip.vue';
import UserService from '../services/user.service';

export default {
  name: 'User',
  components: {
    UserChip
  },  
  data() {
    return {
      current_template: 'template_index', // template by default
      selected_user: null,
      users: [],
      form: {
        username: '',
        email: '',
        password: '',
        role: ''
      },
    };
  },
  mounted() {
    this.refreshUsers();
  },
  methods: {
    resetFormState() {
      this.form.username = '';
      this.form.email = '';
      this.form.password = '';
      this.form.role = '';
    },
    createUser () {
      return UserService.create(this.$store.state.auth.user.token, this.form)
        .then(response => {
          console.log(response);
          this.resetFormState();
          this.refreshUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          this.$toast.error(error);
        });
    },
    handleRegister() {
      if (this.form.password === '') {
        this.form.password = this.generateRandomPassword();
      }
      this.$store.dispatch('auth/register', this.form).then(() => {
          alert('Your random password is: "' + this.form.password + '" Please change it after login');
          this.resetFormState();
          this.refreshUsers();
          this.goToTemplate({template: 'template_index', user: null});
      }).catch(error => {
          this.$toast.error(error);
      });
    },
    updateUser (id) {
      return UserService.update(this.$store.state.auth.user.token, id, this.form)
        .then(() => {
          this.resetFormState();
          this.refreshUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          this.$toast.error(error);
        });
    },
    getUser(id) {
      return UserService.findOne(this.$store.state.auth.user.token, id)
        .then(response => {
          console.log(response);
          this.form.username = response.data.data.username;
          this.form.email = response.data.data.email;
          this.form.role = response.data.data.role;
        })
        .catch(error => {
          this.$toast.error(error);
        });
    },
    getUsers () {
      return UserService.findAll(this.$store.state.auth.user.token)
        .then(response => {
          console.log(response);
          this.users = response.data.data;
        })
        .catch(error => {
          this.$toast.error(error);
        });
    },
    deleteUser (id) {
      return UserService.delete(this.$store.state.auth.user.token, id)
        .then(response => {
          console.log(response);
          this.resetFormState();
          this.refreshUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          this.$toast.error(error);
        });
    },
    goToTemplate (args) {
      this.resetFormState();
      const {template, user} = args;
      if (template === 'template_update') {
        this.getUser(user.id);
      }
      this.selected_user = user;
      this.current_template = template;
    },
    refreshUsers () {
      this.getUsers();
    },
    generateRandomPassword () {
      return Math.random().toString(36).slice(-8);
    }
  }
}
</script>

<style>
</style>