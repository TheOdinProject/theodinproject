class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.text :body, null: false
      t.belongs_to :lesson, foreign_key: true, null: false
      t.timestamps
    end
  end
end
