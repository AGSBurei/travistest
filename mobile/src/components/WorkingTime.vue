<template>
  <div class="container-user-workingtime">
    <div class="card">
        <div class="clocks" id="container">
          <div style="width:100%">
            <UserChip :user="user" :withOption="false"></UserChip>
          </div>
          <div style="width:100%">
            <table>
              <tr>
                <td>Start</td>
                <td>End</td>
                <td>Time</td>
              </tr>
              <tr>
                <td>
                  <span class="time">
                    {{ workingTime.start.toFormat("T") }}
                  </span>
                </td>
                <td>
                  <span class="time">
                    {{ workingTime.end.toFormat("T") }}</span>
                </td>
                <td><ClockManager @event-clocks="setStart($event)" :user="user" :clockIn="isActive" :startDate="workingTime.start" ref="clockManager" /></td>
              </tr>
            </table>
          </div>
          <div style="display: flex; align-items: center; width:100%">
            <div v-if="!isActive">
              <button class="info" @click.prevent="startWorkingTime">Start</button>
            </div>
            <div v-else>
              <button class="danger" @click.prevent="stopWorkingTime">End</button>
            </div>
          </div>
          <div style="display: flex; align-items: center; width:100%">
            <button class="danger" @click="resetWorkingTime">Reset</button>
          </div>
          <div style="display: flex; align-items: center; width:100%">
            <button type="button" :class="{ active: iscollapsed }" @click="viewCollapse">
              <div v-if="iscollapsed">
                Close History
              </div>
              <div v-else>
                Open History
              </div>
            </button>
          </div>
        </div>
      <div class="content" :class="{ activeClass: iscollapsed }">
        <WorkingTimes :user="user" ref="workingTimes" />
      </div>
      </div>
    </div>
</template>

<script>
import { DateTime } from 'luxon';
import ClockManager from './ClockManager';
import WorkingTimes from './WorkingTimes';
import UserChip from './base/UserChip.vue';
import soundStart from '../assets/audio/time_start_sound.mp3';
import soundEnd from '../assets/audio/time_end_sound.mp3';
import WorkingTimeService from '../services/workingTime.service';

export default {
  name: "WorkingTime",
  props: ["user"],
  components: {
    ClockManager,
    WorkingTimes,
    UserChip
  },
  data() {
    return {
      workingTime: {
        start: DateTime.now().set({ hour: 0, minute: 0 }),
        end: DateTime.now().set({ hour: 0, minute: 0 }),
      },
      isActive: false,
      iscollapsed: false,
    };
  },
  methods: {
    playStartSound() {
      const audio = new Audio(soundStart);
      audio.play();
    },
    playEndSound() {
      const audio = new Audio(soundEnd);
      audio.play();
    },
    createWorkingTime() {
      return WorkingTimeService.create(this.user.id, {
        start: this.workingTime.start.toISO(),
        end: this.workingTime.end.toISO(),
      })
      .then((response) => {
        this.$refs.workingTimes.getWorkingTimes();
        return response;
      })
      .catch((error) => {
        console.log(error);
        return error;
      });
    },
    startWorkingTime() {
      this.resetTime();
      this.workingTime.start = DateTime.now();
      this.isActive = true;
      this.playStartSound();
      this.$refs.clockManager.createClock(true);
      this.$refs.clockManager.isActive = true;
    },
    stopWorkingTime() {
      this.workingTime.end = DateTime.now();
      this.isActive = false;
      this.playEndSound();
      this.createWorkingTime();
      this.$refs.clockManager.createClock(false);
      this.$refs.clockManager.isActive = false;
    },
    viewCollapse () {
      if (this.iscollapsed) {
        this.iscollapsed = false;
      } else {
        this.iscollapsed = true;
      }
    },
    resetWorkingTime() {
      this.resetTime();
      this.isActive = false;
      this.$refs.clockManager.isActive = false;
    },
    resetTime() {
      this.workingTime.start = DateTime.local(0);
      this.workingTime.end = DateTime.local(0);
      this.$refs.clockManager.resetTimer();
    },
    setStart(start) {
      this.resetTime();
      this.workingTime.start = DateTime.fromISO(start);
      this.isActive = true;
    }
  },
};
</script>

<style scoped>
.container-user-workingtime {
  width:90vw; 
  margin: 0 auto
}

.card {
  background-color: white;
  border-radius: 4px;
  padding: 1rem;
  border: none;
  margin-bottom: 5px;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
}
button {
  margin-right: 5px;
  margin-left: 3px;
}
table {
  text-align: center;
}
.clocks {
  display: flex;
  width: 100%;
}
td {
  margin-right: 2px;
  margin-left: 2px;
}

.collapsible {
  background-color: #777;
  color: white;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
}

.active,
.collapsible:hover {
  background-color: rgb(170, 169, 169);
}

.content {
  padding: 0 18px;
  display: none;
  overflow: hidden;
}

.activeClass {
  display: block;
}

#conteneur
{
  display: flex;
  flex-wrap: nowrap;
}

@media (max-width: 700px) {
  .clocks{
    flex-direction: column;
  }

  .clocks div{
    justify-content: center;
    text-align: center;
    padding: 1rem 0;
    font-size: 1rem;
  }

  .clocks table {
    margin: 0 auto;
    font-size: 1.25rem;
  }

  td {
    padding: 0 1rem;
  }

  .container-user-workingtime{
    max-width: 400px;
    margin-top: 1.5rem;
  }

  .container-user-workingtime button {
    padding: 0.75rem 1rem;
    font-size: 1rem; 
    /* border-radius: 10px; */
  }

  .container-user-workingtime .chip {
    padding: 0;
  }
  
}

</style>