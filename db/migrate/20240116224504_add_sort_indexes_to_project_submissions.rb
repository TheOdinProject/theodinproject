class AddSortIndexesToProjectSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_index :project_submissions, :created_at
    add_index :project_submissions, :likes_count
  end
end
