class CreateInterviewConcepts < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_concepts do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
