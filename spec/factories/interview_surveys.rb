FactoryBot.define do
  factory :interview_survey do
    user
    interview_date { Date.current }
  end
end  