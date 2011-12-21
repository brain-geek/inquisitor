require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe "Basic frontend test", :type => :request do
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    @app ||= Monit::Web
  end

  before do
    Monit::Node.all.destroy
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

end
