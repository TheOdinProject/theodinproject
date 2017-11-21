require 'rails_helper'

RSpec.describe MailchimpSubscription do
  let(:email) { 'kevin@fizbaz.com' }
  let(:username) { 'kevin' }
  let(:signup_date) { Date.new }
  let(:options) do
    {
      email: email,
      username: username,
      signup_date: signup_date
    }
  end
  let(:list_id) { ENV['MAILCHIMP_LIST_ID'] }

  describe '.create' do
    it 'creates and returns a new instance', :vcr do
      mailchimp_remove_member(email, list_id)
      mcs = MailchimpSubscription.create(options)
      expect(mcs).to be_an_instance_of(MailchimpSubscription)
    end

    it 'calls create on the instance' do
      mcs = MailchimpSubscription.new(options)
      allow(MailchimpSubscription).to receive(:new).and_return(mcs)
      expect(mcs).to receive(:create)
      MailchimpSubscription.create(options)
    end
  end

  describe '#create' do
    it 'creates a mailchimp subscription with the initialized parameters', :vcr do
      mailchimp_remove_member(email, list_id)
      MailchimpSubscription.new(options).create
      expect(mailchimp_member_exists?(email, list_id)).to eq(true)
    end
  end
end
