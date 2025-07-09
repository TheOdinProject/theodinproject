require 'rails_helper'

RSpec.describe 'Admin learners' do
  before do
    sign_in(create(:admin_user))

    create(:user, username: 'John', email: 'john@email.com')
    create(:user, username: 'Jane', email: 'jane@email.com')
  end

  it 'can search for learners' do
    visit admin_learners_path

    fill_in 'search_term', with: 'John'

    within(:test_id, 'learners-list') do
      expect(page).to have_content('John')
      expect(page).not_to have_content('Jane')
    end
  end

  it 'can delete a learner' do
    visit admin_learners_path

    within(:test_id, 'learners-list') do
      click_on 'John'
    end

    accept_confirm { find(:test_id, 'delete-button').click }
    expect(page).to have_content('Learner deleted')

    within(:test_id, 'learners-list') do
      expect(page).not_to have_content('John')
    end
  end
end
