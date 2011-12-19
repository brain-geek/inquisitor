require File.dirname(__FILE__) + '/spec_helper'

describe "Basic frontend test", :type => :request do
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    @app ||= Monitor
  end

  before do
    Node.all.destroy
  end

  it "should create node" do 
    node = Node.make_unsaved.attributes
    visit '/'
    Node.count(node).should == 0

    fill_in "add-name-field", :with => node[:name]
    fill_in "add-url-field", :with => node[:url]
    click_button "Add node"

    Node.count(node).should == 1
  end


  it "should create new contact" do 
    contact = Contact.make_unsaved.attributes
    visit '/'
    Contact.count(contact).should == 0

    fill_in "add-email-field", :with => contact[:email]
    click_button "Add contact"  

    Contact.count(contact).should == 1
  end

end
