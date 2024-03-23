class Admin::PaginationComponent < ApplicationComponent
  def initialize(pagy:, resource_name:)
    @pagy = pagy
    @resource_name = resource_name
  end

  def render?
    pagy.pages > 1
  end

  private

  attr_reader :pagy, :resource_name
end
