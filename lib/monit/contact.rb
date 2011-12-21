module Monit
  class Contact
    include DataMapper::Resource  
    property :id,           Serial
    property :email,        String, :format => :email_address, :index => :unique, :required => true
  end
end