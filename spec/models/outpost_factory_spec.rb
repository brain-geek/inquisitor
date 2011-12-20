require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe OutpostFactory do
	before do
		@contact = Contact.make
	end

  it "should add email notifiers" do
  	outpost = OutpostFactory.create
  	# require 'ruby-debug'; debugger
  	# 123

  	outpost.notifiers.first[0].should == Outpost::Notifiers::Email
  	outpost.notifiers.first[1][:from].should == 'test-receiver@gmail.com'
  	outpost.notifiers.first[1][:to].should == @contact.email
  end

  it "should send emails" do
    Mail.defaults do
      delivery_method :test
    end

    Mail::TestMailer.deliveries.should == []

  	Node.make(:url => 'ping://non-existant.domain').check_and_notify

  	Mail::TestMailer.deliveries.count.should == 1
  end
end