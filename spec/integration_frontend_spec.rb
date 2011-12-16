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
    node = Node.make_unsaved.attributes
    visit '/'
    response_body.should contain 'Simple monitoring index page'
    Node.count(node).should == 0

    fill_in "add-name-field", :with => node[:name]
    fill_in "add-url-field", :with => node[:url]
    click_button "Send"  

    Node.count(node).should == 1
  end
end
