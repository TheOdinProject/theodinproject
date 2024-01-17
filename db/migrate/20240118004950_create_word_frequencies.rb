class CreateWordFrequencies < ActiveRecord::Migration[6.0]
  def change
    create_table :word_frequencies do |t|
      t.string :word, null: false
      t.float :tf, null: false
      t.float :idf, null: false
      t.belong_to :lesson, foreign_key: true, null: false
    end
  end
end
