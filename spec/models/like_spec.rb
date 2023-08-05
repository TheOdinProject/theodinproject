require 'rails_helper'

RSpec.describe Like do
  subject { create(:like) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:likeable).counter_cache(true) }

  it { is_expected.to validate_presence_of(:likeable_type) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(%i[likeable_id likeable_type]) }

  describe '.created_today' do
    it 'returns likes created today' do
      first_like_created_today = create(:like, created_at: Time.zone.today)
      second_like_created_today = create(:like, created_at: Time.zone.today)
      like_not_created_today = create(:like, created_at: Time.zone.today - 2.days)

      expect(described_class.created_today).to contain_exactly(
        first_like_created_today,
        second_like_created_today
      )
    end
  end
end
