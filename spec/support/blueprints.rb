require 'machinist/data_mapper'
require 'sham'

Monit::Node.blueprint do
  url   { 'http://' + Faker::Lorem.words(2).join('-').downcase + '.com' }
  name  { Faker::Name.name }
end

Monit::Contact.blueprint do
  email { Faker::Internet.email }
end
