class Markdown::PreviewComponent < ApplicationComponent
  def initialize(markdown: '')
    @markdown = markdown
    @lint_errors = []
  end

  def lint
    File.write('markdown_to_lint.md', @markdown)
    results = `markdownlint-cli2 markdown_to_lint.md 2>&1`
    File.delete('markdown_to_lint.md')

    @lint_errors = results.split("\n").drop(4)
    @lint_errors.each_with_index do |err, i|
      @lint_errors[i] = err.split.drop(2).join(' ')
    end

    @lint_errors
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
