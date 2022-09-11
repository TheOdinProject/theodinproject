class VerticalNavigation::ItemComponent < ViewComponent::Base
  include Classy::Yaml::ComponentHelpers

  def initialize(name:, href:, icon_path:)
    @name = name
    @href = href
    @icon_path = icon_path
  end

  def status
    current_page?(href) ? :active : :inactive
  end

  private

  attr_reader :name, :href, :icon_path
end
