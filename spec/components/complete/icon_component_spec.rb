require 'rails_helper'

RSpec.describe Complete::IconComponent, type: :component do
  let(:user) { create(:user) }

  it 'renders the icon button with the lesson complete state' do
    lesson = create(:lesson, :complete)
    component = described_class.new(lesson:, current_user: user)

    render_inline(component)

    expect(page).to have_css('[data-complete="true"]')
  end

  it 'renders the icon button with lesson incomplete state' do
    lesson = create(:lesson, :incomplete)
    component = described_class.new(lesson:, current_user: user)

    render_inline(component)

    expect(page).to have_css('[data-complete="false"]')
  end
end
