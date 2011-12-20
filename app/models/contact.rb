class Contact
  include DataMapper::Resource  
  property :id,           Serial
  property :email,        String, :format => :email_address, :unique => true, :required => true, :index => true
end