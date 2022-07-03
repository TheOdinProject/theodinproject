# == Schema Information
#
# Table name: success_stories
#
#  id                :integer          not null, primary key
#  student_name      :string
#  avatar_path_name  :string
#  story_content     :text
#  job_title         :string
#  social_media_link :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class SuccessStory < ApplicationRecord
end
