require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers/email'

require 'data_mapper'
require File.join(File.dirname(__FILE__), 'monit', 'extensions.rb')
require File.join(File.dirname(__FILE__), 'monit', 'node.rb')
require File.join(File.dirname(__FILE__), 'monit', 'contact.rb')
require File.join(File.dirname(__FILE__), 'monit', 'settings.rb')
DataMapper.finalize

module Monit
  class << self
    def create_outpost(name = '')
      outpost = Outpost::Application.new
      outpost.name = name

      Monit::Contact.all.each do |contact|
        outpost.add_notifier Outpost::Notifiers::Email, {
                :from    => Monit.settings.mail_from,
                :to      => contact.email,
                :subject => Monit.settings.mail_subject
            }
      end

      outpost
    end

    def settings
      @settings ||= Settings.new
    end

    delegate :check_all, :to => Node
  end
end
