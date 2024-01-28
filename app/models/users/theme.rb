module Users
  class Theme
    include Comparable

    DEFAULT_THEMES = [
      %w[light sun],
      %w[dark moon],
      %w[system computer-desktop]
    ].freeze

    def self.default_themes
      DEFAULT_THEMES.map { |name, icon| new(name:, icon:) }
    end

    def self.exists?(theme)
      default_themes.map(&:name).include?(theme)
    end

    def self.for(value)
      default_themes.find { |theme| theme.name == value }
    end

    def to_s
      name
    end

    def initialize(name:, icon:)
      @name = name
      @icon = icon
    end

    def dark_mode?
      name == 'dark'
    end

    def system_mode?
      name == 'system'
    end

    attr_reader :name, :icon
  end
end
