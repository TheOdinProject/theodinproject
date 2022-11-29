require 'rails_helper'

RSpec.describe Oauth::ConnectButtonComponent, type: :component do
  it 'renders a oauth provider connect button' do
    component = described_class.new(provider: :github, resource_name: 'user')

    render_inline(component)

    expect(page).to have_content('Sign in with Github')
  end
end
