require 'data_mapper'
require File.join(File.dirname(__FILE__), 'monit', 'outpost_factory.rb')
require File.join(File.dirname(__FILE__), 'monit', 'node.rb')
require File.join(File.dirname(__FILE__), 'monit', 'contact.rb')
DataMapper.finalize

require File.join(File.dirname(__FILE__), 'monit', 'web.rb')
