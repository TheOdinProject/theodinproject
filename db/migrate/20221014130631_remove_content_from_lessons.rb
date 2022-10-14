class RemoveContentFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_columns :lessons, :content, type: :text
  end
end
