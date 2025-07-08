class RemoveIsApprovedFromProjectSubmissions < ActiveRecord::Migration[7.1]
  def change
    remove_column :project_submissions, :is_approved, :boolean
  end
end
