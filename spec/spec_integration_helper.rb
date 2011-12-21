require File.join(File.dirname(__FILE__), 'spec_helper.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'monit', 'web.rb')

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.before{ Monit::Node.all.destroy }
end

Webrat.configure do |config|
  config.mode= :rack
end

Monit::Web.set :environment, :test