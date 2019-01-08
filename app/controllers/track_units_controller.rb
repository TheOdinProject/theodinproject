class TrackUnitsController < ApplicationController
  before_action :authenticate_user!

  def index
    @track_units = TrackUnit.all
  end

  def show
    @track_unit = TrackUnit.find(params[:id])
    @track_lessons = @track_unit.lessons
  end
end
