class Overlays::DialogComponent < ApplicationComponent
  def initialize(id:)
    @id = id
  end

  private

  attr_reader :id
end
