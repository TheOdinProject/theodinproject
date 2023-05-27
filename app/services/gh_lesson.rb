class GhLesson
  attr_reader :lesson_resource

  def initialize(lesson_resource)
    @lesson_resource = lesson_resource
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def persist
    return if front_matter.blank?

    lesson = Lesson.find_or_create_by!(
      title: front_matter['title'],
      github_path: lesson_resource['path'],
      position: front_matter['position'],
      description: front_matter['description'] || nil,
      is_project: !!front_matter['is_project'],
      section:,
      identifier_uuid: front_matter['identifier_uuid'],
    )

    lesson.create_content!(body:)
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def section
    title = front_matter['section']
    course = Course.find_by(slug: front_matter['course'])
    Section.find_by(title:, course:)
  end

  def body
    MarkdownConverter.new(document.content).as_html
  end

  def document
    @document ||= fetch_document
  end

  def fetch_document
    gh_document = Octokit.contents(
      'theodinproject/curriculum',
      query: { ref: 'spike/frontmatter-in-lessons' },
      path: lesson_resource[:path]
    )

    decoded_content = Base64.decode64(gh_document[:content]).force_encoding('UTF-8')
    FrontMatterParser::Parser.new(:md).call(decoded_content)
  end

  delegate :front_matter, to: :document
end
