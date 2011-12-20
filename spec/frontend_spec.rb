require File.join(File.dirname(__FILE__), 'spec_helper.rb')
require 'json'

describe "Basic frontend test" do
  include Rack::Test::Methods

  def app
    @app ||= Monitor
  end

  before do
    Node.all.destroy
  end  

  it "should respond to / and list all" do
    nodes = []
    5.times { nodes.push Node.make }
    Node.should_receive(:all).and_return(nodes)

    contacts = []
    3.times { contacts.push Contact.make }
    Contact.should_receive(:all).and_return(contacts)
    
    get '/'

    last_response.should be_ok

    nodes.each do |n|
      within "#nodes .element-#{n.id}" do |scope|
        scope.should contain n.name
        scope.should contain n.url
        scope.should have_selector("td[rel='status/#{n.id}']")
      end
    end

    contacts.each do |n|
      within "#contacts .element-#{n.id}" do |scope|
        scope.should contain n.email
      end
    end      
  end

  it "should respond with service status" do 
    n = Node.make
    n.should_receive(:check).and_return(:up)
    n.should_receive(:last_log).and_return('best log in the world')

    Node.should_receive(:get).with(n.id).and_return(n)

    get "/status/#{n.id}"

    resp = JSON.parse(response.body)
    resp['status'].should == 'up'
    resp['log'].should == 'best log in the world'
  end

  it "should create node at /new_node" do 
    test_new(Node)
  end

  it "should create contact at /new_contact" do 
    test_new(Contact)
  end

  private
  def test_new(cls)
    attrs = cls.make_unsaved.attributes
    cls.first(attrs).should be_nil
    post "/new_#{cls.to_s.downcase}", cls.to_s.downcase => attrs

    last_response.should be_redirect
    cls.first(attrs).should_not be_nil
  end
end
