# == Schema Information
#
# Table name: path_prerequisites
#
#  id              :bigint           not null, primary key
#  path_id         :bigint           not null
#  prerequisite_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class PathPrerequisite < ApplicationRecord
  belongs_to :path
  belongs_to :prerequisite, class_name: 'Path'

  validates :prerequisite_id, uniqueness: { scope: :path_id }
end
