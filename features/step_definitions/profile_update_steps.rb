Given(/^The course page with (.+)$/) do |course_page|
	@course = FactoryGirl.create(:course, title: course_page)
end

When(/^I should see the edit user page$/) do
	visit '/users/'
end

Then(/^I have user email (.+)$/) do |user_email|
  FactoryGirl.create(:user, email: user_email)
end

Then(/^I have user username (.+)$/) do |user_name|
  FactoryGirl.create(:user, username: user_name)
end

Then(/^I have user skype (.+)$/) do |user_skype|
  FactoryGirl.create(:user, skype: user_skype)
end

Then(/^I have user facebook (.+)$/) do |user_facebook|
	FactoryGirl.create(:user, facebook: user_facebook)
end

Then(/^I have user twitter (.+)$/) do |user_twitter|
	FactoryGirl.create(:user, twitter: user_twitter)
end

Then(/^I have user linkedin (.+)$/) do |user_linkdein|
	FactoryGirl.create(:user, linkedin: user_linkdein)
end

Then(/^I have user github (.+)$/) do |user_github|
	FactoryGirl.create(:user, github: user_github)
end

Then(/^I have user google_plus (.+)$/) do |user_googlePlus|
	FactoryGirl.create(:user, google_plus: user_googlePlus)
end

# updating the user profile with right details
Given(/^When l press edit$/) do
	click_link('Edit')
end

When(/^I enter "([^"]*)" in the "([^"]*)" field$/) do |arg1, arg2|
	fill_in(arg1, :with => arg2)
end

Then(/^I press the update button$/) do
	click_link('Update')
end

Then(/^I see Your profile was updated successfully$/) do
	expect(page.body).
    to include('Your profile was updated successfully')
end
