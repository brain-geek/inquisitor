require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ffaker'
require File.join(File.dirname(__FILE__), '..', 'lib', 'monit.rb')

RSpec.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }  
end

if ENV['DB'] == 'sqlite'
  Monit.settings.db_path = "sqlite3://#{Dir.pwd}/test.db"
  puts "Using sqlite"
elsif ENV['DB'] == 'redis'
  Monit.settings.db_path ={:adapter  => "redis"}
  puts "Using redis"
elsif ENV['DB'] == 'mysql'
  `mysql -e 'create database monit;'`
  Monit.settings.db_path ="mysql://@localhost/monit"
  puts "Using mysql"
elsif ENV['DB'] == 'pg'
  `psql -c 'create database monit;' -U postgres`
  Monit.settings.db_path ="postgres://postgres@localhost/monit"
  puts "Using pg"
  else
  Monit.settings.db_path = 'sqlite3::memory:'
  puts 'Using sqlite by default!'
end

require File.join(File.dirname(__FILE__), 'support/blueprints.rb')
