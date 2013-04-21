
local charts = require("charts")

local W,H = display.viewableContentWidth,display.viewableContentHeight

options = {
	width = W*.7,
	height = 300,
	hAxis = {
		textOffset = 40,
	},
	vAxis = {
		title = "PRODUCTIVITY",
		titleTextStyle = {
			fontSize = 30,
		},
		minValue = 0,
		maxValue = 100,
	},
	canvasColor = {255,255,255,60},
}

data = charts.newDataTable()
data.addColumn( "string", "Events" )
data.addColumn( "number", "PRODUCTIVITY" )
data.addRows( {
	{ "Before", 80 },
	{ "When I discovered 'Waking Mars'", 80 },
	{ "After", -50 },
} )

-- pass them in and voila.
local c = charts.newLineChart(data, options)
c.x, c.y = W*.2, 60





































--[[
-- below are the settings for the grid
options = {
	width = W*.7, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
	height = 300, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
	hAxis = {
		--title = 'pourcentage', -- alike
		--minValue = 0,
		--maxValue = 100
		textOffset = 40,
	},
	vAxis = { -- todo
		title = "Ana's esteem for David", -- alike
		titleTextStyle = {
			fontSize = 18,
		},
		minValue = 0,
		maxValue = 100,
	},
	axisTitlesPosition = 'out', -- todo
	canvasColor = {255,255,255,60}, -- libspecific
}

data = charts.newDataTable()
data.addColumn( "string", "Alexandra Stan" )
data.addColumn( "number", "Esteem for David" )
data.addRows( {
	{ 'Before', 80 },
	{ "Watching Alexandra Stan's video", 80 },
	{ 'After', -50 },
} )

-- pass them in and voila.
local c = charts.newLineChart(data, options)
c.x, c.y = W*.2, 60



]]--