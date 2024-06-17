class Ui::BackLinkComponent < ApplicationComponent
  def initialize(path:, name:)
    @path = path
    @name = name
  end

  private

  attr_reader :path, :name
end
