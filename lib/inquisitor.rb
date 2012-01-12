require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers/email'

require 'data_mapper'
require File.join(File.dirname(__FILE__), 'inquisitor', 'extensions.rb')
require File.join(File.dirname(__FILE__), 'inquisitor', 'node.rb')
require File.join(File.dirname(__FILE__), 'inquisitor', 'contact.rb')
require File.join(File.dirname(__FILE__), 'inquisitor', 'settings.rb')
DataMapper.finalize

module Inquisitor
  class << self
    def create_outpost(name = '')
      outpost = Outpost::Application.new
      outpost.name = name

      Inquisitor::Contact.all.each do |contact|
        outpost.add_notifier Outpost::Notifiers::Email, {
                :from    => Inquisitor.settings.mail_from,
                :to      => contact.email,
                :subject => Inquisitor.settings.mail_subject
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
