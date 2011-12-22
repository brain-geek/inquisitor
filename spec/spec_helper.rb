require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ffaker'
require File.join(File.dirname(__FILE__), '..', 'lib', 'monit.rb')

RSpec.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }  
end

Monit.settings.db_path = "sqlite3://#{Dir.pwd}/test.db"

require File.join(File.dirname(__FILE__), 'support/blueprints.rb')
