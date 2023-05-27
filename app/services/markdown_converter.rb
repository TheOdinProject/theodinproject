require './lib/kramdown/document_sections'
require './lib/kramdown/converter/odin_html'

class MarkdownConverter
  def initialize(document)
    @document = FrontMatterParser::Parser.new(:md).call(document)
  end

  def as_html
    markdown = document.content
    sections = Kramdown::DocumentSections.new(markdown).all_sections

    if sections.any?
      sections.map { |section| Kramdown::Document.new(section.content).to_html }.join
    else
      Kramdown::Document.new(markdown).to_html
    end
  end

  private

  attr_reader :document
end
