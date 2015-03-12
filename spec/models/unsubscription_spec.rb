require 'spec_helper'

describe Unsubscription do
  let!(:user)  { FactoryGirl.create(:user) }
  let!(:category1) { FactoryGirl.create(:email_campaign_category) }
  let!(:category2) { FactoryGirl.create(:email_campaign_category) }
  let!(:category3) { FactoryGirl.create(:email_campaign_category) }
  let!(:category4) { FactoryGirl.create(:email_campaign_category) }


  it "is not valid without user id" do
    u = Unsubscription.new
    u.email_campaign_category_id = category1.id
    expect(u.valid?).to be_false
  end

  it "is not valid without email_campaign_category id" do
    u = Unsubscription.new
    u.user_id = user.id
    expect(u.valid?).to be_false
  end

  it "does not create duplicate unsubscriptions" do
    2.times do 
      Unsubscription.create(user_id: user.id, email_campaign_category_id: category1.id)
    end
    expect(user.unsubscriptions.count).to eq(1)
  end
end
