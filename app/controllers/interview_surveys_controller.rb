class InterviewSurveysController < ApplicationController
  before_action :authenticate_user!
  requires_feature :survey_feature

  def new
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
      interview_concept_names: []
    )
  end
end
