class RegistrationsController < Devise::RegistrationsController
  after_action :register_mailing_list, only: [:create]

  protected

  def after_sign_up_path_for(_resource)
    dashboard_path
  end

  def after_inactive_sign_up_path_for(resource)
    dashboard_path
  end

  def update_resource(resource, params)
    if current_user.provider == 'github'
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  private

  def register_mailing_list
    if resource.persisted?
      gibbon_request = Gibbon::Request.new(
        api_key: ENV['MAILCHIMP_API_KEY']
      )
      merge_fields = {
        USERNAME: resource.username,
        SIGNUPDATE: resource.created_at
      }
      gibbon_request
        .lists(ENV['MAILCHIMP_LIST_ID'])
        .members
        .create(
          body: {
            email_address: resource.email,
            status: :subscribed,
            merge_fields: merge_fields
          }
        )
    end
  end
end
