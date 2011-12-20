require './app/models'
require 'eventmachine'
require 'yaml'

config = YAML::load( File.open('config.yml') )

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
DataMapper.auto_upgrade!

EventMachine::run do
  EventMachine::PeriodicTimer.new(config['check_period']) do
    puts 'Checking...'
    Node.all.each do |node|
       #EventMachine.defer(proc{
         node.check_and_notify
       #  })
    end
  end
end

puts "The event loop has ended"