# coding:utf-8

import requests
import json
import mysql
import time


url = 'http://ip.taobao.com/service/getIpInfo.php'

for line in open('./ip.log', 'r'):
    pv = line.split()[0]
    ip =  line.split()[1]

    body = {'ip': ip}
    rs = requests.get(url, body)

    r = json.loads(rs.text)
    country = r['data']['country']
    area = r['data']['area']
    region = r['data']['region']
    city = r['data']['city']
    county = r['data']['county']
    isp = r['data']['isp']
    country_id = r['data']['country_id']
    area_id = r['data']['area_id']
    region_id = r['data']['region_id']
    city_id = r['data']['city_id']
    county_id = r['data']['county_id']
    isp_id = r['data']['isp_id']
    create_date = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

    mysql.add_host(ip, country, area, region, city,
                   county, isp, country_id, area_id,
                   region_id, city_id, county_id, isp_id, pv, create_date)

    time.sleep(20)