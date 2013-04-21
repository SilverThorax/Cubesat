
-- Testing local storage

localdb = require "local-storage"

localdb.saveUser( { uid = "john", data1 = 1, nb_of_arms = 2, data2 = 3 } )
localdb.saveUser( { uid = "mary", data1 = 1, nb_of_arms = 2, data2 = 3 } )




-- Testing REST service

req_users = require "requests-users"

req_users.getAllUsers()


