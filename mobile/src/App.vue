<template>
  <div>
    <template v-if="loggedIn">
      <h1 >Time manager</h1>
      <h4 v-if="itsFriday" class="citation">thanks god it's friday</h4>
      <h4 v-if="itsMonday" class="citation">small monday, big week</h4>
      <User />
      <h2 class="h-title">Working time</h2>
      <div class="array-workingtime" v-for="user in users" v-bind:key="user.id">
        <WorkingTime :user="user" />
      </div>
      <h2 class="h-title">Data Vizualisation</h2>
      <ChartManager />
    </template>
    <template v-if="!loggedIn">
      <Login />
      <Register />
    </template>
  </div>
</template>

<script>
// Import the required components
import ChartManager from "./components/ChartManager.vue";
import User from "./components/User.vue";
import WorkingTime from "./components/WorkingTime.vue";
import Login from "./components/auth/Login.vue";
import UserService from "./services/user.service";
import { DateTime } from 'luxon';
import Register from './components/auth/Register.vue';

export default {
  name: "App",
  components: {
    User,
    WorkingTime,
    ChartManager,
    Login,
    Register
  },
  data() {
    return {
      users: [],
      current_template: "template_index",
    };
  },
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    },
    itsFriday() {
      return DateTime.now().weekday === 5;
    },
    itsMonday() {
      return DateTime.now().weekday === 1;
    }
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    getUsers() {
      return UserService.findAll()
        .then((response) => {
          return (this.users = response.data.data);
        })
        .catch((error) => {
          console.log(error);
          return error;
        });
    },
  },
};
</script>

<style>
body {
  background-color: rgb(243, 243, 243);
  font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
  box-sizing: border-box;
  padding-bottom: 5rem;
}

.array-workingtime {
  margin-top: 1.25rem;
}

h1, h4 {
  margin-left: 4vw;
}

.h-title {
  margin-left: 4vw;
  margin-top: 5vh;
}

input {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  box-sizing: border-box;
}

button {
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  padding: 0.5rem;
  text-decoration: none;
}

button:hover {
  background: rgb(192, 192, 192);
}

.card {
  background-color: white;
  border-radius: 4px;
  padding-left: 3rem;
  padding-right: 3rem;
  padding-bottom: 2rem;
  padding-top: 1rem;
  border: none;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
}

/* BUTTON */
.info {
  background: rgb(77, 116, 175);
  color: whitesmoke;
}

.info:hover {
  background: rgb(62, 97, 143);
  color: whitesmoke;
}

.success {
  background: rgb(77, 175, 77);
  color: whitesmoke;
}

.success:hover {
  background: rgb(62, 143, 62);
  color: whitesmoke;
}

.danger {
  background: rgb(177, 68, 68);
  color: whitesmoke;
}

.danger:hover {
  background: rgb(148, 55, 55);
  color: whitesmoke;
}

.danger:disabled {
  background: rgb(173, 128, 128);
  color: whitesmoke;
  cursor: not-allowed;
}

.warning {
  background: rgb(194, 118, 31);
  color: whitesmoke;
}

.warning:hover {
  background: rgb(179, 134, 51);
  color: whitesmoke;
}
</style>
