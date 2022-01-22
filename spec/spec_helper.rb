ENV['ENVIRONMENT'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require_relative 'support/setup_test_database'
require_relative 'support/database_helpers'
require_relative 'support/authentication_helpers'


Capybara.app = BookmarkManager

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start


RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end
