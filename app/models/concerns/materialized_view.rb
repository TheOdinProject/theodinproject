module MaterializedView
  extend ActiveSupport::Concern
  class_methods do
    def refresh
      Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
    end
  end

  def readonly?
    true
  end
end
