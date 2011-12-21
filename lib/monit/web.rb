require 'sinatra/base'
require 'sinatra/link_header'
require 'sinatra/json'
require 'sinatra/config_file'
require 'haml'

module Monit
  class Web < Sinatra::Base
    helpers Sinatra::LinkHeader
    helpers Sinatra::JSON
    register Sinatra::ConfigFile

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"

    if respond_to? :public_folder
      set :public_folder, "#{dir}/server/public"
    else
      set :public, "#{dir}/server/public"
    end

    set :static, true

    #delme
    config_file "#{dir}/../../config.yml"

    get '/' do
      @nodes = Monit::Node.all
      @contacts = Monit::Contact.all
      haml :index, :format => :html5
    end

    get '/status/:id' do
      n = Monit::Node.get(params[:id].to_i)
      json :status => n.check, :log => n.last_log, :id => n.id
    end

    post '/new_node' do
      Monit::Node.create params["node"]

      redirect '/'
    end

    post '/new_contact' do
      Monit::Contact.create params["contact"]

      redirect '/'
    end 

    # set test environment
    configure :test do
      if ENV['DB'] == 'sqlite'
        DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/test.db")
      elsif ENV['DB'] == 'redis'
        DataMapper.setup(:default, {:adapter  => "redis"})      
      else
        DataMapper.setup(:default, 'sqlite3::memory:')
        puts 'Using sqlite by default!'
      end
      DataMapper.auto_upgrade!
      set :run, false
      set :raise_errors, true
      set :logging, false
    end

    #set development environment
    configure :development do
      DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
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
end