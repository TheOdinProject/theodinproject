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

  describe '#unsubscribe' do

    it 'does not create duplicate unsubscriptions' do
      Unsubscription.unsubscribe(user, [category1.name])
      expect{
        Unsubscription.unsubscribe(user, [category1.name])
      }.to change{Unsubscription.count}.by(0)
    end

    it "creates one new unsubscription" do
      expect { 
        Unsubscription.unsubscribe(user, [category2.name])
        }.to change{Unsubscription.count}.by(1)
    end

    it "creates multiple unsubscriptions" do
      expect { 
        Unsubscription.unsubscribe(user, [category3.name, category4.name])
        }.to change{Unsubscription.count}.by(2)
    end

    it "creates multiple unsubscriptions without duplicates" do
      Unsubscription.create(user_id: user.id, email_campaign_category_id: category1.id)
      expect { 
        Unsubscription.unsubscribe(user, [category1.name, category3.name, category4.name])
        }.to change{Unsubscription.count}.by(2)
    end
  end

  describe '#category_names' do

    it "returns an array with a single email_campaign_category name" do
      Unsubscription.create(user_id: user.id, email_campaign_category_id: category1.id)
      list = Unsubscription.category_names(user.unsubscriptions)
      expect(list).to eq([category1.name])
      expect(list.kind_of?(Array)).to be true
    end            

    it "returns array of email_campaign_category names" do
      Unsubscription.create(user_id: user.id, email_campaign_category_id: category1.id)
      Unsubscription.create(user_id: user.id, email_campaign_category_id: category2.id)
      list = Unsubscription.category_names(user.unsubscriptions)
      expect(list).to eq([category1.name, category2.name])
    end
  end
end
