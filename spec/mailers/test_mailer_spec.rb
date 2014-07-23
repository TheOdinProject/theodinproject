require "spec_helper"

describe TestMailer do

  describe 'email_one_person' do

    before :each do
      category = EmailCampaignCategory.new
      category.name = "Testing"
      category.save
      campaign = EmailCampaign.new
      campaign.name = "Test"
      campaign.method_name = "TestMailer.email_one_person"
      campaign.email_campaign_category = category
      campaign.save
      FactoryGirl.create(:user, :email => "foo@bar.com")
      TestMailer.email_one_person
      @mail = ActionMailer::Base.deliveries.last
    end

    it "sends an email" do
      @mail.should_not be_nil
    end

    it "has X-SMTPAPI header" do
      @mail.header['X-SMTPAPI'].value.should_not be_nil
    end

    it "formats recipients address correctly" do
      @mail.header['X-SMTPAPI'].value.should eq('{"to":["foo@bar.com"]}')
    end

    it "records the email after it is sent" do
      expect(SentEmail.last.user).to eq(User.last)
    end

    describe "check campaign" do
      #  "Happy path" covered above 
      #  Email should be delivered if it belongs to a campaign and category.

      it "alerts if email doesn't belong to campaign" do
        EmailCampaign.destroy_all
        expect { TestMailer.email_one_person }.to raise_error(TestMailer::NoCampaignError) 
      end

      it "alerts if email campaign doesn't belong to category" do
        campaign = EmailCampaign.new
        campaign.name = "Test"
        campaign.method_name = "TestMailer.email_one_person"
        campaign.save
        EmailCampaignCategory.destroy_all
        expect { TestMailer.email_one_person }.to raise_error(TestMailer::NoCampaignCategoryError)
      end
    end 


  end

end
