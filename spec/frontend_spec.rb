require File.dirname(__FILE__) + '/spec_helper'

describe "Basic frontend test" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  before do
    Node.all.destroy
  end  

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end

  it "should create at /new" do 
    name = Faker::Name.name
    post '/new', "node[url]" => 'http://google.com', "node[name]" => name

    last_response.should be_redirect
    Node.count(:name => name, :url => 'http://google.com').should == 1
  end
end
