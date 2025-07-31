class Overlays::ModalComponent < ApplicationComponent
  def initialize(title:)
    @title = title
  end

  private

  attr_reader :title
end
