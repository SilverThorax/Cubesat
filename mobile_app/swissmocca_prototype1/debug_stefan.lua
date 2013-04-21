
-- Testing local storage

localdb = require "local-storage"

localdb.saveUser( { uid = "john", data1 = 1, nb_of_arms = 2, data2 = 3 } )
localdb.saveUser( { uid = "mary", data1 = 1, nb_of_arms = 2, data2 = 3 } )




-- Testing REST service

req_users = require "requests-users"

req_users.getAllUsers()


-- We should do this: localstorage.getEMail(), if there is a email don't create user, if not, create user...

req_users.createUser({ 
		firstName = "Stefan", 
		lastName = "Agner", 
		eMail = "test@mail4.com" })

		
req_users.createDashboard("test@mail4.com", {
	name= "New Dashboard 4",
	satellites = {
		{
			name = "Sat1",
			metrics = {
				{ name= "TEMP" },
				{ name= "BAT" }
			}
		},
		{
			name = "Sat2",
			metrics = {
				{ name= "TEMP" },
				{ name= "BAT" }
			}
		}
	}
})
		
req_users.listDashboards("test@mail4.com")

