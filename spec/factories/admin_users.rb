FactoryBot.define do
  factory :admin_user do
    sequence(:name) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@odin.com" }
    password { 'password123' }
    status { :active }

    trait :with_otp do
      otp_secret { AdminUser.generate_otp_secret }
      otp_required_for_login { true }
    end
  end
end
