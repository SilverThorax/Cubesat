import unittest
import pymongo
import user
from pymongo.errors import DuplicateKeyError


class TestDatabaseFunctions(unittest.TestCase):
	def setUp(self):
		self.testmail = "test@testmail.com"
	def test_save(self):
		newuser = { "firstName": "Stefan", \
			    "lastName": "Agner", \
			    "eMail": self.testmail, \
			    "password": "Hash" \
			  }
		newuser2 = newuser.copy()
		useridsave = user.save(newuser)
		with self.assertRaises(DuplicateKeyError):
			user.save(newuser2)
		userdata = user.get(self.testmail)
		user.remove(self.testmail)
		self.assertTrue(self.testmail == userdata["eMail"])
	def tearDown(self):
		user.remove(self.testmail)
if __name__ == '__main__':
    unittest.main()

