class InterviewSurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :feature_flag_redirect

  def new
    Flipper.enable(:survey_feature) unless Rails.env.production?

    @interview_survey = InterviewSurvey.new
  end

  def create
    @interview_survey = current_user.interview_surveys.build(interview_survey_params)

    if @interview_survey.save!
      redirect_to dashboard_path, notice: 'Survey Submitted'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def interview_survey_params
    params.require(:interview_survey).permit(
      :interview_date,
      concept_list: []
    )
  end

  def feature_flag_redirect
    unless Feature.enabled?(:survey_feature, current_user)
      redirect_to dashboard_path, notice: 'Feature not enabled'
    end
  end
end
