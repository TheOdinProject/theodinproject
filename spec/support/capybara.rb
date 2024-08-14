Capybara.default_max_wait_time = 5
Capybara.default_normalize_ws = true
Capybara.save_path = File.expand_path(ENV.fetch('CAPYBARA_ARTIFACTS', './tmp/capybara'))
Capybara.disable_animation = true

Capybara.configure do |config|
  puts '*' * 100
  # p ENV['TEST_ENV_NUMBER'].to_i
  config.test_id = 'data-test'
  config.automatic_label_click = true
  config.server_port = 3001
  config.app_host = "http://localhost:#{config.server_port}"
end

Capybara.singleton_class.prepend(Module.new do
  attr_accessor :last_used_session

  def using_session(name, &)
    self.last_used_session = name
    super
  ensure
    self.last_used_session = nil
  end
end)

Capybara.add_selector(:test_id) do
  css { |value| "[data-test-id='#{value}']" }
end

Capybara.add_selector(:test_project_submission) do
  xpath do |num|
    ".//div[@data-test-id='submission-item'][#{num}]"
  end
end

def wait_for_turbo_frame(selector = 'turbo-frame', timeout = nil)
  if has_selector?("#{selector}[busy]", visible: true, wait: 0.25.seconds)
    has_no_selector?("#{selector}[busy]", wait: timeout.presence || 5.seconds)
  end

  yield if block_given?
end
