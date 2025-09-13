class Overlays::DialogComponent < ApplicationComponent
  renders_one :trigger, lambda { |classes:, &block|
    link_to '#', data: { action: 'overlays--dialog#open:prevent' }, class: classes, &block
  }
end
