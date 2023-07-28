class RenameLessonsHasPreviewColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :lessons, :has_live_preview, :previewable
  end
end
