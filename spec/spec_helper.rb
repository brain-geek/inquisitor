require File.join(File.dirname(__FILE__), '..', 'frontend.rb')

require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ruby-debug' if RUBY_VERSION < '1.9'
require 'ffaker'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

db_path = "sqlite3://#{Dir.pwd}/test.db"

File.delete(db_path) if File.exist?(db_path)
DataMapper.setup(:default, db_path)
DataMapper.auto_upgrade!

Webrat.configure do |config|
  config.mode= :rack
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
end
