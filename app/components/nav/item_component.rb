class Nav::ItemComponent < ApplicationComponent
  def initialize(path:, text:, test_id:, icon_path: nil, options: {})
    @path = path
    @text = text
    @test_id = test_id
    @icon_path = icon_path
    @options = options
  end

  def active?
    current_page?(path)
  end

  private

  attr_reader :path, :text, :test_id, :icon_path, :options

  def http_method
    options.fetch(:method, :get)
  end

  def mobile?
    options.fetch(:mobile, false)
  end
end
