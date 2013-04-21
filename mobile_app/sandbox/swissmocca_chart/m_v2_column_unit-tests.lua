local charts = require("charts")

local W,H = display.viewableContentWidth,display.viewableContentHeight

datasets = {
	function()
		local options = {
			barThickness = 10, -- default 12
			width = W*.6, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
			height = 400, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
			hAxis = {
				title = 'animal', -- alike
			},
			vAxis = {
				title = 'life parameters', -- alike
				minValue = -20,
				maxValue = 20,
			},
			axisTitlesPosition = 'out', -- todo
			canvasColor = {255,255,255,60}, -- libspecific
		}
		local data = charts.newDataTable()
		data.addColumn( "string", "temps" )
		data.addColumn( "number", "valeur" )
		data.addColumn( "number", "echec" )
		data.addColumn( "number", "pastis" )
		data.addColumn( "number", "snif" )
		data.addColumn( "number", "plouf" )
		data.addRows( {
			{ 'cats', 1.8, nil, 6, nil, 8 },
			{ 'horses', 2.7, 5.4, 3, 2, 4 },
			{ 'dogs', 4, 2.4, 8, 3.4, 3 },
			{ 'snakes', 4.7, 2.1, 2, 6, 2 },
			{ 'cows', 4.5, 1.6, 1, 9.4, 1 },
			{ 'ants', 3.8, 0.7, 0.6, 8, 0.5 },
		} )
		return data, options
	end,
	
	function()
		local options = {
			barThickness = 13, -- default 12
			width = W*.6, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
			height = 300, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
			hAxis = {
				title = 'animal', -- alike
			},
			vAxis = {
				title = 'population', -- alike
			},
			axisTitlesPosition = 'out', -- todo
			canvasColor = {255,255,255,60}, -- libspecific
		}
		local data = charts.newDataTable()
		data.addColumn( "string", "time" )
		data.addColumn( "number", "cats" )
		data.addColumn( "number", "horses" )
		data.addColumn( "number", "dogs" )
		data.addColumn( "number", "cows" )
		data.addColumn( "number", "chickens" )
		data.addRows( {
			{ '2006', 1.8, 3, 6, nil, 8 },
			{ '2007', 2.7, 5.4, 3, 2, 4 },
			{ '2008', 4, 2.4, 8, 3.4, 3 },
			{ '2009', 4.7, 2.1, 2, 6, 2 },
			{ '2010', 4.5, 1.6, 1, 9.4, 1 },
			{ '2011', 3.8, 0.7, 0.6, 8, 0.5 },
		} )
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


