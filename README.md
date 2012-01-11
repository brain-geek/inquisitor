Monitor
===============

[![Build Status](https://secure.travis-ci.org/brain-geek/monitor.png)](http://travis-ci.org/brain-geek/monitor)
[![Dependencies Status](https://gemnasium.com/brain-geek/monitor.png)](https://gemnasium.com/brain-geek/monitor)

This project is aimed on creation ruby-powered monitoring solution with simple web interface.

Uses sinatra for frontend and outpost gem for monitoring. 

Usage
-----
###Standalone install:

#####Running check:

	monitor -d sqlite3://`pwd`/sqlite_database.db

#####Running web server:

	monitor_web -d sqlite3://`pwd`/sqlite_database.db

###Mounting to rails app:

#####Add to gemfile:

	gem 'data_mapper'
	gem 'dm-redis-adapter'
	gem 'monit', :git => 'git://github.com/brain-geek/monitor.git'

#####Create initializer:

	require 'monit/web'
	Monit.settings.set :db_path => {:adapter  => "redis"}

#####Add to routes:

	mount Monit::Web.new, :at => "/monit"

###Start development web server

	shotgun config.dev.ru

Usage
-----
####Databases supported
It should work with all databases supported by datamapper, but for now it is tested only with redis and sqlite.


####Cli options:
You can read availible options from lib/monit/cli.rb . Same options are supported by standalone install

Copyright
---------

Copyright (c) 2011 @brain-geek. See LICENSE for details.

