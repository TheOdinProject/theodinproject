require 'rails_helper'

RSpec.describe Reports::UserSignUpsDayStat do
  describe '.for_date_range' do
    it 'returns all user sign up stats for the given date range' do
      create(:user, created_at: Time.utc(2022, 1, 1))
      create(:user, created_at: Time.utc(2022, 1, 2))
      create(:user, created_at: Time.utc(2022, 1, 3))
      create(:user, created_at: Time.utc(2022, 1, 4))

      described_class.refresh

      expect(described_class.for_date_range('2022-01-01', '2022-01-02').map(&:date))
        .to contain_exactly(Time.utc(2022, 1, 1), Time.utc(2022, 1, 2))
    end
  end

  describe '.group_by_period' do
    it 'returns all user sign up stats grouped by month' do
      create(:user, created_at: Time.utc(2022, 1, 1))
      create(:user, created_at: Time.utc(2022, 2, 2))
      create(:user, created_at: Time.utc(2022, 1, 4))

      described_class.refresh

      expect(described_class.group_by_period('month')).to eq(
        {
          Time.utc(2022, 1, 1) => 2,
          Time.utc(2022, 2, 1) => 1
        }
      )
    end

    it 'returns all user sign up stats grouped by day' do
      create(:user, created_at: Time.utc(2022, 1, 1))
      create(:user, created_at: Time.utc(2022, 1, 2))
      create(:user, created_at: Time.utc(2022, 1, 2))

      described_class.refresh

      expect(described_class.group_by_period('day')).to eq(
        {
          Time.utc(2022, 1, 1) => 1,
          Time.utc(2022, 1, 2) => 2
        }
      )
    end
  end

  describe '.earliest_date' do
    it 'returns the earliest user sign up day stat' do
      create(:user, created_at: Time.utc(2022, 1, 1))
      create(:user, created_at: Time.utc(2022, 2, 1))
      create(:user, created_at: Time.utc(2022, 3, 1))

      described_class.refresh

      expect(described_class.earliest_date).to eq(Time.utc(2022, 1, 1))
    end

    context 'when there are no user sign ups' do
      it 'defaults to today' do
        described_class.refresh
        expect(described_class.earliest_date).to eq(Time.zone.today)
      end
    end
  end

  describe '.latest_date' do
    it 'returns the earliest user sign up day stat' do
      create(:user, created_at: Time.utc(2022, 1, 1))
      create(:user, created_at: Time.utc(2022, 2, 1))
      create(:user, created_at: Time.utc(2022, 3, 1))

      described_class.refresh

      expect(described_class.latest_date).to eq(Time.utc(2022, 3, 1))
    end

    context 'when there are no user sign ups' do
      it 'defaults to today' do
        described_class.refresh
        expect(described_class.latest_date).to eq(Time.zone.today)
      end
    end
  end
end
