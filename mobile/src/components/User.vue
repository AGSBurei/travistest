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
            <div>
              <label for="password">Password</label>
              <input type="password" name="password" id="password" v-model="form.password" required />
            </div>
            <!-- <div> -->
              <!-- todo role -->
              <!-- <label for="role">Role</label> -->
              <!-- <select name="role" id="role" v-model="form.role" required> -->
                <!-- <option value="admin">Admin</option> -->
                <!-- <option value="user">User</option> -->
              <!-- </select> -->
            <!-- </div> -->
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
        // role: ''
      },
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    resetFormState() {
      this.form.username = '';
      this.form.email = '';
    },
    createUser () {
      return UserService.create(this.form)
        .then(response => {
          console.log(response);
          this.resetFormState();
          this.getUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          console.log(error);
        });
    },
    handleRegister() {
      this.$store.dispatch('auth/register', this.form).then(() => {
          this.resetFormState();
          this.getUsers();
          this.goToTemplate({template: 'template_index', user: null});
      }).catch(err => {
        console.log(err);
      });
    },
    updateUser (id) {
      return UserService.update(id, this.form)
        .then(response => {
          console.log(response);
          this.resetFormState();
          this.getUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          console.log(error);
        });
    },
    getUser(id) {
      return UserService.findOne(id)
        .then(response => {
          console.log(response);
          this.form.username = response.data.data.username;
          this.form.email = response.data.data.email;
        })
        .catch(error => {
          console.log(error);
        });
    },
    getUsers () {
      return UserService.findAll()
        .then(response => {
          console.log(response);
          this.users = response.data.data;
        })
        .catch(error => {
          console.log(error);
        });
    },
    deleteUser (id) {
      return UserService.delete(id)
        .then(response => {
          console.log(response);
          this.resetFormState();
          this.getUsers();
          this.goToTemplate({template: 'template_index', user: null});
        })
        .catch(error => {
          console.log(error);
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
  }
}
</script>

<style>
</style>