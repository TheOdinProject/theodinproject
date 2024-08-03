class Charts::LineChartComponent < ApplicationComponent
  def initialize(labels:, datasets:, options: {}, display_x_labels: true)
    @labels = labels
    @datasets = datasets
    @options = options
    @display_x_labels = ActiveModel::Type::Boolean.new.cast(display_x_labels)
  end

  def data
    {
      labels:,
      datasets:
    }
  end

  def options # rubocop:disable Metrics/MethodLength
    {
      hover: {
        intersect: false
      },
      scales: {
        y: {
          type: 'linear',
          beginAtZero: true,
          ticks: { precision: 0 },
          grid: { display: false },
        },
        x: {
          display: display_x_labels,
        },
      },
    }.merge(@options)
  end

  private

  attr_reader :labels, :datasets, :display_x_labels
end
