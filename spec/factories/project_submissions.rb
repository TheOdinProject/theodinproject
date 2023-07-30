FactoryBot.define do
  factory :project_submission do
    repo_url { 'https://github.com/user/repo' }
    live_preview_url { 'http://mysite.com' }
    user
    discard_at { nil }
    lesson { association :lesson, previewable: true }
  end
end
