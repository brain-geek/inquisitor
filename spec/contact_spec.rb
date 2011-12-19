require File.dirname(__FILE__) + '/spec_helper'

describe Contact do
  describe "validation" do
    it "saves with valid email" do
      c = Contact.make_unsaved :email => 'valid@gmail.com'
      c.save.should be_true
    end
    it "does not save with invalid email" do
      c = Contact.make_unsaved :email => 'invalidfghdfhdgdgmail.com'
      c.save.should be_false
    end    
  end
end
