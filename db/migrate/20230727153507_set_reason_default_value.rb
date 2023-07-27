class SetReasonDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :flags, :reason, 4
  end
end
