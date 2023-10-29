module LessonsHelper
  def github_edit_url(lesson)
    github_link("curriculum/edit/main#{lesson.github_path}")
  end

  def github_report_url(lesson, path)
    # rubocop:disable Layout/LineLength
params = {
      labels: 'Status: Needs Triage',
      template: 'suggestion.yaml',
      title: "#{lesson.title}: <Short description of your suggestion>",
      lesson: lesson_url(lesson)
    }

    github_link("curriculum/issues/new?#{params.to_query}")
    # rubocop:enable Layout/LineLength
  end
end
