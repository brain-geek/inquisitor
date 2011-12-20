Monitor.class_eval do
  # set test environment
  configure :test do
    DataMapper.setup(:default, 'sqlite::memory:')
    DataMapper.auto_upgrade!
    set :run, false
    set :raise_errors, true
    set :logging, false
  end

  #set development environment
  configure :development do
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
    DataMapper.auto_upgrade!    
    set :run, false
    set :raise_errors, true
    set :logging, true    
  end

  #set development environment
  configure :production do
    DataMapper.setup(:default, settings.database)
    DataMapper.auto_upgrade! 
    set :run, false
    set :raise_errors, false
    set :logging, false
  end  
end

