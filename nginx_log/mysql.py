# coding:utf-8

from mysql_helper import HostMySQL
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def add_host(ip, country, area, region, city, county, isp,
             country_id, area_id, region_id, city_id, county_id, isp_id, pv, create_date):
    n = HostMySQL()
    sql = "insert into mio(`ip`, `country`, `area`, `region`, `city`, `county`, `isp`,  `country_id`, `area_id`, " \
          "`region_id`, `city_id`, `county_id`, `isp_id`, `pv`, `create_date`)"\
          " values('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" \
          % (ip, country, area, region, city, county, isp,
             country_id, area_id, region_id, city_id, county_id, isp_id, pv, create_date)
    r = n.host_execute(sql)
    return r

