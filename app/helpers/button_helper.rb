module ButtonHelper
  def sign_up_button
    link_to 'Sign up', sign_up_path, class: 'button button--primary'
  end

  def sign_in_button
    link_to 'Sign in', sign_in_path, class: 'button button--secondary'
  end

  def create_new_account_button
    link_to 'Create new account', new_registration_path(resource_name), class: 'button button--secondary'
  end

  def curriculum_button
    link_to 'View curriculum', paths_path, class: 'button button--primary text-base'
  end

  def contribute_button
    link_to 'Contribute', contributing_path, class: 'button button--primary'
  end

  def chat_button
    link_to 'Open Discord', ODIN_CHAT_URL, class: 'button button--secondary px-4', target: '_blank', rel: 'noreferrer'
  end
end
