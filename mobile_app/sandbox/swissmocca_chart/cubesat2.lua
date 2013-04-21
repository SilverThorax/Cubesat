local charts = require("charts")

local json = require "json"

local t_insert = table.insert

local W,H = display.viewableContentWidth,display.viewableContentHeight

local metrics = {"HK_EPS_LR_COM","HK_EPS_LR_ADCS"}--,"HK_EPS_LR_CDMS"}

local dummyDashboard = {
	name= "New Dashboard 4",
	satellites = {
		{
			name = "Sat1",
			metrics = {"HK_EPS_LR_COM","HK_EPS_LR_ADCS"},--,"HK_EPS_LR_CDMS"},
			--metrics = {
			--	{ name= "TEMP" },
			--	{ name= "BAT" }
			--}
		},
		{
			name = "Sat2",
			metrics = {"HK_EPS_LR_COM","HK_EPS_LR_ADCS" },--,"HK_EPS_LR_CDMS"},
			--metrics = {
			--	{ name= "TEMP" },
			--	{ name= "BAT" }
			--}
		}
	}
}

req_data = require "requests-data"

req_data.getData( { "Sat1", "Sat2"}, metrics, "2009-10-05T11:02:37.343", "2009-10-07T12:42:38.473", function(event)
	
	local allData = json.decode( event.response )
	print( event.response )
	--print( allData )
	
	if true then return end
	
	local datasets = {
	
		function()
			local options = {
				barThickness = 13, -- default 12
				width = W*.6, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
				height = 300, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
				hAxis = {
					title = 'time', -- alike
				},
				vAxis = {
					title = 'V', -- alike
				},
				axisTitlesPosition = 'out', -- todo
				canvasColor = {255,255,255,60}, -- libspecific
			}
			local data = charts.newDataTable()
			data.addColumn( "string", "timestamp" )

			for ksat,vsat in pairs( dummyDashboard.satellites ) do
				for kmet,vmet in pairs( vsat.metrics ) do
					--data.addColumn( "number", vsat.name.."_"..vmet.name )
					data.addColumn( "number", vsat.name.."_"..vmet )
				end
			end
			
			
			
			local allData_byTime = {}
			for ksat,vsat in pairs( allData ) do
				for ktime,vtime in pairs( vsat ) do
					if not allData_byTime[ktime] then
						allData_byTime[ktime] = {}
					end
					if not allData_byTime[ktime][ksat] then
						allData_byTime[ktime][ksat] = {}
					end
					for kmet,vmet in pairs( vtime ) do
						allData_byTime[ktime][ksat][kmet] = vmet
					end
				end
			end
			
			
			
			for ktime,vtime in pairs( allData_byTime ) do
				local values = {}
				for ksat,vsat in pairs( dummyDashboard.satellites ) do
					for kmet,vmet in pairs( vsat ) do
						if vtime[vsat.name][vmet] then
							t_insert( values, tonumber( vtime[vsat.name][vmet] ) )
						else
							t_insert( values, 0 )
						end
					end
				end
				data.addRow( { ktime, unpack( values ) } )
			end
			
			return data, options
			
		end
	}

	local allCharts = {}
	local yOffset = 0
	for k,v in pairs(datasets) do
		if k > 1 then
			yOffset = yOffset + allCharts[k-1].height + H*.05
		end
		local c = charts.newColumnChart( v() )
		c.x, c.y = W*.1, H*.1 + yOffset
		allCharts[k] = c
	end
	
	
	
end )



