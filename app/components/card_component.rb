class CardComponent < ApplicationComponent
  renders_one :header, Card::HeaderComponent
  renders_one :body, Card::BodyComponent
  renders_one :footer, Card::FooterComponent

  def initialize(classes: '', id: '', data_attributes: {})
    @classes = classes
    @id = id
    @data_attributes = data_attributes
  end

  private

  attr_reader :classes, :id, :data_attributes
end
