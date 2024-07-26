class AddReactivatedToAdminUser < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL.squish
      ALTER TYPE status RENAME TO admin_user_status;
      ALTER TYPE admin_user_status RENAME VALUE 'active' TO 'activated';
      ALTER TYPE admin_user_status ADD VALUE 'pending_reactivation';
    SQL
  end
end
