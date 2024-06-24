class CreateInterviewSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :interview_surveys do |t|
      t.string :name
      t.timestamps
    end
  end
end
