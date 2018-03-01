# coding:utf-8

import redis
from app import app


class Database:
    def __init__(self):
        self.host = app.config['REDIS_HOST']
        self.port = app.config['REDIS_PORT']
        self.password = app.config['REDIS_PASSWORD']
        self.db = app.config['REDIS_DB']

    def write(self, key, val):
        try:
            key = key
            val = val
            r = redis.StrictRedis(host=self.host, port=self.port, password=self.password, db=self.db)
            r.sadd(key, val)
        except Exception, exception:
            print exception

    def delete(self, key):
        try:
            r = redis.StrictRedis(host=self.host, port=self.port, password=self.password, db=self.db)
            r.delete(key)
        except Exception, exception:
            print exception
