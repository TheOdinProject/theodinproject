require 'rails_helper'
require './lib/kramdown/document_sections'

RSpec.describe Markdown::PreviewComponent do
  describe '#lint' do
    it 'lints the markdown' do
      sample_markdown = <<~MARKDOWN
        ### First section header
        some content

        ### Second section header
        some content

        ### Third section header
        some content
      MARKDOWN

      expect(described_class.new(markdown: sample_markdown).lint.any?).to be true
    end

    context 'when no issues present' do
      it 'lints the markdown and returns an empty array' do
        sample_markdown = <<~MARKDOWN
          ### First section header

          some content
        MARKDOWN

        expect(described_class.new(markdown: sample_markdown).lint.any?).to be false
      end
    end

    context 'when no empty line is present under the header' do
      it 'detects it in the linter' do
        sample_markdown = <<~MARKDOWN
          ### First section header
          some content
        MARKDOWN

        expect(described_class.new(markdown: sample_markdown).lint.first).to include 'surrounded by blank lines'
      end
    end
  end
end
