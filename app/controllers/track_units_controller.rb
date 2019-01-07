class TrackUnitsController < ApplicationController
  # before_action :authenticate_user!
  
  def new
    @track_unit = TrackUnit.new
  end

  def index
    @track_units = TrackUnit.all
  end

  def show
    @track_unit = TrackUnit.find(params[:id])
    @track_lessons = @track_unit.lessons
  end

  def create
    @track_unit = TrackUnit.new
    if @track_unit.save?
      flash[:success] = "Unit Created"
      redirect_to @track_unit
    else
      flash[:warning] = "Unable to create Unit"
      render :new
    end
  end

  private

  def track_unit_params
    Params.require(:track_unit).permit(:name)
  end

end
