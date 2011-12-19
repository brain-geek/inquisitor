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
    get '/'

    last_response.should be_ok

    nodes.each do |n|
      within ".node-#{n.id}" do |s|
        s.should contain n.name
        s.should contain n.url
        s.should contain(n.id.odd? ? 'up' : 'down')
      end
    end
  end

  it "should create at /new" do 
    node = Node.make_unsaved.attributes
    post '/new_node', 'node' => node

    last_response.should be_redirect
    Node.count(:name => node[:name], :url => node[:url]).should == 1
  end
end
