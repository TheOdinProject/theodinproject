require 'rails_helper'

RSpec.describe SubmissionLikePolicy do
  describe '#allowed?' do
    context 'when there are recent accounts with the same ip' do
      it 'cannot like the project submission' do
        user = create(:user, current_sign_in_ip: '127.0.0.1')
        create(:user, last_sign_in_ip: user.current_sign_in_ip)

        policy = described_class.new(user)

        expect(policy.allowed?).to be(false)
      end
    end

    context 'when there are no recent accounts with the same ip' do
      it 'can like the project submission' do
        user = create(:user)

        policy = described_class.new(user)

        expect(policy.allowed?).to be(true)
      end
    end

    context 'when the user has project submissions' do
      it 'can like the project submission normally' do
        user = create(:user)
        create(:project_submission, user_id: user.id)

        policy = described_class.new(user)

        expect(policy.allowed?).to be(true)
      end

      it 'can like the project submission despite recent accounts with the same ip' do
        user = create(:user, current_sign_in_ip: '127.0.0.1')
        create(:project_submission, user_id: user.id)
        create(:user, last_sign_in_ip: user.current_sign_in_ip)

        policy = described_class.new(user)

        expect(policy.allowed?).to be(true)
      end
    end
  end
end
