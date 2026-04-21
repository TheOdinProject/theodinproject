class NewTabTextLinkComponent < ApplicationComponent
  def initialize(text:, href:, classes:, data: nil, noreferrer: true)
    @text = text
    @href = href
    @classes = classes
    @data = data
    @noreferrer = noreferrer
  end

  private

  attr_reader :text, :href, :classes, :data, :noreferrer
end
