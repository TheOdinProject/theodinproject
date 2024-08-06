class RenameFlagTakenActionToActionTaken < ActiveRecord::Migration[7.0]
  def change
    rename_column :flags, :taken_action, :action_taken
  end
end
