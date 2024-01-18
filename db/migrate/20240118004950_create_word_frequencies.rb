class CreateWordFrequencies < ActiveRecord::Migration[6.0]
  def change
    create_table :word_frequencies do |t|
      t.string :word, null: false
      t.float :tf_idf, null: false
      t.belongs_to :lesson, foreign_key: true, null: false
    end
  end
end
