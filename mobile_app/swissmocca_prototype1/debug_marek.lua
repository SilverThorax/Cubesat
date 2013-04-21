
-- Testing local storage

localdb = require "local-storage"

localdb.saveUser( { uid = "john", data1 = 1, nb_of_arms = 2, data2 = 3 } )
localdb.saveUser( { uid = "mary", data1 = 1, nb_of_arms = 2, data2 = 3 } )




-- Testing REST service

req_data = require "requests-data"

req_data.getData( { "Sat1", "Sat2"}, {"HK_EPS_LR_COM","HK_EPS_LR_ADCS","HK_EPS_LR_CDMS"}, "2009-10-05T11:02:37.343", "2009-10-07T12:42:38.473", function() end)

--req_data.TODO()
	