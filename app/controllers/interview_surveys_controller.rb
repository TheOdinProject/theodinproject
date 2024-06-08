class InterviewSurveysController < ApplicationController
  def new
    unless Feature.enabled?(:survey_feature, current_user)
      redirect_to dashboard_path, notice: 'Feature not enabled'
    end
  end

  def create
    @interview_survey = InterviewSurvey.new(interview_survey_params)
    if @interview_survey.save
      redirect_to dashboard_path, notice: 'Survey Submitted'
    else
      render :new, notice: 'Error Submitting Survey'
    end
  end

  private

  def interview_survey_params
    params.require(:interview_survey).permit(:name)
  end
end
