import { Controller } from '@hotwired/stimulus';
import Chart from 'chart.js/auto';
import twColorsPlugin from 'chartjs-plugin-tailwindcss-colors';
import twConfig from '../../../tailwind.config';

export default class ChartController extends Controller {
  static values = {
    type: String,
    data: Object,
  };

  connect() {
    this.chart = new Chart(
      this.element,
      {
        type: 'line',
        data: this.dataValue,
        plugins: [twColorsPlugin(twConfig)],
        options: {
          maintainAspectRatio: false,
          responsive: true,
          scales: {
            y: {
              type: 'linear',
              ticks: {
                precision: 0,
              },
            },
            x: {
              grid: {
                display: false,
              },
            },
          },
          plugins: {
            legend: {
              display: false,
            },
          },
        },
      },
    );
  }

  disconnect() {
    this.chart.destroy();
  }
}
