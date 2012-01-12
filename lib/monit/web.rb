require 'sinatra/base'
require 'sinatra/link_header'
require 'sinatra/json'
require 'sinatra/url_for'
require 'haml'

module Monit
  class Web < Sinatra::Base
    helpers Sinatra::LinkHeader
    helpers Sinatra::JSON
    helpers Sinatra::UrlForHelper

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"

    if respond_to? :public_folder
      set :public_folder, "#{dir}/server/public"
    else
      set :public, "#{dir}/server/public"
    end

    set :static, true
    set :run, false

    get '/' do
      @nodes = Monit::Node.all
      @contacts = Monit::Contact.all
      haml :index, :format => :html5
    end

    get '/status/:id' do
      n = Monit::Node.get(params[:id].to_i)
      json :status => n.check, :log => n.last_log, :id => n.id
    end

    get '/delete_node/:id' do
      n = Monit::Node.get(params[:id].to_i)
      n.destroy unless n.nil?
      redirect url_for('/')
    end

    post '/new_node' do
      Monit::Node.create params["node"]

      redirect url_for('/')
    end

    post '/new_contact' do
      Monit::Contact.create params["contact"]

      redirect url_for('/')
    end 
  end
end