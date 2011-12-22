require 'uri'

module Monit
  class Node
    include DataMapper::Resource  
    property :id,           Serial
    property :url,          String, :index => :unique
    property :name,         String, :index => true

    validates_presence_of :url
    validates_with_method :url, :method => :check_protocol

    def check
      outpost.run
    end

    def check_and_notify
      if outpost.run != :up
        # puts 'sending a letter'
        outpost.notify
      end
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
        outpost = Monit.create_outpost(self.name)
        uri = URI.parse(url)

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
end