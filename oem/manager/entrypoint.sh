#! /bin/bash

# fuc: source /etc/profile.d/rvm.sh && start app
# author: zhouwei
# date: 2016-06-30
# email: xiaomao361@163.com
# modify: 2018-01-03 make it clear

set -e

syslogd_pid=/var/run/syslogd.pid

source /etc/profile.d/rvm.sh
rvm use ruby 2.3.1 --default

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi

/etc/init.d/rsyslog start

/etc/init.d/crond start

cd /home
bundle install
RAILS_ENV=production rake db:migrate
puma -e production
