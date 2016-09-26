Given /a user named '([^']+)' exists$/ do |user_name|
  FactoryGirl.create(:user, username: user_name)
end

Given /^a course named '([^']+)' exists$/ do |course_name|
  @course = FactoryGirl.create(:course, title: course_name)
end

Given /^a section named '([^']+)' exists$/ do |section_name|
  @section = FactoryGirl.create(:section, title: section_name, course: @course)
end

Given /^the following lessons exist:$/ do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:lesson, title: hash[:lesson_name], section: @section)
  end
end

Given /^I am logged in$/ do
  @user = FactoryGirl.create(:user)
  log_in @user
end

Given /I go to the '([^']+)' course/ do |course_name|
  course_link_text = "#{Course.count}: #{course_name}"
  click_link course_link_text
  expect(page).to have_content(@section.title)
end

Given /^no lessons are completed$/ do 
  within ".lc-percent-completion" do
    expect(page).to have_content('0% Completed')
  end
  
  @section.lessons.each do |lesson|
    within "#lc-id-#{lesson.id}" do
      expect(page).to have_css('a.lc-checkbox.lc-unchecked')
    end
  end
end

And /^the lesson '([^']+)' is completed$/ do |lesson_title|
  lesson = Lesson.find_by(title: lesson_title)
  within "#lc-id-#{lesson.id}" do
    page.find(:css, '.lc-checkbox.lc-unchecked').click
  end
end

When /^I (un)?mark the lesson '([^']+)'$/ do |unmark, lesson_title|
  @lesson = Lesson.find_by(title: lesson_title)
  within "#lc-id-#{@lesson.id}" do
    if unmark
      page.find(:css, '.lc-checkbox.lc-checked').click
    else
      page.find(:css, '.lc-checkbox.lc-unchecked').click
    end
  end
end

Then /^my progress should be (.+)$/ do |action|
  visit current_path
  within "#lc-id-#{@lesson.id}" do
    if action == 'saved'
      expect(page.has_selector? 'a.lc-checkbox.lc-checked').to be true
    else
      expect(page.has_selector? 'a.lc-checkbox.lc-unchecked').to be true
    end
  end
  
  # make sure the percentage completion gets increased
  within ".lc-percent-completion" do
    percent_completed = @course.percent_completed_by(@user).to_i
    expect(page).to have_content("#{percent_completed}% Completed")
  end
end
