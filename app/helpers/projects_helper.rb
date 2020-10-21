module ProjectsHelper
  def heart_icon_or_button_for(user, project)
    HeartIconPresenter.render(user: user, project: project, view: self)
  end

  def project_submission_params
    params.require(:project_submission).permit(
      :repo_url,
      :live_preview_url,
      :is_public,
      :lesson_id
    )
  end
end
