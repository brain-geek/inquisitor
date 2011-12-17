require File.dirname(__FILE__) + '/spec_helper'

describe Node do
  it "should check if it tells that http site is ok" do
    n = Node.make :url => 'http://ya.ru'

    n.check.should == :up
  end

  it "should check if it tells that site is not ok" do
    n = Node.make :url => 'http://akjfsjjgsdf.google.com'

    n.check.should == :down
  end
end
