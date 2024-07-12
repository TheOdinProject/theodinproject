require 'rails_helper'

RSpec.describe Forms::DatePickerComponent, type: :component do
  context 'when min is smaller than the value of the date picker' do
    it 'renders the date picker with the min date' do
      component = described_class.new(name: 'date', value: '2021-01-01', min: '2020-01-01')

      render_inline(component)

      expect(page).to have_css("[data-date-picker-min-value='2020-01-01']")
    end
  end

  context 'when min is larger than the value of the date picker' do
    it 'renders the date picker with the value as the min date' do
      component = described_class.new(name: 'date', value: '2021-01-01', min: '2022-01-01')

      render_inline(component)

      expect(page).to have_css("[data-date-picker-min-value='2021-01-01']")
    end
  end

  context 'when max argument is present' do
    it 'renders the date picker with max as the max date' do
      component = described_class.new(name: 'date', value: '2021-01-01', max: '2023-01-01')

      render_inline(component)

      expect(page).to have_css("[data-date-picker-max-value='2023-01-01']")
    end
  end

  context 'when max argument is not present' do
    it 'renders the date picker with today as the max date' do
      travel_to Time.zone.local(2022, 1, 2) do
        component = described_class.new(name: 'date', value: '2022-01-01')
        render_inline(component)

        expect(page).to have_css("[data-date-picker-max-value='2022-01-02']")
      end
    end
  end
end
