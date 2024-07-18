import { Controller } from '@hotwired/stimulus';
import Chart from 'chart.js/auto';
import twColorsPlugin from 'chartjs-plugin-tailwindcss-colors';
import twConfig from '../../../tailwind.config';

export default class ChartController extends Controller {
  static values = {
    type: String,
    data: Object,
    options: Object,
  };

  connect() {
    this.chart = new Chart(
      this.element,
      {
        type: this.typeValue,
        data: this.dataValue,
        plugins: [twColorsPlugin(twConfig)],
        options: {
          maintainAspectRatio: false,
          responsive: true,
          plugins: {
            legend: {
              display: false,
            },
          },
          ...this.optionsValue,
        },
      },
    );
  }

  disconnect() {
    this.chart.destroy();
  }
}
