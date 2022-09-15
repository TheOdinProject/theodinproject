FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password { 'foobar' }
    avatar { 'http://github.com/fake-avatar' }
    admin { false }
    path
  end
end
