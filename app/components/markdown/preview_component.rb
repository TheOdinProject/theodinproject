class Markdown::PreviewComponent < ApplicationComponent
  def initialize(markdown: '')
    @markdown = markdown
  end

  def allowed_tags
    Rails::HTML5::SafeListSanitizer::DEFAULT_ALLOWED_TAGS + %w[details summary]
  end

  private

  attr_reader :markdown
end
