require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers/email'

module OutpostFactory
  def self.create(name = '')
    outpost = Outpost::Application.new
    outpost.name = name

    Contact.all.each do |contact|
      outpost.add_notifier Outpost::Notifiers::Email, :from    => Monitor.settings.send_from,
              :to      => contact.email,
              :subject => 'Message from monitor'
    end

    outpost
  end
end