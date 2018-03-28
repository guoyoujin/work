#! /bin/bash

# fuc: source /etc/profile.d/rvm.sh && start app
# author: zhouwei
# email: xiaomao361@163.com
# date: 2016-06-30
# modify: 2017-12-19: change the hole file for docker-compose delpoy
#         2018-03-28: modify to deploy txdiag peoject

set -e

syslogd_pid=/var/run/syslogd.pid

source /etc/profile.d/rvm.sh

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi

rsyslogd
crond

cd /home
bundle install
RAILS_ENV=production bundle exec rake db:migrate

if [ $1 ]; then
	bundle exec whenever --update-crontab production
fi

RAILS_ENV=production bundle exec rake assets:precompile
puma -e production 
