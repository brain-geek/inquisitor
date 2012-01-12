Inquisitor
===============

[![Build Status](https://secure.travis-ci.org/brain-geek/inquisitor.png)](http://travis-ci.org/brain-geek/inquisitor)
[![Dependencies Status](https://gemnasium.com/brain-geek/inquisitor.png)](https://gemnasium.com/brain-geek/inquisitor)

This project is aimed on creation ruby-powered monitoring solution with simple web interface.

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
	gem 'inquisitor', :git => 'git://github.com/brain-geek/inquisitor.git'

#####Create initializer:

	require 'inquisitor/web'
	Inquisitor.settings.set :db_path => {:adapter  => "redis"}

#####Add to routes:

	mount Inquisitor::Web.new, :at => "/inquisitor"

###Development web server
	shotgun config.dev.ru

Features
-----
#####Databases supported
It should work with all databases supported by datamapper. Tested with postgresql, mysql, redis and sqlite. Format for db_path can be found [in datamapper doc](http://datamapper.org/getting-started.html) - "Specify your database connection".

#####Cli options:
You can read availible options from lib/inquisitor/cli.rb . Same options are supported by standalone install

#####Supported types of monitoring:
[outpost gem](https://github.com/vinibaggio/outpost) is used as backend for monitoring. For now, http:// and ping:// checks are supported.

Copyright
---------

Copyright (c) 2011 @brain-geek. See LICENSE for details.

