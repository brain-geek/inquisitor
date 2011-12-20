require 'sinatra/base'
require 'sinatra/link_header'
require "sinatra/json"
require 'haml'
require './app/models'

class Monitor < Sinatra::Base
  helpers Sinatra::LinkHeader
  helpers Sinatra::JSON

  get '/' do
    @nodes = Node.all
    @contacts = Contact.all
    haml :index, :format => :html5
  end

  get '/status/:id' do
    n = Node.get(params[:id].to_i)
    json :status => n.check, :log => n.last_log, :id => n.id
  end

  post '/new_node' do
    Node.create params["node"]

    redirect '/'
  end

  post '/new_contact' do
    Contact.create params["contact"]

    redirect '/'
  end 

  # set test environment
  configure :test do
    if ENV['DB'] == 'sqlite'
      DataMapper.setup(:default, 'sqlite::memory:')
    elsif ENV['DB'] == 'redis'
      DataMapper.setup(:default, {:adapter  => "redis"})      
    else
      DataMapper.setup(:default, 'sqlite::memory:')
      puts 'Using sqlite by default!'
    end
    set :run, false
    set :raise_errors, true
    set :logging, false
  end

  #set development environment
  configure :development do
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
    DataMapper.auto_upgrade!    
    set :run, false
    set :raise_errors, true
    set :logging, true    
  end

  #set development environment
  configure :production do
    DataMapper.setup(:default, settings.database)
    DataMapper.auto_upgrade! 
    set :run, false
    set :raise_errors, false
    set :logging, false
  end  
end
