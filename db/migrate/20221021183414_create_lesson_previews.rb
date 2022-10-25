class CreateLessonPreviews < ActiveRecord::Migration[6.1]
  def change
    create_table :lesson_previews, id: :uuid do |t|
      t.text :content, null: false
      t.timestamps
    end
  end
end
