require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Monit::Node do
  describe 'http checking' do
    it "should check if it tells that http site is ok" do
      n = Monit::Node.make :url => 'http://ya.ru'

      n.check.should == :up
    end

    it "should tell that page with redirect is ok, not down" do
      n = Monit::Node.make :url => 'http://google.com/'

      n.check.should == :up
    end

    it "should fail if hostname not found" do
      n = Monit::Node.make :url => 'http://akjfsjjgsdf.google.com'

      n.check.should == :down
    end

    it "should fail if page not found" do
      n = Monit::Node.make :url => 'http://www.google.com/404.html'

      n.check.should == :down
    end    
  end

  describe 'ping checking' do
    it "should pass if host is reachable" do
      n = Monit::Node.make :url => 'ping://127.0.0.1'
      n.check.should == :up
    end
    it "should not pass if host is not reachable" do
      n = Monit::Node.make :url => 'ping://sdfsadfasdfasdf.asdfasdfasdf.asdfasdf'
      n.check.should == :down
    end    
  end

  describe 'validation' do
    it "should fail if unknown protocol of url is passed" do
      n = Monit::Node.make_unsaved :url => 'https://github.com'
      n.save.should be_false
    end
  end

  describe "work with outpost" do
    it "should return logs from outpost" do
      n = Monit::Node.make
      o = Object.new
      o.should_receive(:messages).and_return([])
      n.should_receive(:outpost).and_return(o)

      n.last_log
    end
  end
end
