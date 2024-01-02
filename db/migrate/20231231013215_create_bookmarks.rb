class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :lesson, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps

      t.index %i[user_id lesson_id], unique: true
    end
  end
end
