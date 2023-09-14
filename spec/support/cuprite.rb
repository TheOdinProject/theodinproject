require 'capybara/cuprite'

module CupriteHelpers
  def pause
    page.driver.pause
  end

  def debug(*)
    page.driver.debug(*)
  end
end

Capybara.register_driver(:odin_cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1200, 1200],
    browser_options: {},
    process_timeout: 30,
    timeout: 60,
    inspector: true,
    headless: !ENV['HEADLESS'].in?(%w[n 0 no false]),
    js_errors: true
  )
end

Capybara.default_driver = :odin_cuprite
Capybara.javascript_driver = :odin_cuprite

RSpec.configure do |config|
  config.prepend_before(:each, type: :system) do
    driven_by :odin_cuprite
  end

  config.include CupriteHelpers, type: :system
end
