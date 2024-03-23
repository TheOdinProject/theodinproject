require 'rails_helper'

RSpec.describe 'Generating Test Admins' do
  subject { described_class.as_json(course, between_dates) }

  context 'when development environment' do
    before do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
    end

    it 'creates test admins' do
      load './db/seeds/test_admins.rb'
      expect(User.count).to be > 1
    end
  end

  context 'when staging environment' do
    around do |example|
      Dotenv.modify(
        STAGING: 'true'
      ) do
        example.run
      end
    end

    it 'creates test admins' do
      load './db/seeds/test_admins.rb'
      expect(User.count).to be > 1
    end

    it 'creates an admin user' do
      load './db/seeds/test_admins.rb'
      expect(AdminUser.count).to eq(1)
    end
  end

  context 'when production environment' do
    before do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
    end

    it 'does not create any test admins' do
      load './db/seeds/test_admins.rb'
      expect(User.count).to eq(0)
    end

    it 'does not create any test admin users' do
      load './db/seeds/test_admins.rb'
      expect(AdminUser.count).to eq(0)
    end
  end
end
