#! /bin/bash

# fuc: start app
# author: zhouwei
# date: 2016-11-17
# email: xiaomao361@163.com
# modify: 2018-03-25: change the script for new deploy

set -e

syslogd_pid=/var/run/syslogd.pid

source /etc/profile.d/rvm.sh

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi

rsyslogd

crond

cd /home
RAILS_ENV=production bundle exec rake db:migrate
bundle exec whenever --update-crontab -s environment=production
RAILS_ENV=production bundle exec rake assets:precompile
puma -e production
