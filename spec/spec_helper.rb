require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ffaker'
require File.join(File.dirname(__FILE__), '..', 'lib', 'monit.rb')

Monit::Web.set :environment, :test

Webrat.configure do |config|
  config.mode= :rack
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  # config.before(:all)    { Sham.reset(:before_all)  }
  # config.before(:each)   { Sham.reset(:before_each) }  
end

require File.join(File.dirname(__FILE__), 'support/blueprints.rb')
