require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'App settings' do
  before :each do
    Inquisitor.instance_variable_set '@settings', nil
  end

  it "should have default values" do
    Inquisitor.settings.mail_from.should == 'changeme.in@Inquisitor.settings'
    Inquisitor.settings.mail_subject.should == 'Subject for Inquisitor notify letter'

    Inquisitor.settings.check_period.should == 30
  end

  it "should send email from emails we set and with defined title" do
    Inquisitor::Contact.make

    subj = 'Notify set in test env'
    mail = 'test-receiver@gmail.com'

    Inquisitor.settings.mail_from = mail
    Inquisitor.settings.mail_subject = subj
    outpost = Inquisitor.create_outpost

    outpost.notifiers.first[1][:from].should == mail
    outpost.notifiers.first[1][:subject].should == subj
  end

  it "should set db settings" do
     DataMapper.should_receive(:setup).with :default, :path
     DataMapper.should_receive(:auto_upgrade!)

     Inquisitor.settings.db_path = :path
  end

  it "should do mass asignments" do
    Inquisitor.settings.set :mail_from => 'me@gmail.com', :check_period => 900
    Inquisitor.settings.mail_from.should == 'me@gmail.com'
    Inquisitor.settings.check_period.should == 900
  end
end