local M = {}

M.serverAddress = "http://ec2-54-216-43-204.eu-west-1.compute.amazonaws.com"

-- EXAMPLES & DOC HERE
-- http://docs.coronalabs.com/daily/api/library/network/request.html

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

function M.getNewDocuments()
	
	--
	
end

return M


