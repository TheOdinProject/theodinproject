class Api::SearchController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def index
    query = params[:query].scan(/\b\w+\b/)
    lesson_ids = WordFrequency
                 .where(word: query)
                 .group(:lesson_id)
                 .select('lesson_id, SUM(tf_idf) as total_tf_idf')
                 .order('total_tf_idf DESC')
                 .map(&:lesson_id)

    lessons = Lesson.where(id: lesson_ids)
                    .index_by(&:id)
                    .values_at(*lesson_ids)
                    .map do |lesson|
      { url: 'https://www.theodinproject.com/lessons/' + lesson.slug, title: lesson.title, desc: lesson.description }
    end
    render json: lessons
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['ODIN_BOT_ACCESS_TOKEN'])
    end
  end
end
