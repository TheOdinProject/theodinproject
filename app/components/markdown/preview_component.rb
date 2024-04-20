class Markdown::PreviewComponent < ApplicationComponent
  def initialize(markdown: '')
    @markdown = markdown
  end

  def allowed_tags
    Rails::HTML5::SafeListSanitizer::DEFAULT_ALLOWED_TAGS + %w[details summary section]
  end

  def allowed_attributes
    Rails::HTML5::SafeListSanitizer::DEFAULT_ALLOWED_ATTRIBUTES + %w[id data-title]
  end

  private

  attr_reader :markdown
end
