class CardComponent < ApplicationComponent
  renders_one :header, Card::HeaderComponent
  renders_one :body, Card::BodyComponent
  renders_one :footer, Card::FooterComponent

  def initialize(classes: '', data_attributes: {})
    @classes = classes
    @data_attributes = data_attributes
  end

  private

  attr_reader :classes, :data_attributes
end
