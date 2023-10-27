require './lib/kramdown/document_sections'
require './lib/kramdown/converter/odin_html'

class MarkdownConverter
  def initialize(markdown)
    @markdown = markdown
  end

  def as_html
    sections = Kramdown::DocumentSections.new(markdown).all_sections

    if sections.any?
      sections.map { |section| parse_with_github_flavored_markdown(section.content) }.join
    else
      parse_with_github_flavored_markdown(markdown)
    end
  end

  private

  attr_reader :markdown

  def parse_with_github_flavored_markdown(content)
    Kramdown::Document.new(content, input: 'GFM').to_html
  end
end
