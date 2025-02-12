import { Controller } from '@hotwired/stimulus'

import { Chart } from 'chart.js/auto'

export default class ChartController extends Controller {
  static values = {
    type: String,
    data: Object,
    options: Object
  }

  connect () {
    this.chart = new Chart(
      this.element,
      {
        type: this.typeValue,
        data: this.dataValue,
        plugins: [...this.chartTypePlugins()],
        options: {
          maintainAspectRatio: false,
          responsive: true,
          plugins: {
            legend: {
              display: false
            },
            ...this.chartTypePluginOptions()
          },
          ...this.optionsValue
        }
      }
    )
  }

  disconnect () {
    this.chart.destroy()
  }

  // private

  chartTypePlugins () {
    return []
  }

  chartTypePluginOptions () {
    return {}
  }
}
