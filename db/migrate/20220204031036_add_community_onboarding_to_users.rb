class AddCommunityOnboardingToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :community_onboarding_steps, :jsonb, null: false, default: {}
    add_column :users, :community_onboarded, :boolean, null: false, default: false
  end
end
