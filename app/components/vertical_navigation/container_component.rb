class VerticalNavigation::ContainerComponent < ApplicationComponent
  renders_many :links, 'VerticalNavigation::ItemComponent'
end
