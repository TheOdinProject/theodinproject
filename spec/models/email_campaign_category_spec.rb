require 'spec_helper'

describe EmailCampaignCategory do

  it "must have a name" do
    expect(EmailCampaignCategory.new).to have(1).error_on(:name)
  end

  it "must have a unique name" do
    FactoryGirl.create(:email_campaign_category, name: "One")
    duplicate = EmailCampaignCategory.new(name: "One")
    expect(duplicate).to have(1).error_on(:name)
  end

  it "must have a description" do
    expect(EmailCampaignCategory.new).to have(1).error_on(:description)
  end

  describe "#list" do
    before do
      FactoryGirl.create(:email_campaign_category, name: 'Marketing')
      FactoryGirl.create(:email_campaign_category, name: 'Newsletter')
      FactoryGirl.create(:email_campaign_category, name: 'Transactional')
      FactoryGirl.create(:email_campaign_category, name: 'transactional')
    end

    it 'returns list of categories without Transactional' do
      expect(EmailCampaignCategory.list).to eq([
        EmailCampaignCategory.find_by_name("Marketing"), 
        EmailCampaignCategory.find_by_name("Newsletter")
        ])
    end
  end
end
