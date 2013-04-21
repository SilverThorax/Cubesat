local M = {}

M.localData = {
	users = {},
	crafts = {
		{
			name = "Sat1",
			pic = "",
		},
		{
			name = "Sat2",
			pic = "",
		},
	},
	metrics = {
		"HK_EPS_LR_COM","HK_EPS_LR_ADCS","HK_EPS_LR_CDMS","HK_EPS_LR_PL","HK_EPS_BAT1_1_V","HK_EPS_BAT1_2_V","HK_EPS_BAT2_1_V","HK_EPS_BAT2_2_V","HK_EPS_BAT1_TP","HK_EPS_BAT2_TP","HK_EPS_PBUS_D_V","HK_EPS_PBUS_A_V","HK_EPS_EXT_TP","HK_EPS_FRAME_TP","HK_EPS_MC_TP","HK_EPS_PCB_TP","HK_EPS_MB_TP","HK_EPS_XN_CU","HK_EPS_XP_CU","HK_EPS_YN_CU","HK_EPS_YP_CU","HK_EPS_ZN_CU","HK_EPS_ZP_CU","HK_EPS_XN_TP","HK_EPS_XP_TP","HK_EPS_YN_TP","HK_EPS_YP_TP","HK_EPS_ZN_TP","HK_EPS_ZP_TP","HK_EPS_ED_PL","HK_EPS_ED_ADCS","HK_EPS_ST_ADS1_2","HK_EPS_ST_PL","HK_EPS_ST_ADCS","HK_EPS_ST_CDMS","HK_EPS_ST_BEAC","HK_EPS_ST_COM","HK_EPS_EF_PL","HK_EPS_EF_ADCS","HK_EPS_EF_CDMS","HK_EPS_EF_COM","HK_EPS_EF_EPS","HK_EPS_MODE","HK_EPS_ERROR_COD","HK_EPS_WD_T_OUT"
	},
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

function M.getCraftsList()
	return M.localData.crafts
end

function M.getMetricsList()
	return M.localData.metrics
end

--function M.getUsersList()
function M.getAllUsers()
	return M.localData.users
end

return M


