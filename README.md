Monitor
===============

[![Build Status](https://secure.travis-ci.org/brain-geek/monitor.png)](http://travis-ci.org/brain-geek/monitor)
[![Dependencies Status](https://gemnasium.com/brain-geek/monitor.png)](https://gemnasium.com/brain-geek/monitor)

This project is aimed on creation ruby-powered monitoring solution with simple web interface.

Uses sinatra for frontend and outpost gem for monitoring. 

Usage
-----
Starting web frontend:

    rackup config.ru


Example using runner from console:

	bin/monitor -d sqlite3://`pwd`/sqlite_database.db


Copyright
---------

Copyright (c) 2011 @brain-geek. See LICENSE for details.

