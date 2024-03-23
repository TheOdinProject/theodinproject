FactoryBot.define do
  factory :admin_user do
    sequence(:name) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@odin.com" }
    password { 'password123' }
  end
end
