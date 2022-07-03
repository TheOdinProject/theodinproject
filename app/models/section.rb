# == Schema Information
#
# Table name: sections
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  position        :integer          not null
#  course_id       :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :text
#  identifier_uuid :string           default(""), not null
#
class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, -> { order(:position) }, inverse_of: :section, dependent: :destroy

  validates :position, presence: true
end
