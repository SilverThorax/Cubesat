local M = {}

M.localData = {
	users = {},
	crafts = {},
	metrics = {},
	my_inbox = {},
	my_dashboards = {},
}

local t_insert = table.insert
local t_remove = table.remove

function M.debug_onDataChanged()
	local now = os.date( "%c" )
	print( "" )
	print( "" )
	print( "" )
	print( "Contents of the local database" )
	print( now )
	for k,v in pairs( M.localData ) do
		print( "---------------------------------------------" )
		print( k..":" )
		for kk,vv in pairs( v ) do
			print( "     "..kk.." = ", vv )
		end
	end
	print( "---------------------------------------------" )
end

function M.saveUser( data )
	
	-------t_insert( M.localData.users, data )
	-- Alternative:
	M.localData.users[data.uid] = data
	
	M.debug_onDataChanged() -- debug
	
end

function M.saveCraft( data )
	
	t_insert( M.localData.crafts, data )
	-- Alternative: M.localData.crafts[data.uid] = data
	
	M.debug_onDataChanged() -- debug
	
end

-- Etc. TODO...

return M


