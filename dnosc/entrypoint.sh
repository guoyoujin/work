#!/bin/bash

sed 's/development/production/g' -i /home/app/__init__.py
sed '$d' -i /home/run.py
/usr/local/nginx/sbin/nginx
cd /home&&gunicorn run:app
