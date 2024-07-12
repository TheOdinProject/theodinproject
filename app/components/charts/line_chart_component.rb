class Charts::LineChartComponent < ApplicationComponent
  def initialize(labels:, datasets:)
    @labels = labels
    @datasets = datasets
  end

  def data
    {
      labels:,
      datasets:
    }
  end

  private

  attr_reader :labels, :datasets
end
