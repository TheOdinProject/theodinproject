class DeviseInvitableAddToAdminUsers < ActiveRecord::Migration[7.0]
  def up
    change_table :admin_users do |t| # rubocop:disable Rails/BulkChangeTable
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer    :invitations_count, default: 0
      t.index      :invitation_token, unique: true # for invitable
      t.index      :invited_by_id
    end
  end

  def down
    change_table :admin_users do |t| # rubocop:disable Rails/BulkChangeTable
      t.remove_references :invited_by, polymorphic: true
      t.remove :invitations_count, :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token, :invitation_created_at
    end
  end
end
