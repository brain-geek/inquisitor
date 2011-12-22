require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers/email'

require 'data_mapper'
require File.join(File.dirname(__FILE__), 'monit', 'node.rb')
require File.join(File.dirname(__FILE__), 'monit', 'contact.rb')
DataMapper.finalize

module Monit
  def self.create_outpost(name = '')
    outpost = Outpost::Application.new
    outpost.name = name

    Monit::Contact.all.each do |contact|
      outpost.add_notifier Outpost::Notifiers::Email, {
              :from    => Monit::Web.settings.mail_send_from,
              :to      => contact.email,
              :subject => Monit::Web.settings.mail_message_title
          }
    end

    outpost
  end

end

# require File.join(File.dirname(__FILE__), 'monit', 'web.rb')
