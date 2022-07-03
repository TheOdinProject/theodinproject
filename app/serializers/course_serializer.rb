# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position         :integer          not null
#  slug             :string
#  identifier_uuid  :string           default(""), not null
#  path_id          :integer
#  show_on_homepage :boolean          default(FALSE), not null
#  badge_uri        :string           not null
#
class CourseSerializer
  def initialize(course, between_dates = nil)
    @course = course
    @between_dates = between_dates
  end

  def self.as_json(course, between_dates = nil)
    new(course, between_dates).as_json
  end

  def as_json(_options = nil)
    {
      title: course.title,
      sections: serialized_sections,
    }
  end

  private

  attr_reader :course, :between_dates

  def serialized_sections
    course.sections.map do |section|
      SectionSerializer.as_json(section, between_dates)
    end
  end
end
