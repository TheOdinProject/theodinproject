require 'rails_helper'

RSpec.describe Flags::ActionFactory do
  describe '#action' do
    subject { described_class.for(action) }

    context "when action is 'dismiss'" do
      let(:action) { :dismiss }

      it { is_expected.to eq(Flags::Actions::Dismiss) }
    end

    context "when action is 'ban'" do
      let(:action) { :ban }

      it { is_expected.to eq(Flags::Actions::Ban) }
    end

    context "when action is 'removed_project_submission'" do
      let(:action) { :removed_project_submission }

      it { is_expected.to eq(Flags::Actions::RemoveProjectSubmission) }
    end

    context "when action is 'notified_user'" do
      let(:action) { :notified_user }

      it { is_expected.to eq(Flags::Actions::NotifyUser) }
    end

    context 'when action is unknown' do
      let(:action) { :unknown_action }

      it { is_expected.to eq(Flags::Actions::NullAction) }
    end
  end
end
