require 'sinatra'
require 'data_mapper'
require 'haml'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Node
  include DataMapper::Resource  
  property :id,           Serial
  property :url,          String
  property :name,         String

  validates_presence_of :url
  validates_presence_of :name
end

DataMapper.auto_upgrade!

get '/' do
  haml :index, :format => :html5
end

post '/new' do
  Node.create params["node"]

  redirect '/'
end