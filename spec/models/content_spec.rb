require 'rails_helper'

RSpec.describe Content do
  it { is_expected.to belong_to(:lesson) }
  it { is_expected.to validate_presence_of(:body) }
end
