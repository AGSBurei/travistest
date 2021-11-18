<template>
  <div>
    <template v-if="current_template == 'template_index'">
      <div class="clocks cardClock">
        <div class="clocks-info">
          <p>
            Start:<span class="time">{{
              formatDateFromISO(workingTime.start).toFormat(" EEEE hh:mm:ss ")
            }}</span>
          </p>
          <p>
            End:<span class="time">{{
              formatDateFromISO(workingTime.end).toFormat(" EEEE hh:mm:ss ")
            }}</span>
          </p>
          <p>
            Time:<span class="time">{{
              getTime(
                formatDateFromISO(workingTime.start),
                formatDateFromISO(workingTime.end)
              )
            }}</span>
          </p>
        </div>
      </div>
      <div>
        <button class="danger" @click="deleteWorkingTime()">
          Delete
        </button>
        <button
          class="warning"
          @click.prevent="
            goToTemplate({
              template: 'template_edit',
              workingTime: workingTime,
            })
          "
        >
          Update
        </button>
      </div>
    </template>
    <template v-if="current_template == 'template_edit'">
      <form>
        <div>
          <label for="start">Start</label>
          <input type="datetime-local" id="start" name="start" v-model="form.start" />
        </div>
        <div>
          <label for="end">End</label>
          <input type="datetime-local" id="end" name="end" v-model="form.end" />
        </div>
        <div>
          <button
            style="background: white; color: black"
            @click.prevent="
              goToTemplate({ template: 'template_index', workingTime: null })
            "
          >
            Back
          </button>
          <button class="warning" @click.prevent="updateWorkingTime">Update</button>
        </div>
      </form>
    </template>
  </div>
</template>

<script>
import { DateTime } from 'luxon';
import WorkingTimeService from '../services/workingTime.service';

export default {
  props: ["workingTime", "user"],
  data() {
    return {
      isActive: true,
      isHidden: true,
      current_template: "template_index",
      form: {
        start: this.workingTime.start,
        end: this.workingTime.end,
      },
      selected_workingTime: null,
    };
  },
  methods: {
    formatDateFromISO(date) {
      return DateTime.fromISO(date);
    },
    goToTemplate(args) {
      this.resetFormState();
      const { template, workingTime } = args;
      this.current_template = template;
      this.selected_workingTime = workingTime;
      if (template === "template_edit") {
        this.form.start = this.workingTime.start;
        this.form.end = this.workingTime.end;
      }
    },
    getTime(start, end) {
      return end.diff(start).toFormat("hh:mm:ss");
    },
    deleteWorkingTime() {
      return WorkingTimeService.delete(this.$store.state.auth.user.token, this.workingTime.id)
        .then(() => {
          this.refreshWorkingTime();
        })
        .catch((error) => {
          this.$toast.error(error);
        });
    },
    updateWorkingTime() {
      return WorkingTimeService.update(
        this.$store.state.auth.user.token,
        this.workingTime.id,
        this.form
      )
        .then(() => {
          this.refreshWorkingTime();
          this.goToTemplate({ template: 'template_index', workingTime: null });
        })
        .catch((error) => {
          this.$toast.error(error);
        });
    },
    resetFormState() {
      this.form.start = null;
      this.form.end = null;
    },
    refreshWorkingTime() {
      this.$emit('event-refresh-workingTime');
    },
  }
};
</script>

<style scoped>
button {
  max-height: 35px;
}

.clocks-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.cardClock {
  display: flex;
  background-color: #f1f1f1;
  border-radius: 4px;
  border: none;
  padding: 1rem;
  margin: 0 auto;
  margin-top: 1rem;
}

.time {
  font-size: 22px;
  color: rgb(32, 29, 29);
}
span {
  margin: 3px;
  text-align: center;
}

p {
  font-size: 18px;
  color: rgba(0, 0, 0, 0.541);
}

</style>