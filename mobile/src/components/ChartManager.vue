<template>
  <div style="width:90vw; margin: 0 auto">
    <div class="card">
      <div class="container">
        <label for="chart-select">Choose a chart :</label>
          <select class="choice-chart" name="charts" id="chart-select" v-model="current_template">
              <option value="">--Please choose an option--</option>
              <option value="template_bar_chart">Bar Chart</option>
              <option value="template_doughnut_chart">Doughnut Chart</option>
              <option value="template_line_chart">Line Chart</option>
          </select>
        <template id="template_doughnut_chart" v-if="current_template === 'template_doughnut_chart'">
          <DoughnutChart :chartData="doughnutData" />
        </template>
        <template id="template_bar_chart" v-if="current_template === 'template_bar_chart'">
          <BarChart :chartData="barData" />
        </template>
        <template id="template_line_chart" v-if="current_template === 'template_line_chart'">
          <LineChart :chartData="lineData" />
        </template>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import { DoughnutChart, BarChart, LineChart} from 'vue-chart-3';
import { Chart, registerables } from "chart.js";

Chart.register(...registerables);

export default defineComponent({
  name: "ChartManager",
  components: { DoughnutChart, BarChart, LineChart },
  data () {
    return {
      current_template: 'template_doughnut_chart',
    }
  },
  
  setup() {
    const doughnutData = {
      labels: ["Paris", "Nîmes", "Toulon", "Perpignan", "Autre"],
      datasets: [
        {
          data: [30, 40, 60, 70, 5],
          backgroundColor: [
            "#77CEFF",
            "#0079AF",
            "#123E6B",
            "#97B0C4",
            "#A5C8ED",
          ],
        },
      ],
    }
    const barData = {
        labels: ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet"],
        datasets: [
        {
          data: [30, 40, 60, 70, 5, 10, 42],
          backgroundColor: ['#77CEFF', '#0079AF', '#123E6B', '#97B0C4', '#A5C8ED'],
        },
      ],
      options : {
        scales: {
          y: {
          beginAtZero: true
        }  
      }
    }
  }
    const lineData = {
      labels: ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet"],
      datasets: [
        {
          label: 'Workload',
          data: [65, 59, 80, 81, 56, 55, 40],
          fill: false,
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }
      ]
    }
    return { doughnutData, barData, lineData };
  },
  methods: {
    getFormattedDoughnutData () {},
  }
});
</script>

<style>
  .choice-chart{
    border-radius: 5px;
    padding: 0.2rem;
    font-size: 1rem;
    background: #8d949929;
    margin-left: 0.5rem;
  }
</style>