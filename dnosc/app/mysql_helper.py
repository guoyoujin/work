# coding:utf-8

import MySQLdb
from app import app


class NodesMySQL(object):
    def __init__(self):
        host = app.config['MYSQL_HOST']
        user = app.config['MYSQL_USER']
        passwd = app.config['MYSQL_PASSWD']
        db = app.config['MYSQL_DB']

        self.conn = MySQLdb.connect(
            host=host, user=user, passwd=passwd, db=db, charset="utf8")

    def node_query(self, sql):
        cursor = self.conn.cursor()
        try:
            cursor.execute(sql)
            rs = cursor.fetchall()
            return rs
        except Exception as e:
            print e
        finally:
            self.conn.close()

    def node_execute(self, sql):
        cursor = self.conn.cursor()
        try:
            cursor.execute(sql)
            self.conn.commit()
        except Exception as e:
            print e
        finally:
            cursor.close()
