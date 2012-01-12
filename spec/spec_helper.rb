require 'rubygems'
require 'rack/test'
require 'rspec'
require 'webrat'
require 'ffaker'
require File.join(File.dirname(__FILE__), '..', 'lib', 'inquisitor.rb')

RSpec.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }  
end

if ENV['DB'] == 'sqlite'
  Inquisitor.settings.db_path = "sqlite3://#{Dir.pwd}/test.db"
  puts "Using sqlite"
elsif ENV['DB'] == 'redis'
  Inquisitor.settings.db_path ={:adapter  => "redis"}
  puts "Using redis"
elsif ENV['DB'] == 'mysql'
  `mysql -e 'create database Inquisitor;'`
  Inquisitor.settings.db_path ="mysql://@localhost/Inquisitor"
  puts "Using mysql"
elsif ENV['DB'] == 'pg'
  `psql -c 'create database Inquisitor;' -U postgres`
  Inquisitor.settings.db_path ="postgres://postgres@localhost/Inquisitor"
  puts "Using pg"
  else
  Inquisitor.settings.db_path = 'sqlite3::memory:'
  puts 'Using sqlite by default!'
end

require File.join(File.dirname(__FILE__), 'support/blueprints.rb')
