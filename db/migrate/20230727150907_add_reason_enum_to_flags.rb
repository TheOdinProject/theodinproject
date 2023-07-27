class AddReasonEnumToFlags < ActiveRecord::Migration[7.0]
  def change
    add_column :flags, :reason, :integer
  end
end
