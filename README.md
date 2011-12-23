Monitor
===============

[![Build Status](https://secure.travis-ci.org/brain-geek/monitor.png)](http://travis-ci.org/brain-geek/monitor)
[![Dependencies Status](https://gemnasium.com/brain-geek/monitor.png)](https://gemnasium.com/brain-geek/monitor)

This project is aimed on creation ruby-powered monitoring solution with simple web interface.

Uses sinatra for frontend and outpost gem for monitoring. 

Usage
-----
###Example running check with sqlite storage:

	bundle exec monitor -d sqlite3://`pwd`/sqlite_database.db

###Example mounting to rails app with redis storage:

#####Add to gemfile:

	gem 'data_mapper'
	gem 'dm-redis-adapter'
	gem 'monit', :git => 'git://github.com/brain-geek/monitor.git'

#####Create initializer:

	require 'monit/web'
	Monit.settings.set :db_path => {:adapter  => "redis"}

#####Add to routes:

	mount Monit::Web.new, :at => "/monit"

Copyright
---------

Copyright (c) 2011 @brain-geek. See LICENSE for details.

