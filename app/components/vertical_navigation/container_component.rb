class VerticalNavigation::ContainerComponent < ViewComponent::Base
  renders_many :links, 'VerticalNavigation::ItemComponent'
end
