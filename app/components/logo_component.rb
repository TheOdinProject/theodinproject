class LogoComponent < ApplicationComponent
  renders_one(:small_icon, lambda do |classes:|
    image_tag 'icons/odin-icon.svg', alt: 'Odin Logo', class: "block lg:hidden #{classes}"
  end)

  def initialize(classes:, path: nil)
    @classes = classes
    @path = path
  end

  attr_reader :classes

  def before_render
    @classes = "#{classes} hidden lg:block" if small_icon?
  end

  def redirect_to_path
    @path || root_path
  end
end
