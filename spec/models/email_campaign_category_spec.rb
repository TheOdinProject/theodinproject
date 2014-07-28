require 'spec_helper'

describe EmailCampaignCategory do

  it "must have a name" do
    category = EmailCampaignCategory.new
    expect(category.valid?).to eq false
  end

  it "must have a unique name" do
    original = EmailCampaignCategory.new
    original.name = "One" 
    original.save
    copy = EmailCampaignCategory.new
    copy.name = "One"
    expect(copy.valid?).to eq false
  end

end
