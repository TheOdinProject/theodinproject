FactoryBot.define do
  factory :admin_user do
    sequence(:name) { |n| "admin#{n}" }
    sequence(:email) { |n| "admin#{n}@odin.com" }
    password { 'password123' }
    status { :activated }
    role { :core }

    trait :with_otp do
      otp_secret { AdminUser.generate_otp_secret }
      otp_required_for_login { true }
    end

    trait :pending do
      status { :pending }
    end

    trait :pending_reactivation do
      status { :pending_reactivation }
    end

    trait :deactivated do
      status { :deactivated }
    end

    trait :activated do
      status { :activated }
    end
  end
end
