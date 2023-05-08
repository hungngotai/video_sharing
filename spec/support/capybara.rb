Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  %w[
    incognito
    disable-extensions
    auto-open-devtools-for-tabs
    window-size=1920,1080
  ].each { options.add_argument _1 }

  %w[
    headless
    disable-gpu
  ].each { options.add_argument _1 } if %w[1 on true].include?(ENV['HEADLESS'])

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome
