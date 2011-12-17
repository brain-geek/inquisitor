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
    5.times { nodes.push Node.make }
    get '/'

    last_response.should be_ok

    nodes.each do |n|
      last_response.should contain n.name
      last_response.should contain n.url
    end
  end

  it "should create at /new" do 
    node = Node.make_unsaved.attributes
    post '/new', 'node' => node

    last_response.should be_redirect
    Node.count(:name => node[:name], :url => node[:url]).should == 1
  end
end
