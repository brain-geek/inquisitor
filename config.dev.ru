require 'lib/Inquisitor'
require 'lib/Inquisitor/web'

Inquisitor.settings.db_path = "sqlite3://#{Dir.pwd}/development.db"
Inquisitor::Web.set :raise_errors, true
Inquisitor::Web.set :logging, true    


run Inquisitor::Web

