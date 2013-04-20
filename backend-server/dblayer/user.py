""" SwissMOCCA User database layer.
"""
import pymongo
from pymongo import MongoClient

client = MongoClient()

db = client['swissmocca']
users = db['user-collection']

users.ensure_index("eMail",  unique=True )


def save(newuser):
	users.save(newuser)

def get(email):
	return users.find_one({"eMail": email})

def remove(email):
	users.remove({"eMail": email})


