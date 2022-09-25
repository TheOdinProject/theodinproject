module Users
  class Theme
    include Comparable

    DEFAULT_THEMES = [
      %w[light sun],
      %w[dark moon]
    ].freeze

    def self.all
      DEFAULT_THEMES.map { |name, icon| new(name:, icon:) }
    end

    def self.for(value)
      all.find { |theme| theme.name == value }
    end

    attr_reader :name, :icon

    def initialize(name:, icon:)
      @name = name
      @icon = icon
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      name
    end

    def dark_mode?
      name == 'dark'
    end
  end
end
