require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers/email'

module OutpostFactory
  def self.create(name = '')
    outpost = Outpost::Application.new
    outpost.name = name

    Contact.all.each do |contact|
      outpost.add_notifier Outpost::Notifiers::Email, {
              :from    => Monitor.settings.mail_send_from,
              :to      => contact.email,
              :subject => Monitor.settings.mail_message_title
          }
    end

    outpost
  end
end