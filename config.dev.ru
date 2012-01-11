require 'lib/monit'
require 'lib/monit/web'

Monit.settings.db_path = "sqlite3://#{Dir.pwd}/development.db"
Monit::Web.set :raise_errors, true
Monit::Web.set :logging, true    


run Monit::Web

