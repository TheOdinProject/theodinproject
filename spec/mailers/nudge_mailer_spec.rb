require "spec_helper"

describe NudgeMailer do
  pending "add some examples to (or delete) #{__FILE__}"
end




# FROM UNSUBSCRIBE SPEC...
    #   before do
    #     link = @email.match(/href="(.*unsubscribe.*)"/)[1]
    #     visit link
    #   end


    # before do
    #   FactoryGirl.create(:email_campaign, 
    #     method_name: "inactive_one_month",
    #     email_campaign_category: EmailCampaignCategory.last)
    #   NudgeMailer.inactive_one_month
    #   @email = ActionMailer::Base.deliveries.last.encoded
    # end

    # specify "email has unsubscribe link" do
    #   expect(@email).to have_link('here') # "Click here to unsubscribe..."
    # end

    # specify "link takes user to generic unsubscribe page" do
    #   link = @email.match(/href="(.*unsubscribe.*)"/)[1]
    #   visit link
    #   expect(page).to have_selector('div', text: "Unsubscribe")
    # end
