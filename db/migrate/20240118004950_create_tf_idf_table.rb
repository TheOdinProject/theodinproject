class TfIdfTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tf_idf_table do |t|
      t.string :word, null: false
      t.float :tf_idf, null: false
      t.belongs_to :search_record, foreign_key: true, null: false
    end
  end
end
