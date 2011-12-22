module Monit
  class Settings
    attr_accessor :mail_from, :mail_subject, :check_period

    def initialize
      self.mail_from = 'changeme.in@monit.settings'
      self.mail_subject = 'Subject for monit notify letter'
      self.check_period = 30
    end

    def db_path=(path)
      DataMapper.setup(:default, path)
      DataMapper.auto_upgrade!
    end
  end
end