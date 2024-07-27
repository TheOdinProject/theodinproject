class Reports::Period
  include Comparable

  VALID_PERIODS = %w[day month year].freeze

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    VALID_PERIODS.map { |period| new(period) }
  end

  def self.find(value)
    all.find { |period| period == new(value) }
  end

  def <=>(other)
    name <=> other.name
  end

  def as_option
    [name.capitalize, name]
  end
end
