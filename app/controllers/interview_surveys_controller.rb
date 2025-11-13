class InterviewSurveysController < ApplicationController
  requires_feature :survey_feature

  def new; end

  def create
    # puts params[:survey]
    redirect_to dashboard_path, notice: 'Survey Submitted'
  end
end
