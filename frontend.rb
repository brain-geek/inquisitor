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
end

require './config/environments'