module LessonsHelper
  def github_edit_url(lesson)
    github_link("curriculum/edit/main#{lesson.github_path}")
  end

  def github_report_url(lesson, path)
    # rubocop:disable Layout/LineLength
    github_link("curriculum/issues/new?assignees=nil&labels=Status%3A+Needs+Triage&projects=&template=suggestion.yaml&title=#{lesson.title}%3A+%3CShort+description+of+your+suggestion%3E&lesson-link=https://www.theodinproject.com#{path}")
    # rubocop:enable Layout/LineLength
  end
end
