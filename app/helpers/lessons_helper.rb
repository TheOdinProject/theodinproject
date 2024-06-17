module LessonsHelper
  def github_edit_url(lesson)
    github_link("curriculum/edit/main#{lesson.github_path}")
  end

  def github_commits_url(lesson)
    github_link("curriculum/commits/main#{lesson.github_path}")
  end

  def github_report_url(lesson)
    params = {
      labels: 'Status: Needs Triage',
      template: 'suggestion.yaml',
      title: "#{lesson.title}: <Short description of your suggestion>",
      'lesson-link': lesson_url(lesson)
    }

    github_link("curriculum/issues/new?#{params.to_query}")
  end
end
