ENV['ENVIRONMENT'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app/app.rb')
require 'capybara'
require 'capybara/rspec'
require 'rake'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require_relative 'support/database_helpers'
require_relative 'support/authentication_helpers'


Capybara.app = BookmarkManager

Rake.application.load_rakefile

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start


RSpec.configure do |config|
  config.before(:each) do
    Rake::Task['setup_test_database'].execute
  end
end
