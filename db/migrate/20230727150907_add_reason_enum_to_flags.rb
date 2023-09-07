class AddReasonEnumToFlags < ActiveRecord::Migration[7.0]
  def change
    add_column :flags, :reason, :integer, null: false, default: 4
  end
end
