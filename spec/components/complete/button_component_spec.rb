require 'rails_helper'

RSpec.describe Complete::ButtonComponent, type: :component do
  it 'renders the button with the lesson complete state' do
    lesson = create(:lesson, :complete)
    component = described_class.new(lesson:)

    render_inline(component)

    expect(page).to have_button('Lesson Completed')
  end

  it 'renders the button with lesson incomplete state' do
    lesson = create(:lesson, :incomplete)
    component = described_class.new(lesson:)

    render_inline(component)

    expect(page).to have_button('Mark Complete')
  end
end
