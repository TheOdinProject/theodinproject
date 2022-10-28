require 'rails_helper'

RSpec.describe LessonPreview, type: :model do
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(70_000) }
end
