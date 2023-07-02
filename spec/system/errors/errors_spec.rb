require 'rails_helper'

describe 'GET 500' do
  it 'displays the page' do
    visit('/500.html')
    expect(page).to have_content('We\'re sorry, but something went wrong.')
  end
end
