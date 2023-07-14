class ContentContainerComponent < ApplicationComponent
  def initialize(classes: '', data_attributes: {}, current_user: nil)
    @classes = classes
    @data_attributes = data_attributes
    @current_user = current_user
  end

  private

  attr_reader :classes, :data_attributes, :current_user

  def font_size
    return '' if current_user && Feature.enabled?(:lesson_content_font_size, current_user)

    'md:prose-lg'
  end
end
