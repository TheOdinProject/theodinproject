module ProjectsHelper
  def heart_icon_for(current_user, project)
    return heart_icon unless current_user
    return heart_icon if current_user == project.user
    return unlike_button_for(project) if current_user.liked? project 
    like_button_for(project)
  end

  def like_button_for(project)
    button_to lesson_project_votes_path(project.lesson_id, project.id),
      method: :post,
      remote: true,
      title: 'Like this project',
      class: 'button button--primary project__vote-button' do
      '<i class="fa fa-heart-o"></i>'.html_safe
    end
  end

  def unlike_button_for(project)
    button_to lesson_project_vote_path(project.lesson_id, project.id),
      method: :delete,
      remote: true,
      title: 'Unlike this project',
      class: 'button button--primary project__vote-button' do
      '<i class="fa fa-heart"></i>'.html_safe
    end
  end

  def heart_icon
    '<span class="heart"><i class="fa fa-heart"></i></span>'.html_safe
  end
end