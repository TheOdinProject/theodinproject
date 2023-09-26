class CardComponent < ApplicationComponent
  renders_one :header, Card::HeaderComponent
  renders_one :body, Card::BodyComponent
  renders_one :footer, Card::FooterComponent

  def initialize(classes: '', id: '')
    @classes = classes
    @id = id
  end

  private

  attr_reader :classes, :id
end
