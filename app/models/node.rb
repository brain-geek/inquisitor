require 'uri'
require 'outpost'
require 'outpost/scouts'

class Node
  include DataMapper::Resource  
  property :id,           Serial
  property :url,          String, :index => true, :unique => true
  property :name,         String, :index => true

  validates_presence_of :url
  validates_with_method :url, :method => :check_protocol

  def check
    outpost.run
  end

  def last_log
    outpost.messages.join('<br />')
  end

  def check_protocol
    outpost
    true
  rescue URI::InvalidURIError
    false
  end

  protected
  def outpost
    @outpost ||= begin
      outpost = Outpost::Application.new
      uri = URI.parse(url)
      outpost.name = self.name

      case uri.scheme 
      when 'http'
        outpost.add_scout Outpost::Scouts::Http => '' do
          options :host => uri.host, :port => uri.port, :path => uri.path.empty? ? '/' : uri.path
          report :up, :response_code => 200...400
          report :down, :response_code => 400..600
        end
      when 'ping'
        outpost.add_scout Outpost::Scouts::Ping => '' do
          options :host => uri.host
          report :up, :response_time => {:less_than => 500}
        end
      else
        raise URI::InvalidURIError
      end

      outpost
    end
  end
end