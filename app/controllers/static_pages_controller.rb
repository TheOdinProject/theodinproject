class StaticPagesController < ApplicationController
  def home
    @landing_page = true
    @success_stories = SuccessStory.limit(4)
    @courses = Course.badges
  end

  def about; end

  def faq; end

  def team; end

  def terms_of_use; end

  def privacy_policy; end

  def success_stories
    @success_stories = SuccessStory.all
  end

  def interview_survey_test; end
end
