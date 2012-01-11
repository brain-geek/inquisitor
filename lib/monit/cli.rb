begin
  require 'slop'
rescue LoadError
  require 'rubygems'
  require 'slop'
end

require File.join(File.dirname(__FILE__), '..', 'monit')
require File.join(File.dirname(__FILE__), 'web')

opts = Slop.parse do
  banner "Usage: monitor [options]"

  on :d, :db_path, 'DB path', :optional => false
  on :mail_from, 'Send mail from email', :optional => true
  on :mail_subject, 'Mail subject', :optional => true
  on :check_period, :as => :integer, :optional => true
end

opts = opts.to_hash.delete_if{|key, value| value.nil? }

raise 'DB connection is not set'  unless opts.has_key?(:db_path)

Monit.settings.set opts
