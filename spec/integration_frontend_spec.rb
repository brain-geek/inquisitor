require File.dirname(__FILE__) + '/spec_helper'

describe "Basic frontend test", :type => :request do
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    @app ||= Sinatra::Application
  end

  before do
    Node.all.destroy
  end

  it "should create at /new" do 
    name = Faker::Name.name
    visit '/'
    response_body.should contain 'Simple monitoring index page'
    Node.count(:name => 'Sample name', :url => 'http://google.com').should == 0

    fill_in "add-name-field", :with => 'Sample name'
    fill_in "add-url-field", :with => 'http://google.com'
    click_button "Send"  

    Node.count(:name => 'Sample name', :url => 'http://google.com').should == 1
  end
end
