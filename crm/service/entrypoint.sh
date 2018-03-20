#! /bin/bash

# fuc: source /etc/profile.d/rvm.sh && start app
# author: zhouwei
# email: xiaomao361@163.com
# date: 2016-06-30
# modify: 2017-12-20 change the hole file fie docker-compose deplo

set -e

source /etc/profile.d/rvm.sh
crond

if [ -f $syslogd_pid ]; then
	rm -rf /var/run/syslogd.pid
fi
rsyslogd

cd /home && puma -e production
