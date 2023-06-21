module ProjectSubmissions
  class ItemComponent < ApplicationComponent
    def initialize(item:)
      @item = item
    end

    def render?
      item.present?
    end

    private

    attr_reader :item
  end
end
