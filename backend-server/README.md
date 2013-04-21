SwissMOCCA backend server
=========================


The backend server is done using the python webframework aspen. Aspen is a 
lightweight python framework without any data backend (like django for example)
It's especially easy to create RESTful API's.

Install
-------

# apt-get install python-pip mongodb

# pip install aspen pymongo

Run
---

For development purpose, a small script exists which starts the database an
aspen development server (needs root in order to use Port 80):

# ./start-aspen.sh

