require File.join(File.dirname(__FILE__), '..', 'spec_integration_helper.rb')

describe 'Outpost factory' do
	before do
		@contact = Inquisitor::Contact.make
	end

  it "should add email notifiers" do
  	outpost = Inquisitor.create_outpost 'title'

    outpost.name.should == 'title'

  	outpost.notifiers.first[0].should == Outpost::Notifiers::Email
  	outpost.notifiers.first[1][:to].should == @contact.email
  end

  it "should send emails" do
    Mail.defaults do
      delivery_method :test
    end

    Mail::TestMailer.deliveries.should == []
  	Inquisitor::Node.make(:url => 'ping://non-existant.domain').check_and_notify
  	Mail::TestMailer.deliveries.count.should == 1
  end
end