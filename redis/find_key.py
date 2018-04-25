# coding:utf-8
#
# @author:周维
#
# @date: 2018.04.25


import MySQLdb
import sys
reload(sys)
sys.setdefaultencoding("utf-8")


# 定义数据库操作对象
class OssMsql(object):
    # 构造方法
    def __init__(self):
        self.conn = MySQLdb.connect(charset="utf8")

    # 查询方法
    def select_name(self, name):
        cursor = self.conn.cursor()
        try:
	    sql = "SELECT id  FROM `dicom_production`.`t_study`  WHERE `hospitalId` ='11' and `patientName` ='%s' ORDER BY `id` DESC  LIMIT 0,50;" % name
           
            cursor.execute(sql)
            rs = cursor.fetchall()
            return rs
        except Exception as e:
            print e
        finally:
            self.conn.close()


patient_name=sys.argv[1]
oss = OssMsql()
redis_keys = oss.select_name(patient_name)
for redis_key in redis_keys:
    print redis_key[0]
