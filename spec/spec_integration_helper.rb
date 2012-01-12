require File.join(File.dirname(__FILE__), 'spec_helper.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'inquisitor', 'web.rb')

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.before{ Inquisitor::Node.all.destroy }
end

Webrat.configure do |config|
  config.mode= :rack
end

Inquisitor::Web.set :environment, :test