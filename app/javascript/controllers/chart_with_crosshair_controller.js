import { Interaction } from 'chart.js/auto'
import { CrosshairPlugin, Interpolate } from 'chartjs-plugin-crosshair'
import ChartController from './chart_controller'

export default class ChartWithCrosshairController extends ChartController {
  connect () {
    Interaction.modes.interpolate = Interpolate
    super.connect()
  }

  chartTypePlugins () {
    return [CrosshairPlugin, Interpolate]
  }

  chartTypePluginOptions () {
    return {
      tooltip: {
        mode: 'index',
        intersect: false
      },
      crosshair: {
        line: {
          dashPattern: [5, 5],
          color: '#9ca3af',
          width: 1
        },
        snap: {
          enabled: true
        },
        zoom: {
          enabled: true,
          zoomboxBackgroundColor: 'rgba(66,133,244,0.2)',
          zoomboxBorderColor: '#48F',
          zoomButtonClass: 'hidden'
        }
      }
    }
  }
}
