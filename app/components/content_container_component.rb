class ContentContainerComponent < ViewComponent::Base
  def initialize(classes: '', data_attributes: {})
    @classes = classes
    @data_attributes = data_attributes
  end

  private

  attr_reader :classes

  def data_attributes
    @data_attributes.map do |key, value|
      "data-#{key.to_s.dasherize}=#{value.to_s.dasherize}"
    end.join(' ')
  end
end
