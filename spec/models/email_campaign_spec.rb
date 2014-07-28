require 'spec_helper'

describe EmailCampaign do

  it "must have a name" do
    anon = EmailCampaign.new
    anon.method_name = "Mailer.method"
    expect(anon.valid?).to eq false
  end

  it "must have a unique name" do
    original = EmailCampaign.new
    original.name = "One"
    original.method_name = "Mailer.one" 
    original.save
    copy = EmailCampaign.new
    copy.name = "One"
    copy.method_name = "Mailer.two"
    expect(copy.valid?).to eq false
  end

  it "must have a method name" do
    useless = EmailCampaign.new
    useless.name = "Useless"
    expect(useless.valid?).to eq false
  end

  it "must have a unique method name" do
    original = EmailCampaign.new
    original.name = "One" 
    original.method_name = "Mailer.one"
    original.save
    copy = EmailCampaign.new
    copy.name = "Two"
    copy.method_name = "Mailer.one"
    expect(copy.valid?).to eq false
  end  
end
