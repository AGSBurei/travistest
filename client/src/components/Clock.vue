<template>
  <div>
    {{ output }}
  </div>
</template>

<script>
import { DateTime } from 'luxon';
import ClockService from '../services/clock.service';

export default {
  name: 'Clock',
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
    await this.refresh();
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
      return ClockService.create(this.$store.state.auth.user.token, this.user.id, {
        time: DateTime.now().toISO(),
        status: status
      })
      .then(async() => {
        await this.refresh();
      })
      .catch((error) => {
        this.$toast.error(error);
      });
    },
    async getLastClock() {
      return ClockService.findAll(this.$store.state.auth.user.token, this.user.id)
        .then((response) => {
          if(response.data.data.length > 1) {
            this.clocks = response.data.data.slice(+1).pop();
          } else {
            this.clocks = (response.data.data).pop();
          }
        })
        .catch(error => {
          this.$toast.error(error);
      });
    },
    async refresh() {
      await this.getLastClock();
      if(this.clocks?.status) {
        this.$emit('event-clocks', this.clocks.time);
        this.resetTimer();
        this.start = this.clocks.time;
        this.isActive = true;
      }
    },
  },
};
</script>

<style>
</style>