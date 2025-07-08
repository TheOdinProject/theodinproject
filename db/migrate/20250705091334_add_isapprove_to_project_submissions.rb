class AddIsapproveToProjectSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :project_submissions, :isapprove, :boolean, default: nil
  end
end
