class CreateSearchRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :search_records do |t|
      t.string :title, null: false, unique: true
      t.string :url, null: false, unique: true
    end
  end
end
