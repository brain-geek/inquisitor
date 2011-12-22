require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe 'App settings' do
  before :each do
    Monit.instance_variable_set '@settings', nil
  end

  it "should have default values" do
    Monit.settings.mail_from.should == 'changeme.in@monit.settings'
    Monit.settings.mail_subject.should == 'Subject for monit notify letter'

    Monit.settings.check_period.should == 30
  end

  it "should send email from emails we set and with defined title" do
    Monit::Contact.make

    subj = 'Notify from monitor, set in test env'
    mail = 'test-receiver@gmail.com'

    Monit.settings.mail_from = mail
    Monit.settings.mail_subject = subj
    outpost = Monit.create_outpost

    outpost.notifiers.first[1][:from].should == mail
    outpost.notifiers.first[1][:subject].should == subj
  end

  it "should set db settings" do
     DataMapper.should_receive(:setup).with :default, :path
     DataMapper.should_receive(:auto_upgrade!)

     Monit.settings.db_path = :path
  end
end