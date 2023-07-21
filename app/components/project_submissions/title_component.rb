module ProjectSubmissions
  class TitleComponent < ApplicationComponent
    def initialize(title:, url: nil)
      @title = title
      @url = url
    end

    private

    attr_reader :title, :url
  end
end
