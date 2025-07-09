module ButtonHelper
  def sign_up_button
    link_to 'Sign up', sign_up_path, class: 'button button--primary'
  end

  def curriculum_button
    link_to 'View curriculum', paths_path, class: 'button button--primary text-base'
  end

  def contribute_button
    link_to 'Learn how to contribute', contributing_path, class: 'button button--primary'
  end

  def chat_button
    link_to 'Open SLACK', DATAMONK_CHAT_URL, class: 'button button--secondary px-4', target: '_blank',
                                               rel: 'noreferrer'
  end
end
