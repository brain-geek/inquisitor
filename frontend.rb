require 'sinatra/base'
require 'sinatra/link_header'
require 'haml'
require './app/models'

class Monitor < Sinatra::Base
  helpers Sinatra::LinkHeader

  get '/' do
    @nodes = Node.all
    @contacts = Contact.all
    haml :index, :format => :html5
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