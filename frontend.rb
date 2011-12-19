require 'sinatra/base'
require 'sinatra/link_header'
require 'haml'
require './app/models'

class Monitor < Sinatra::Base
  helpers Sinatra::LinkHeader

  get '/' do
    @nodes = Node.all
    haml :index, :format => :html5
  end

  post '/new_node' do
    Node.create params["node"]

    redirect '/'
  end
end