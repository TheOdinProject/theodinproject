class InterviewSurveysController < ApplicationController
  def new
    unless Feature.enabled?(:survey_feature, current_user)
      redirect_to dashboard_path, notice: 'Feature not enabled'
    end
  end

  def create
    # puts params[:survey]
    redirect_to dashboard_path, notice: 'Survey Submitted'
  end
end
