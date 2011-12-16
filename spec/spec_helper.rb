require File.join(File.dirname(__FILE__), '..', 'frontend.rb')

require 'rubygems'
require 'rack/test'
require 'rspec'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
