require 'rails_helper'

RSpec.describe 'Admin V2 Dashboard' do
  it 'displays the admin v2 dashboard' do
    visit admin_v2_root_path

    expect(page).to have_content('Welcome to the Admin V2 Dashboard')
  end
end
