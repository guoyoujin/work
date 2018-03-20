#! /bin/bash

# fuc: source /etc/profile.d/rvm.sh && start app
# author: zhouwei
# email: xiaomao361@163.com
# date: 2016-06-30
# modify: 2017-12-20 change the hole file fie docker-compose deploy

set -e

source /etc/profile

/etc/init.d/crond start

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi

/etc/init.d/rsyslog start
cd /home
bundle install
RAILS_ENV=production bundle exec rake db:migrate
bundle exec whenever --update-crontab production
RAILS_ENV=production bundle exec rake assets:precompile
puma -e production
