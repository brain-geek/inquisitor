require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Contact do
  describe "validation" do
    it "saves with valid email" do
      c = Contact.make_unsaved :email => "valid#{Time.now.to_i}@gmail.com"
      c.save.should be_true
    end
    it "does not save with invalid email" do
      c = Contact.make_unsaved :email => '#{Time.now.to_i}invalidfghdfhdgdgmail.com'
      c.save.should be_false
    end    
  end
end
