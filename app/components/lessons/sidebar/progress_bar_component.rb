module Lessons
  module Sidebar
    class ProgressBarComponent < ApplicationComponent
      def initialize(percentage:)
        @percentage = percentage
      end

      private

      attr_reader :percentage
    end
  end
end
