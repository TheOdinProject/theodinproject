class Charts::HorizontalBarChartComponent < ApplicationComponent
  NORMAL_BAR_THICKNESS = 25
  SMALL_DATASET_BAR_THICKNESS = 40

  def initialize(labels:, datasets:, options: {})
    @labels = labels
    @datasets = datasets
    @options = options
  end

  def data
    {
      labels:,
      datasets:
    }
  end

  def height
    return SMALL_DATASET_BAR_THICKNESS * labels.size if labels.size <= 5

    NORMAL_BAR_THICKNESS * labels.size
  end

  def options # rubocop:disable Metrics/MethodLength
    {
      indexAxis: 'y',
      scales: {
        y: {
          grid: { display: false },
          ticks: {
            crossAlign: 'far',
          },
        },
        x: {
          type: 'linear',
          ticks: { precision: 0 },
        }
      },
    }.merge(@options)
  end

  private

  attr_reader :labels, :datasets
end
