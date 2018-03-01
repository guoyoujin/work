# coding:utf-8

import os
from app import mysql
from data import Database


def is_online(ae, host, port):
    arg = '%s\ %s\ %s' % (ae, host, port)
    print arg
    r = os.system('./app/is_online.sh ' + arg)
    return r


def add_node(name, ae, host, port):
    r = mysql.add_node(name, ae, host, port)
    return r


def delete_node(no):
    r = mysql.delete_node(no)
    return r


def update_node(no, name, ae, host, port):
    r = mysql.update_node(name, ae, host, port, no)
    return r


def update_status():
    db = Database()
    nodes = mysql.select_nodes()
    db.delete('nodes')
    for node in nodes:
        arg = '%s\ %s\ %s' % (node[2], node[3], node[4])
        r = os.system('./app/is_online.sh ' + arg)
        if r == 0:
            db.write('nodes', node[3])
    return '0'
