# == Schema Information
#
# Table name: project_submissions
#
#  id                 :integer          not null, primary key
#  repo_url           :string
#  live_preview_url   :string           default(""), not null
#  user_id            :integer
#  lesson_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_public          :boolean          default(TRUE), not null
#  cached_votes_total :integer          default(0)
#  discarded_at       :datetime
#  discard_at         :datetime
#
FactoryBot.define do
  factory :project_submission do
    repo_url { 'https://github.com/user/repo' }
    live_preview_url { 'http://mysite.com' }
    user
    discard_at { nil }
    lesson { association :lesson, has_live_preview: true }
  end
end
