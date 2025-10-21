class VerticalNavigation::ItemComponent < ApplicationComponent
  style do
    variant type: :active do
      slot :link, class: 'bg-gray-200 text-gray-900 dark:bg-gray-700/50 dark:text-gray-300'
      slot :icon, class: 'text-gray-500 group-hover:text-gray-700 dark:text-gray-300 dark:group-hover:text-gray-300'
    end

    variant type: :inactive do
      slot :link,
           class: 'text-gray-600 hover:bg-gray-50 hover:text-gray-900 dark:hover:bg-gray-600/70 dark:hover:text-gray-300 dark:text-gray-400' # rubocop:disable Layout/LineLength
      slot :icon, class: 'text-gray-400 group-hover:text-gray-500 dark:text-gray-400 dark:group-hover:text-gray-300'
    end
  end

  def initialize(name:, href:, icon_path:)
    @name = name
    @href = href
    @icon_path = icon_path
  end

  def status
    current_page?(href) ? :active : :inactive
  end

  def variant
    status
  end

  private

  attr_reader :name, :href, :icon_path
end
