<template>
  <div style="width: 90vw; margin: 0 auto">
    <h2>History</h2>
    <div class="container">
      <div v-for="workingTime in workingTimes" v-bind:key="workingTime.id">
        <template v-if="current_template == 'template_index'">
          <div class="clocks cardClock">
            <div class="clocks-info">
              <p>
                Start:<span class="time">{{
                  formatDateFromISO(workingTime.start).toFormat(
                    " EEEE hh:mm:ss "
                  )
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
            <button class="danger" @click="deleteWorkingTime(workingTime.id)">
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
      </div>
      <template v-if="current_template == 'template_edit'">
        <form>
          <div>
            <label for="start">Start</label>
            <input type="time" id="start" name="start" v-model="form.start" />
          </div>
          <div>
            <label for="end">End</label>
            <input type="time" id="end" name="end" v-model="form.end" />
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
            <button class="success" @click.prevent="updateWorkingTime">Done</button>
          </div>
        </form>
      </template>
    </div>
  </div>
</template>

<script>
import { DateTime } from 'luxon';
import WorkingTimeService from '../services/workingTime.service';

export default {
  name: "WorkingTimes",
  props: ["user"],
  data() {
    return {
      workingTimes: [],
      isActive: true,
      isHidden: true,
      current_template: "template_index",
      form: {
        start: null,
        end: null,
      },
      selected_workingTime: null,
    };
  },
  mounted() {
    this.getWorkingTimes();
  },
  methods: {
    getWorkingTimes() {
      return WorkingTimeService.findAll(this.user.id)
        .then((response) => {
          this.workingTimes = response.data.data;
        })
        .catch((error) => {
          console.log(error);
          return error;
        });
    },
    getWorkingTime(id) {
      return WorkingTimeService.findOne(this.user.id, id)
        .then((response) => {
          console.log(response.data.data);
          this.form.start = DateTime.fromISO(response.data.data.start).toFormat(
            "H:mm:ss"
          );
          this.form.end = DateTime.fromISO(response.data.data.end).toFormat(
            "H:mm:ss"
          );
        })
        .catch((error) => {
          console.log(error);
          return error;
        });
    },
    updateWorkingTime() {
      return WorkingTimeService.update(this.selected_workingTime.id, {
        'start': this.form.start,
        'end': this.form.end,
      })
      .then((response) => {
        console.log(response);
        this.getWorkingTimes();
      })
      .catch((error) => {
        console.log(error);
        return error;
      });
    },
    deleteWorkingTime(id) {
      return WorkingTimeService.delete(id)
        .then(() => {
          this.getWorkingTimes();
        })
        .catch((error) => {
          console.log(error);
          return error;
        });
    },
    getTime(start, end) {
      return end.diff(start).toFormat("hh:mm:ss");
    },
    formatDateFromISO(date) {
      return DateTime.fromISO(date);
    },
    resetFormState() {
      this.form.start = null;
      this.form.end = null;
    },
    goToTemplate(args) {
      this.resetFormState();
      const { template, workingTime } = args;
      this.current_template = template;
      this.selected_workingTime = workingTime;
      if (template === "template_edit") {
        this.getWorkingTime(workingTime.id);
      }
    },
  },
};
</script>

<style scoped>
button {
  max-height: 35px;
}
.btn-clock {
  display: flex;
  align-items: center;
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

.container {
  display: flex; /* or inline-flex */
  flex-direction: column;
}
</style>