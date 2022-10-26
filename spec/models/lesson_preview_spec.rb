require 'rails_helper'

RSpec.describe LessonPreview, type: :model do
  it { is_expected.to validate_presence_of(:content) }
end
