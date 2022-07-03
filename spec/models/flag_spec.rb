# == Schema Information
#
# Table name: flags
#
#  id                    :bigint           not null, primary key
#  flagger_id            :integer          not null
#  project_submission_id :bigint           not null
#  reason                :text             default(""), not null
#  status                :integer          default("active"), not null
#  taken_action          :integer          default("pending"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  resolved_by_id        :integer
#
require 'rails_helper'

RSpec.describe Flag do
  subject(:flag) { described_class.new }

  it { is_expected.to belong_to(:flagger) }
  it { is_expected.to belong_to(:project_submission) }

  it { is_expected.to validate_presence_of(:reason) }
  it { is_expected.to define_enum_for(:status).with_values(%i[active resolved]) }

  it do
    expect(flag).to define_enum_for(:taken_action)
      .with_values(%i[pending dismiss ban removed_project_submission notified_user])
  end
end
