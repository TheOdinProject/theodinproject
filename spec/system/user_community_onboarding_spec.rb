require 'rails_helper'

RSpec.describe 'user community onboarding steps', type: :system do
  it 'displays each step correctly as steps are completed' do
    sign_in(create(:user))
    visit dashboard_path

    expect(find(:test_id, 'current-step-1')).to have_text('Community Rules')
    expect(find(:test_id, 'incomplete-step-2')).to have_text('How to Help Yourself Before Asking Others')
    expect(find(:test_id, 'incomplete-step-3')).to have_text('How to Ask Technical Questions')
    expect(find(:test_id, 'incomplete-step-4')).to have_text('Additional Community Expectations')

    visit community_rules_path
    find(:checkbox, 'user[community_onboarding_steps][step_one]', checked: false, visible: :hidden).trigger('click')
    find('input[type=submit]').click

    expect(page).to have_current_path(dashboard_path)
    expect(find(:test_id, 'complete-step-1')).to have_text('Community Rules')
    expect(find(:test_id, 'current-step-2')).to have_text('How to Help Yourself Before Asking Others')
    expect(find(:test_id, 'incomplete-step-3')).to have_text('How to Ask Technical Questions')
    expect(find(:test_id, 'incomplete-step-4')).to have_text('Additional Community Expectations')

    visit before_asking_path
    find(:checkbox, 'user[community_onboarding_steps][step_two]', checked: false, visible: :hidden).trigger('click')
    find('input[type=submit]').click

    expect(page).to have_current_path(dashboard_path)
    expect(find(:test_id, 'complete-step-1')).to have_text('Community Rules')
    expect(find(:test_id, 'complete-step-2')).to have_text('How to Help Yourself Before Asking Others')
    expect(find(:test_id, 'current-step-3')).to have_text('How to Ask Technical Questions')
    expect(find(:test_id, 'incomplete-step-4')).to have_text('Additional Community Expectations')

    visit how_to_ask_path
    find(:checkbox, 'user[community_onboarding_steps][step_three]', checked: false, visible: :hidden).trigger('click')
    find('input[type=submit]').click

    expect(page).to have_current_path(dashboard_path)
    expect(find(:test_id, 'complete-step-1')).to have_text('Community Rules')
    expect(find(:test_id, 'complete-step-2')).to have_text('How to Help Yourself Before Asking Others')
    expect(find(:test_id, 'complete-step-3')).to have_text('How to Ask Technical Questions')
    expect(find(:test_id, 'current-step-4')).to have_text('Additional Community Expectations')

    visit community_expectations_path
    find(:checkbox, 'user[community_onboarding_steps][step_four]', checked: false, visible: :hidden).trigger('click')
    find('input[type=submit]').click

    expect(page).to have_current_path(dashboard_path)
    expect(find(:test_id, 'complete-step-1')).to have_text('Community Rules')
    expect(find(:test_id, 'complete-step-2')).to have_text('How to Help Yourself Before Asking Others')
    expect(find(:test_id, 'complete-step-3')).to have_text('How to Ask Technical Questions')
    expect(find(:test_id, 'complete-step-4')).to have_text('Additional Community Expectations')
  end
end
