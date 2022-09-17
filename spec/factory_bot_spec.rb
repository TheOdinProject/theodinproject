require 'rails_helper'

describe FactoryBot do
  it { described_class.lint traits: true } # rubocop: disable RSpec/NoExpectationExample
end
