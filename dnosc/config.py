# coding:utf-8

class BaseConfig:
    DEBUG = False
    TESTING = False

class DevelopmentConfig(BaseConfig):
    DEBUG = True
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'root'
    MYSQL_PASSWD = 'zhouwei'
    MYSQL_DB = 'dicom_node'

    REDIS_HOST = '127.0.0.1'
    REDIS_PORT = '6379'
    REDIS_PASSWORD = ''
    REDIS_DB = 'db10'

class ProductionConfig(BaseConfig):
    DEBUG = True
    MYSQL_HOST = '192.168.42.1'
    MYSQL_USER = 'root'
    MYSQL_PASSWD = '3YVgzZ3827'
    MYSQL_DB = 'dicom_node'

    REDIS_HOST = 'r-2ze1efa5198c21c4.redis.rds.aliyuncs.com'
    REDIS_PORT = '6379'
    REDIS_PASSWORD = 'r-2ze1efa5198c21c4:TongXin2017'
    REDIS_DB = 'db0'


config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,

    'default': DevelopmentConfig
}
