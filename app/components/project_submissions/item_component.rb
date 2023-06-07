module ProjectSubmissions
  class ItemComponent < ApplicationComponent
    def initialize(item:)
      @item = item
    end

    private

    attr_reader :item
  end
end
