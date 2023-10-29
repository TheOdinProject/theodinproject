module Sortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  private

  def sort_column(klass)
    params[:sort].presence_in(klass.sortable_columns) || "created_at"
    # klass.sortable_columns.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction(default: "asc")
    params[:direction].presence_in(%w[asc desc]) || default
    # %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
