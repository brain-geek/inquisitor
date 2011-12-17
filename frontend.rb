require 'sinatra'
require 'haml'

require 'app/models'
require 'app/controllers'

 
get '/' do
  @nodes = Node.all
  haml :index, :format => :html5
end

post '/new' do
  Node.create params["node"]

  redirect '/'
end
