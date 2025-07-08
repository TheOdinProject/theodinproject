class ChangeIsapproveDefaultInProjectSubmissions < ActiveRecord::Migration[7.1]
  def up
    change_column_default :project_submissions, :isapprove, nil
    change_column_null :project_submissions, :isapprove, true
  end

  def down
    change_column_null :project_submissions, :isapprove, false
    change_column_default :project_submissions, :isapprove, false
  end
end
