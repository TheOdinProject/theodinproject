class CreateInterviewSurveyConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_survey_concepts do |t|
      t.references :interview_survey, null: false, foreign_key: true
      t.references :interview_concept, null: false, foreign_key: true

      t.timestamps
    end
  end
end
