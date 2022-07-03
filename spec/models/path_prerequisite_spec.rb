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
require 'rails_helper'

RSpec.describe PathPrerequisite do
  subject { create(:path_prerequisite) }

  it { is_expected.to belong_to(:path) }
  it { is_expected.to belong_to(:prerequisite).class_name('Path') }

  it { is_expected.to validate_uniqueness_of(:prerequisite_id).scoped_to(:path_id) }
end
