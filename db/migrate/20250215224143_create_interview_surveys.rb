class CreateInterviewSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_surveys do |t|
      t.references :user, null: false, foreign_key: true
      t.date :interview_date

      t.timestamps
    end
  end
end
