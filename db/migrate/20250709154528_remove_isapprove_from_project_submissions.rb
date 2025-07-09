class RemoveIsapproveFromProjectSubmissions < ActiveRecord::Migration[7.1]
  def change
    remove_column :project_submissions, :isapprove, :boolean
  end
end
