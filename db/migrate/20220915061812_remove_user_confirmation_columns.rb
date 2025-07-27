class RemoveUserConfirmationColumns < ActiveRecord::Migration[6.1]
  def change
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email # rubocop:disable Rails/ReversibleMigration
  end
end
