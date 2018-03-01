# coding:utf-8

from app import app
from flask import render_template, request
from app import tools


@app.route('/')
@app.route('/index')
def index():
    return render_template('base.html',
                           title='index',
                           data='is_online_api')


@app.route('/is_online', methods=['GET', 'POST'])
def is_online():
    ae = request.args['ae']
    host = request.args['host']
    port = request.args['port']
    r = tools.is_online(ae, host, port)
    return render_template('base.html',
                           title='is_online?',
                           data=r)


@app.route('/add_node', methods=['GET', 'POST'])
def add_node():
    name = request.args['name']
    ae = request.args['ae']
    host = request.args['host']
    port = request.args['port']
    r = tools.add_node(name, ae, host, port)
    return render_template('base.html',
                           title='add_node',
                           data=r)


@app.route('/delete_node', methods=['GET', 'POST'])
def delete_node():
    no = request.args['no']
    r = tools.delete_node(no)
    return render_template('base.html',
                           title='delete_node',
                           data=r)


@app.route('/update_node', methods=['GET', 'POST'])
def update_node():
    no = request.args['no']
    name = request.args['name']
    ae = request.args['ae']
    host = request.args['host']
    port = request.args['port']
    r = tools.update_node(no, name, ae, host, port)
    return render_template('base.html',
                           title='update_node',
                           data=r)


@app.route('/update_status')
def update_status():
    tools.update_status()
    return render_template('base.html',
                           title='update_status',
                           data='finish')
