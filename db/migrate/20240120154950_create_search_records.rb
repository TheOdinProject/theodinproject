class SearchRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :search_records do |t|
      t.string :title, null: false
      t.string :url, null: false
    end
  end
end
