module Sortable
  extend ActiveSupport::Concern

  def sort_column_for(klass)
    params[:sort].presence_in(klass.sortable_columns) || 'created_at'
  end

  def sort_direction(default: 'desc')
    params[:direction].presence_in(%w[asc desc]) || default
  end
end
