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
require 'rails_helper'

RSpec.describe Section do
  subject { described_class.new }

  it { is_expected.to belong_to(:course) }
  it { is_expected.to have_many(:lessons).order(:position) }

  it { is_expected.to validate_presence_of(:position) }
end
