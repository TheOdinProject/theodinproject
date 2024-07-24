require 'rails_helper'

RSpec.describe QrCodeHelper do
  describe '#qr_code_as_svg' do
    it 'returns an svg representation of a qr code' do
      expect(helper.qr_code_as_svg('https://www.theodinproject.com'))
        .to match_snapshot('qr_code_helper/qr_code_svg')
    end
  end
end
