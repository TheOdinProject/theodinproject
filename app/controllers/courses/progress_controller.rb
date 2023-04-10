module Courses
  class ProgressController < ApplicationController
    before_action :authenticate_user!
    before_action :course, only: :show
    before_action :progress_options, only: :show

    def show
      @percentage = @course.progress_for(current_user).percentage
    end

    private

    def course
      @course ||= Course.find_by(id: params[:id])
    end

    def progress_options
      @progress_options ||= {
        background_color: params[:background_color],
        size: params.fetch(:size, :default).to_sym,
        show_icon:,
      }.compact
    end

    def show_icon
      return true if current_user.progress_for(@course).completed?

      ActiveModel::Type::Boolean.new.cast(params.fetch(:show_icon, false))
    end
  end
end
