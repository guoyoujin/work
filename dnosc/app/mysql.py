# coding:utf-8

from mysql_helper import NodesMySQL


def select_nodes():
    n = NodesMySQL()
    sql = "select * from nodes"
    r = n.node_query(sql)
    return r


def add_node(name, ae, host, port):
    n = NodesMySQL()
    sql = "insert into nodes(`name`, `ae_title`, `host`, `port`)"\
          " values('%s', '%s', '%s', '%s')" % (name, ae, host, port)
    r = n.node_execute(sql)
    return r


def delete_node(no):
    n = NodesMySQL()
    sql = "delete from nodes where no = '%s'" % no
    r = n.node_execute(sql)
    return r


def update_node(name, ae, host, port, no):
    n = NodesMySQL()
    sql = "update nodes"\
          " set nodes.`name` = '"+name+"'"\
          ",nodes.`ae` = '"+ae+"'"\
          ",nodes'.`host` = '"+host+"'"\
          ",nodes.`port` = '"+port+"'"\
          " where `no` = '"+no+"'"
    r = n.node_execute(sql)
    return r
