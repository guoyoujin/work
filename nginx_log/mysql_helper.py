# coding:utf-8

import MySQLdb


class HostMySQL(object):
    def __init__(self):

        self.conn = MySQLdb.connect(host='localhost', user='root', passwd='zhouwei', db='operations', charset="utf8")

    def host_query(self, sql):
        cursor = self.conn.cursor()
        try:
            cursor.execute(sql)
            rs = cursor.fetchall()
            return rs
        except Exception as e:
            print e
        finally:
            self.conn.close()

    def host_execute(self, sql):
        cursor = self.conn.cursor()
        try:
            cursor.execute(sql)
            self.conn.commit()
        except Exception as e:
            print e
        finally:
            cursor.close()