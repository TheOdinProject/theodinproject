class ChangeReasonColumnNameToExtra < ActiveRecord::Migration[7.0]
  def change
    rename_column :flags, :reason, :extra
  end
end
