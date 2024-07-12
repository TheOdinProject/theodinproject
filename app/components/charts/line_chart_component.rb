class Charts::LineChartComponent < ApplicationComponent
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

  def options # rubocop:disable Metrics/MethodLength
    {
      scales: {
        y: {
          type: 'linear',
          ticks: { precision: 0 },
        },
        x: {
          grid: { display: false },
        },
      },
    }.merge(@options)
  end

  private

  attr_reader :labels, :datasets
end
