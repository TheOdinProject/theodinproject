class CreateSectionCompletions < ActiveRecord::Migration
  def change
    create_table :section_completions do |t|
      t.integer :section_id
      t.integer :student_id
      t.timestamps
    end
    add_index :section_completions, [:section_id, :student_id], :unique => true
  end
end
