""" SwissMOCCA Dashboard database layer.
"""
import pymongo
import pprint
from pymongo import MongoClient

client = MongoClient()

db = client['swissmocca']
dashboards = db['dashboard-collection']

dashboards.ensure_index("name",  unique=True )


def save(newdashboard):
	dashboards.save(newdashboard)

def get(name):
	return dashboards.find_one({"name": name})

def remove(name):
	doc = dashboards.remove({"name": name})
	return doc["n"] == 1

def list(email):
	return dashboards.find({"user": email})


