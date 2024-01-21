class CreateTfIdfs < ActiveRecord::Migration[7.0]
  def change
    create_table :tf_idfs do |t|
      t.string :word, null: false
      t.float :score, null: false
      t.belongs_to :lesson, foreign_key: true, null: false
    end

    add_index :tf_idfs, %i[lesson_id word], unique: true
  end
end
