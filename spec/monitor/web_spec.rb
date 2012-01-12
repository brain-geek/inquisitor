require File.join(File.dirname(__FILE__), '..', 'spec_integration_helper.rb')
require 'json'

describe "Basic frontend test" do
  def app
    @app ||= Monit::Web
  end

  it "should respond to / and list all" do
    nodes = []
    5.times { nodes.push Monit::Node.make }
    Monit::Node.should_receive(:all).and_return(nodes)

    contacts = []
    3.times { contacts.push Monit::Contact.make }
    Monit::Contact.should_receive(:all).and_return(contacts)
    
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

  it "should delete node from interface" do
    5.times { Monit::Node.make }
    node = Monit::Node.make
    5.times { Monit::Node.make }

    get '/'

    Monit::Node.first(node.attributes).should_not be_nil

    within "#nodes .element-#{node.id}" do |scope|
      scope.click_link "Delete"
    end

    Monit::Node.first(node.attributes).should be_nil
  end

  it "should respond with service status" do 
    n = Monit::Node.make
    n.should_receive(:check).and_return(:up)
    n.should_receive(:last_log).and_return('best log in the world')

    Monit::Node.should_receive(:get).with(n.id).and_return(n)

    get "/status/#{n.id}"

    resp = JSON.parse(response.body)
    resp['status'].should == 'up'
    resp['log'].should == 'best log in the world'
  end

  it "should create node" do 
    node = Monit::Node.make_unsaved.attributes
    visit '/'
    Monit::Node.first(node).should be_nil

    fill_in "add-name-field", :with => node[:name]
    fill_in "add-url-field", :with => node[:url]
    click_button "Add node"

    Monit::Node.first(node).should_not be_nil
  end

  it "should create new contact" do 
    contact = Monit::Contact.make_unsaved.attributes
    visit '/'
    Monit::Contact.first(contact).should be_nil

    fill_in "add-email-field", :with => contact[:email]
    click_button "Add contact"  

    Monit::Contact.first(contact).should_not be_nil
  end  

  it "should delete node at /delete_node/:id" do
    test_delete(Monit::Node)
  end

  it "should create node at /new_node" do 
    test_new(Monit::Node)
  end

  it "should create contact at /new_contact" do 
    test_new(Monit::Contact)
  end

  private
  def test_new(cls)
    attrs = cls.make_unsaved.attributes
    name = cls.to_s.split('::').last.downcase
    cls.first(attrs).should be_nil
    post "/new_#{name}", name => attrs
    cls.first(attrs).should_not be_nil
  end

  def test_delete(cls)
    attrs = cls.make.attributes
    cls.first(attrs).should_not be_nil
    name = cls.to_s.split('::').last.downcase
    get "/delete_#{name}/#{attrs[:id]}"
    cls.first(attrs).should be_nil
  end
end
