<template>
  <div>
    {{ output }}
  </div>
</template>

<script>
import { DateTime } from 'luxon';
import ClockService from '../services/clock.service';

export default {
  name: 'ClockManager',
  props: ['user', 'clockIn', 'startDate'],
  data() {
    return {
      clock: '00:00:00',
      clocks: null,
      isActive: this.clockIn,
      start: this.startDate
    };
  },
  async mounted() {
        await this.getLastClock();
    if(this.clocks?.status) {
      this.$emit('event-clocks', this.clocks.time);
      this.resetTimer();
      this.start = this.clocks.time;
      this.isActive = true;
    }
    setInterval(() => {
      if (this.isActive) {
        this.clock = DateTime.now().diff(DateTime.fromISO(this.start)).toFormat('hh:mm:ss');
      }
    }, 1000);
  },
  computed: {
    output() {     
      return this.clock;
    },
  },
  methods: {
    resetTimer() {
      this.clock = '00:00:00';
      this.start = DateTime.now();
    },
    createClock(status) {
      return ClockService.create(this.user.id, {
        time: DateTime.now().toISO(),
        status: status
      })
      .then((response) => {
        console.log(response);
        return response;
      })
      .catch((error) => {
        console.log(error);
        return error;
      });
    },
    async getLastClock() {
      return ClockService.findAll(this.user.id)
        .then(response => {
          console.log(response);
          this.clocks = response.data.data.slice(+1).pop();
        })
        .catch(error => {
          console.log(error);
          return error;
      });
    },
  },
};
</script>

<style>
</style>