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

    uuid = Set.new
    lessons_hash = {}
    lessons = Lesson
              .where(id: lesson_ids)
              .each do |lesson|
      unless uuid.include?(lesson.title)
        lessons_hash[lesson.id] = { url: 'https://www.theodinproject.com/lessons/' + lesson.slug, title: lesson.title, desc: lesson.description }
        uuid.add(lesson.title)
      end
    end

    render json: lesson_ids.map { |id| lessons_hash[id] }.compact
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV['ODIN_BOT_ACCESS_TOKEN'])
    end
  end
end
