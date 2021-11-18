<template>
  <div style="width: 90vw; margin: 0 auto">
    <h2>History</h2>
    <div class="container">
      <div v-for="workingTime in workingTimes" v-bind:key="workingTime.id">
        <WorkingTime @event-refresh-workingTime="getWorkingTimes($event)" :workingTime="workingTime" :user="user" />
      </div>
    </div>
  </div>
</template>

<script>
import WorkingTimeService from '../services/workingTime.service';
import WorkingTime from '../components/WorkingTime.vue';

export default {
  name: "WorkingTimes",
  props: ["user"],
  components: { WorkingTime },
  data() {
    return {
      workingTimes: [],
    };
  },
  mounted() {
    this.getWorkingTimes();
  },
  computed: {
    haveHistory() {
      return this.workingTimes && this.workingTimes.length > 0;
    },
  },
  methods: {
    getWorkingTimes() {
      return WorkingTimeService.findAll(this.$store.state.auth.user.token, this.user.id)
        .then((response) => {
          this.workingTimes = response.data.data;
        })
        .catch((error) => {
          this.$toast.error(error);
        });
    },
  },
};
</script>

<style scoped>
p {
  font-size: 18px;
  color: rgba(0, 0, 0, 0.541);
}

.container {
  display: flex; /* or inline-flex */
  flex-direction: column;
}
</style>