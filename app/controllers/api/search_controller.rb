class Api::SearchController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def index
    query = params[:q].scan(/\b\w+\b/)
    render json: TfIdf
      .where(word: query)
      .group(:lesson_id)
      .select('lesson_id, SUM(score) as total_score')
      .order('total_score DESC')
      .map(&:lesson_id)
      .flat_map { |id| Lesson.where(id:) }
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['ODIN_BOT_ACCESS_TOKEN'])
    end
  end
end
