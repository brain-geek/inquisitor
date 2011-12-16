require File.dirname(__FILE__) + '/spec_helper'

describe "Basic frontend test" do
  def app
    @app ||= Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
end
