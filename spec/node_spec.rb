require File.dirname(__FILE__) + '/spec_helper'

describe "Check if it is up" do
  describe 'http checking' do
    it "should check if it tells that http site is ok" do
      n = Node.make :url => 'http://ya.ru'

      n.check.should == :up
    end

    it "should tell that page with redirect is ok, not down" do
      n = Node.make :url => 'http://google.com/'

      n.check.should == :up
    end

    it "should fail if hostname not found" do
      n = Node.make :url => 'http://akjfsjjgsdf.google.com'

      n.check.should == :down
    end

    it "should fail if page not found" do
      n = Node.make :url => 'http://www.google.com/404.html'

      n.check.should == :down
    end    
  end

  # describe 'ping checking' do
  #   it "should pass if host is reachable" do
  #     n = Node.make :url => 'ping://127.0.0.1'
  #     n.check.should == :up
  #   end

  #   it "should pass if host is not reachable" do
  #     n = Node.make :url => 'ping://0.0.0.0'
  #     n.check.should == :down
  #   end    
  # end

  describe 'validation' do
    it "should fail if unknown protocol of url is passed" do
      n = Node.make_unsaved :url => 'https://github.com'
      n.save.should be_false
    end
  end

  it "should return logs from outpost" do
    n = Node.make
    o = Object.new
    o.should_receive(:messages).and_return([])
    n.should_receive(:outpost).and_return(o)

    n.last_log
  end
end
