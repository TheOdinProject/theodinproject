require 'rails_helper'

RSpec.shared_examples 'authenticatable_with_two_factor' do |factory|
  let(:record) { create(factory, :pending) }

  describe '#generate_two_factor_secret_if_missing!' do
    context 'when the otp secret is not present' do
      it 'generates a new otp secret' do
        record.otp_secret = nil
        expect { record.generate_two_factor_secret_if_missing! }.to change { record.otp_secret }
      end
    end

    context 'when the otp secret is present' do
      it 'does not generate a new otp secret' do
        record.otp_secret = 'secret'
        expect { record.generate_two_factor_secret_if_missing! }.not_to change { record.otp_secret }
      end
    end
  end

  describe '#two_factor_qr_code_uri' do
    it 'returns a two factor qr code uri' do
      expect(record.two_factor_qr_code_uri).to match(%r{otpauth://totp})
    end
  end

  describe '#enable_two_factor!' do
    it 'enables two factor authentication' do
      expect { record.enable_two_factor! }.to change { record.otp_required_for_login }.from(false).to(true)
    end
  end

  describe '#two_factor_enabled?' do
    context 'when two factor authentication is enabled' do
      it 'returns true' do
        record.otp_required_for_login = true
        expect(record.two_factor_enabled?).to be(true)
      end
    end

    context 'when two factor authentication is not enabled' do
      it 'returns false' do
        record.otp_required_for_login = false
        expect(record.two_factor_enabled?).to be(false)
      end
    end
  end

  describe '#reset_two_factor!' do
    it 'resets two factor authentication attributes' do
      record.otp_required_for_login = true
      record.otp_secret = 'secret'
      record.consumed_timestep = 1

      expect { record.reset_two_factor! }
        .to change { record.otp_required_for_login }.from(true).to(false)
        .and change { record.otp_secret }.from('secret').to(nil)
        .and change { record.consumed_timestep }.from(1).to(nil)
    end
  end
end
