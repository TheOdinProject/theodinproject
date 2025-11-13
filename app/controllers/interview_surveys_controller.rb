class InterviewSurveysController < ApplicationController
  before_action :authenticate_user!
  # TODO: merge feature flag stuff in

  def new
    if Flipper.enabled?(:survey_feature, current_user)
      @interview_survey = InterviewSurvey.new
    else
      redirect_to dashboard_path, notice: 'Feature not enabled'
    end
  end

  def create
    @interview_survey = current_user.interview_surveys.build(interview_survey_params)

    if @interview_survey.save
      redirect_to dashboard_path, notice: 'Survey submitted'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def interview_survey_params
    params.require(:interview_survey).permit(
      :interview_date,
      interview_concept_names: []
    )
  end
end
