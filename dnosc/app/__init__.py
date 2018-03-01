# coding:utf-8

from flask import Flask

app = Flask(__name__)

from app import view, mysql, data, tools, mysql_helper
from config import config

app.config.from_object(config['development'])
