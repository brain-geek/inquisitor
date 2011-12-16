require File.join(File.dirname(__FILE__), '..', 'frontend.rb')

require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ffaker'

require 'machinist/data_mapper'
require 'sham'

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
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }  
end

Sham.define do
  url   { 'http://' + Faker::Lorem.words(2).join('_').downcase + '.com' }
  name  { Faker::Name.name }
end

Node.blueprint do
  url
  name
end
