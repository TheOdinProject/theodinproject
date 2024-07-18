require 'rails_helper'

RSpec.describe Like do
  subject { create(:like) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:likeable).counter_cache(true) }

  it { is_expected.to validate_presence_of(:likeable_type) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(%i[likeable_id likeable_type]) }

  describe '.liked_on' do
    it 'returns likes created on a given date' do
      first_like_created_yesterday = create(:like, created_at: Time.zone.yesterday)
      second_like_created_yesterday = create(:like, created_at: Time.zone.yesterday)
      create(:like, created_at: Time.zone.today)
      create(:like, created_at: Time.zone.tomorrow)

      expect(described_class.liked_on(Time.zone.yesterday)).to contain_exactly(
        first_like_created_yesterday,
        second_like_created_yesterday
      )
    end
  end
end
