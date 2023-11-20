require 'rails_helper'

RSpec.shared_examples 'likeable' do |factory|
  let(:record) { create(factory) }

  it { is_expected.to have_many(:likes).dependent(:destroy) }
  it { is_expected.to respond_to(:likes_count) }

  describe '#liked_by?' do
    context 'when the record is liked by the user' do
      it 'returns true' do
        user = create(:user)
        record.like(user)

        expect(record.liked_by?(user)).to be(true)
      end
    end

    context 'when the record is not liked by the user' do
      it 'returns true' do
        user = create(:user)

        expect(record.liked_by?(user)).to be(false)
      end
    end
  end

  describe '#like' do
    it 'creats a like for the record' do
      user = create(:user)

      expect { record.like(user) }.to change { record.likes.count }.by(1)
    end

    it 'marks the record as liked' do
      user = create(:user)

      expect { record.like(user) }.to change { record.liked }.from(false).to(true)
    end
  end

  describe '#unlike' do
    it 'remove a like from the record' do
      user = create(:user)
      record.like(user)

      expect { record.unlike(user) }.to change { record.likes.count }.by(-1)
    end

    it 'marks the record as unliked' do
      user = create(:user)
      record.like(user)

      expect { record.unlike(user) }.to change { record.liked }.from(true).to(false)
    end
  end

  describe '#liked' do
    it 'return false by default' do
      expect(record).not_to be_liked
    end

    context 'when the record is liked' do
      it 'returns true' do
        record.liked = true

        expect(record).to be_liked
      end
    end

    context 'when the record is not liked' do
      it 'returns false' do
        record.liked = false

        expect(record).not_to be_liked
      end
    end
  end

  describe '#liked!' do
    it 'marks the record as liked' do
      expect { record.liked! }.to change { record.liked }.from(false).to(true)
    end
  end

  describe '#unliked!' do
    it 'marks the record as unliked' do
      record.liked = true

      expect { record.unliked! }.to change { record.liked }.from(true).to(false)
    end
  end
end
