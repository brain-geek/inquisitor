require 'machinist/data_mapper'
require 'sham'

Inquisitor::Node.blueprint do
  url   { 'http://' + Faker::Lorem.words(2).join('-').downcase + '.com' }
  name  { Faker::Name.name }
end

Inquisitor::Contact.blueprint do
  email { Faker::Internet.email }
end
