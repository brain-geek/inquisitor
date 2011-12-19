require File.dirname(__FILE__) + '/spec_helper'

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
    5.times do 
      node = Node.make
      node.should_receive(:check).and_return(node.id.odd? ? :up : :down)
      nodes.push node
    end
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
        scope.should contain(n.id.odd? ? 'up' : 'down')
      end
    end

    contacts.each do |n|
      within "#contacts .element-#{n.id}" do |scope|
        scope.should contain n.email
      end
    end      
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
    cls.count(attrs).should == 0
    post "/new_#{cls.to_s.downcase}", cls.to_s.downcase => attrs

    last_response.should be_redirect
    cls.count(attrs).should == 1
  end
end
