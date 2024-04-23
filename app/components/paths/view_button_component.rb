module Paths
  class ViewButtonComponent < ApplicationComponent
    def initialize(current_user:, path:, classes: '')
      @current_user = current_user
      @path = path
      @classes = classes
    end

    def render?
      current_user.blank? || !current_user.on_path?(path)
    end

    private

    attr_reader :current_user, :path, :classes
  end
end
