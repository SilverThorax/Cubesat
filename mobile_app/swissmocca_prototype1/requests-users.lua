local M = {}

local json = require "json"

M.serverAddress = "http://ec2-54-216-43-204.eu-west-1.compute.amazonaws.com"

-- EXAMPLES & DOC HERE
-- http://docs.coronalabs.com/daily/api/library/network/request.html

-- Returns true when it succeedes
function M.createUser(newuser)
	local headers = {}
	headers["Content-Type"] = "application/json"
	local body = json.encode(newuser)
	
	local params = {}
	params.headers = headers
	params.body = body
	
	network.request( M.serverAddress .. "/user/", "POST", function( event )
		if ( event.isError ) then
                print( "Network error!")
        else
				if (event.status == 200) then
					print("OK")
					return true
				else
					print ( "NOT OK, RESPONSE: " .. event.status )
					return false
				end
        end
	end, params )
end
	

function M.getAllUsers()
	network.request( M.serverAddress .. "/user/list/", "GET", function( event )
		if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )
        end
	end )
	
end

function M.getNewMessages()
	
	--
	
end

function M.createDashboard(user, newdashboard)
	local headers = {}
	headers["Content-Type"] = "application/json"
	local body = json.encode(newdashboard)
	
	local params = {}
	params.headers = headers
	params.body = body
	
	network.request( M.serverAddress .. "/user/" .. user .. "/dashboard/", "POST", function( event )
		if ( event.isError ) then
                print( "Network error!")
        else
				if (event.status == 200) then
					print ( "OK" )
					return true
				else
					print ( "NOT OK, RESPONSE: " .. event.status )
					return false
				end
        end
	end, params )
	
end


function M.listDashboards(user, callback)
	network.request( M.serverAddress .. "/user/" .. user .. "/dashboard/list/", "GET", function( event )
		if ( event.isError ) then
                print( "Network error!")
        else
                print ( "RESPONSE: " .. event.response )
				callback(json.decode(event.response))
        end
	end )
end

return M


