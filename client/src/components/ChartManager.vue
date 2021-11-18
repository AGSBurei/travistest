<template>
  <div style="width: 90vw; margin: 0 auto">
    <div class="card">
      <div class="container">
        <label for="chart-select">Choose a chart :</label>
        <select
          class="choice-chart"
          name="charts"
          id="chart-select"
          v-model="current_template"
        >
          <option value="">--Please choose an option--</option>
          <option value="template_polar_chart">Polar area Chart</option>
          <option value="template_doughnut_chart">Doughnut Chart</option>
          <option value="template_line_chart">Line Chart</option>
        </select>
        <template
          id="template_doughnut_chart"
          v-if="
            current_template === 'template_doughnut_chart' && doughnutData.datasets.length != 0
          "
        >
          <DoughnutChart :chartData="doughnutData" />
        </template>
        <template
          id="template_polar_chart"
          v-if="
            current_template === 'template_polar_chart' && polarData.datasets.length != 0
          "
        >
          <PolarAreaChart :chartData="polarData" />
        </template>
        <template
          id="template_line_chart"
          v-if="
            current_template === 'template_line_chart' && lineData.datasets.length != 0
          "
        >
          <LineChart :chartData="lineData" />
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import { DateTime } from "luxon";
import { defineComponent } from "vue";
import { DoughnutChart, PolarAreaChart, LineChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";
import UserService from "../services/user.service";
import workingTimeService from "../services/workingTime.service";
Chart.register(...registerables);

export default defineComponent({
  name: "ChartManager",
  props: ["token"],
  components: { DoughnutChart, PolarAreaChart, LineChart },
  data() {
    return {
      current_template: "",
      users: [],
    };
  },

  setup(props) {
    let users = [];

    const doughnutData = {
      labels :[],
      datasets:[
      ] 
    };
    const polarData = {
      labels: [],
      datasets: [],
      options: {
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    };
    let lineData = {
      labels: [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ],
      datasets: [
      ],
    };
    const getUsers = async () => {
      await UserService.findAll(props.token)
        .then((response) => {
          users = response.data.data;
          getWorkingTimes();
        })
        .catch((error) => {
          console.log(error);
        });
    };
    const getDtDiffInSec = (dt1, dt2) => {
      let time = {};
      const obj = {};
      let dtStart = DateTime.fromISO(dt1, { zone: "utc" });
      let dtEnd = DateTime.fromISO(dt2, { zone: "utc" });
      let diff = dtEnd.diff(dtStart, "seconds");
      diff = diff.toObject().seconds;
      time = dtStart.toFormat("cccc");

      obj[time] = diff;

      return obj;
    };
    const getWorkingTimes = async () => {
      for(let user of users) {
        let workList = [];
        await workingTimeService
          .findAll(props.token, user.id)
          .then((response) => {
            let data = [];
            data.push(response.data.data);
            for (let i = 0; i < data[0].length; i++) {
              workList.push(getDtDiffInSec(data[0][i].start, data[0][i].end));
            }
          });
        user.data = workList;
      }
      buildLineData();
      buildDoughnutData()
      buildPolarData()

    };
    const rngColor = () => {
      var rgb = {r: 0 , g: 0, b:0}
      var choosenOne = ""
      for(const color in rgb){
        let min = Math.ceil(0)
        let max = Math.max(255)
        rgb[color] = Math.floor(Math.random()*(max - min +1)) + min
      }
      choosenOne = "rgb(" + rgb.r+","+rgb.g+","+ rgb.b+")"
      return  choosenOne
    }

    const rngHexColor = () => {
      let hex = '#';
      const hexValues = [0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F']; 
      for(let i = 0; i < 6; i++){
        const index = Math.floor(Math.random() * hexValues.length)
        hex += hexValues[index];
      }
      return hex
    }

    const buildPolarData = async ()=> {
      
      let tt = []
      let bgColor = []
      let labels = []
      let userData = {}

      users.forEach(async function(user){
        let ttwork = 0
        for await (let date of user.data){
              if(date.Monday){ttwork += date.Monday} 
              if(date.Tuesday){ttwork += date.Tuesday}
              if(date.Wednesday){ttwork += date.Wednesday}
              if(date.Thursday){ttwork += date.Thursday}
              if(date.Friday){ttwork += date.Friday}
              if(date.Saturday){ttwork += date.Saturday}
              if(date.Sunday){ttwork += date.Sunday}
          }
          polarData.labels.push(user.username)
          bgColor.push(rngHexColor())
          tt.push(ttwork)
          labels.push(user.username)
      })
        userData.data = tt
        userData.backgroundColor = bgColor
        userData.label = labels
        polarData.datasets.push(userData)
        console.log(polarData)
    }

    const buildDoughnutData = async ()=> {
      let userData = {}
      let tt = []
      let bgColor = []
      let labels = []
      users.forEach(async function(user){
        let ttwork = 0
        for await (let date of user.data){
              if(date.Monday){ttwork += date.Monday} 
              if(date.Tuesday){ttwork += date.Tuesday}
              if(date.Wednesday){ttwork += date.Wednesday}
              if(date.Thursday){ttwork += date.Thursday}
              if(date.Friday){ttwork += date.Friday}
              if(date.Saturday){ttwork += date.Saturday}
              if(date.Sunday){ttwork += date.Sunday}
          }
          doughnutData.labels.push(user.username) 
          bgColor.push(rngHexColor())
          tt.push(ttwork)
          labels.push(user.username)
      })
      userData.data = tt
      userData.label = labels
      userData.backgroundColor = bgColor
      doughnutData.datasets.push(userData)
      console.log(doughnutData)
    }

    const buildLineData = async () => {
      users.forEach(async function(user){
        let totalHour = []
        var Monday = 0
        var Tuesday = 0
        var Wednesday = 0
        var Thursday = 0
        var Friday = 0
        var Saturday = 0
        var Sunday = 0
        let userData = {}
        for await (let date of user.data){
              if(date.Monday){Monday += date.Monday} 
              if(date.Tuesday){Tuesday += date.Tuesday}
              if(date.Wednesday){Wednesday += date.Wednesday}
              if(date.Thursday){Thursday += date.Thursday}
              if(date.Friday){Friday += date.Friday}
              if(date.Saturday){Saturday += date.Saturday}
              if(date.Sunday){Sunday += date.Sunday}
          }
          totalHour.push(Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday)
          userData.label = user.username
          userData.data = totalHour
          userData.fill = false
          userData.borderColor = rngColor()
          userData.tension = 0.1
          lineData.datasets.push(userData)
      })
    };
    return { doughnutData, polarData, lineData, getUsers };
  },

  async mounted() {
    await this.getUsers();
  },
});
</script>

<style>
.choice-chart {
  border-radius: 5px;
  padding: 0.2rem;
  font-size: 1rem;
  background: #8d949929;
  margin-left: 0.5rem;
}
</style>