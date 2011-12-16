require 'sinatra'
require 'data_mapper'
require 'haml'
require 'uri'

require 'outpost'
require 'outpost/scouts'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Node
  include DataMapper::Resource  
  property :id,           Serial
  property :url,          String
  property :name,         String

  validates_presence_of :url
  validates_presence_of :name

  def check
    uri = URI.parse(url)
    outpost = Outpost::Application.new

    outpost.add_scout Outpost::Scouts::Http => 'master http server' do
      options :host => uri.host, :port => uri.port
      report :up, :response_code => 200
    end

    outpost.run
  end
end

DataMapper.auto_upgrade!

get '/' do
  @nodes = Node.all
  haml :index, :format => :html5
end

post '/new' do
  Node.create params["node"]

  redirect '/'
end
