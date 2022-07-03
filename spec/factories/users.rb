# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string(255)
#  learning_goal          :text
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  admin                  :boolean          default(FALSE), not null
#  avatar                 :string
#  path_id                :integer          default(1)
#  banned                 :boolean          default(FALSE), not null
#
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password { 'foobar' }
    confirmed_at { Time.zone.now - 5_000_000 }
    avatar { 'http://github.com/fake-avatar' }
    admin { false }
    path
  end
end
