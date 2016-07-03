require 'capybara/rails'
require 'turnip'
require 'turnip/rspec'
require 'turnip/capybara'
Dir.glob("spec/**/*steps.rb"){ |f| load f , true }

Capybara.default_driver = :selenium
Capybara.ignore_hidden_elements = true
Capybara.run_server = false

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

SCREEN_SHOTS = "spec/tmp/screenshots"
