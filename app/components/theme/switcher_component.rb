class Theme::SwitcherComponent < ApplicationComponent
  style do
    base do
      slot :link, class: 'text-gray-600 group flex items-center dark:text-gray-300'
      slot :icon,
           class: 'h-5 w-5 text-gray-400 group-hover:text-gray-500 dark:text-gray-300 dark:group-hover:text-gray-300'
    end

    variant type: :default do
      slot :link, class: 'py-2 px-3'
      slot :icon, class: 'mr-3'
    end

    variant type: :mobile do
      slot :link,
           class: 'text-gray-600 hover:bg-gray-50 hover:text-gray-900 text-base font-medium py-2 px-2 dark:hover:bg-gray-700/60 dark:hover:text-gray-200' # rubocop:disable Layout/LineLength
      slot :icon, class: 'mr-4 h-6 w-6'
    end

    variant type: :icon_only do
      slot :link, class: 'py-2 px-3'
      slot :icon, class: 'text-gray-400 group-hover:text-gray-700'
    end
  end

  def initialize(current_theme:, type: :default)
    @current_theme = current_theme
    @type = type
  end

  def variant
    type
  end

  def text
    "#{current_theme.name.capitalize} mode"
  end

  def other_theme
    Users::Theme.default_themes.find { |other_theme| other_theme.name != current_theme.name }
  end

  def icon_only?
    type == :icon_only
  end

  def mobile?
    type == :mobile
  end

  private

  attr_reader :current_theme, :type
end
