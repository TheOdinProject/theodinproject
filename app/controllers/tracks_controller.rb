class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
    @courses = ordered_decorated_courses(@track.courses)
  end

  def index
    @tracks = Track.all
  end

  private

  def ordered_decorated_courses(track_courses)
    track_courses.track_order.map{ |course| CourseDecorator.new(course) } 
  end
end
