class AddInstallationLessonColumnToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :installation_lesson, :boolean, default: false # rubocop:disable Rails/ThreeStateBooleanColumn

    add_index :lessons, :installation_lesson
  end
end
