require 'data_mapper'
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
    outpost.run
  end

  protected
  def outpost
    @outpost ||= begin
      uri = URI.parse(url)
      outpost = Outpost::Application.new
      outpost.name = self.name

      outpost.add_scout Outpost::Scouts::Http => '' do
        options :host => uri.host, :port => uri.port
        report :up, :response_code => [200,301,302]
      end

      outpost
    end
  end
end

DataMapper.auto_upgrade!