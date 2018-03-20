#! /bin/bash

# fuc: start app
# author: zhouwei
# email: xiaomao361@163.com
# date:2016-11-17
# modify: 2017-12-20 change the hole file for docker-compose deploy

source /etc/profile
rvm use ruby 2.3.1 --default
/etc/init.d/crond start

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi
/etc/init.d/rsyslog start
cd /home
bundle install
bundle exec whenever --update-crontab -s environment=production
RAILS_ENV=production bundle exec rake assets:precompile
puma -e production
