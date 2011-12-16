require File.dirname(__FILE__) + '/spec_helper'

describe "Check if it is up" do
  it "should check if it tells that http site is ok" do
    n = Node.make :url => 'http://ya.ru'

    n.check.should == :up
  end

  it "should check if it tells that site is not ok" do
    n = Node.make :url => 'http://akjfsjjgsdf.google.com'

    n.check.should == :down
  end
end
