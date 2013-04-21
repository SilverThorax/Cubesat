local M = {}

local t_concat = table.concat

M.serverAddress = "http://ec2-54-216-36-6.eu-west-1.compute.amazonaws.com"

function M.getListOfSatellites()
	
end

function M.getData( satsList, metricsList, timeFrom, timeTo, callback )
	
	local uri = "/rest?run=get-matrix.xq&satellite-names="..t_concat(satsList, ",").."&columns="..t_concat(metricsList, ",").."&time-from="..timeFrom.."&time-to="..timeTo.."&"
	
	network.request( M.serverAddress .. uri , "GET", function( event )
		if ( event.isError ) then
                print( "Network error!")
        else
                --print ( "RESPONSE: " .. event.response )
				callback( event )
        end
	end )
	
end

return M


