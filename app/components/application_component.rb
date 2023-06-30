class ApplicationComponent < ViewComponent::Base
  include Classy::Yaml::ComponentHelpers
  include Turbo::FramesHelper

  private

  def html_data_attributes_for(data)
    data.map do |key, value|
      "data-#{key.to_s.dasherize}=#{value.to_s.dasherize}"
    end.join(' ')
  end
end
