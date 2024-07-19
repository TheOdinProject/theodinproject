class CreateUserSignUpsDayStats < ActiveRecord::Migration[7.0]
  def change
    create_view :user_sign_ups_day_stats, materialized: true
  end
end
