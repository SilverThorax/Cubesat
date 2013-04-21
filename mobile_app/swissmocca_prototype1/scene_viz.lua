local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
----------------------------------------------------------------------------------
--	NOTE:
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local sett = storyboard.settings

W,H = display.viewableContentWidth, display.viewableContentHeight
hW,hH = W*.5, H*.5
oX,oY = display.screenOriginX, display.screenOriginY

local charts = require("charts")

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	-----------------------------------------------------------------------------
	
	local bg = display.newRect( group, oX, oY, W, H )
	bg:setFillColor( 0, 60, 60 )
	
	
	datasets = {
		function()
			local options = {
				barThickness = 10, -- default 12
				width = W*.6, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
				height = 400, -- alike -- WARNING n'inclut pas les axes. leurs libellés, et les légendes. On ne parle que du "canevas"
				hAxis = {
					title = 'Time', -- alike
				},
				vAxis = {
					--title = 'life parameters', -- alike
					minValue = -5,
					maxValue = 20,
				},
				axisTitlesPosition = 'out', -- todo
				canvasColor = {255,255,255,60}, -- libspecific
			}
			local data = charts.newDataTable()
			data.addColumn( "string", "timestamp" )
			data.addColumn( "number", "HK_EPS_LR_COM" )
			data.addColumn( "number", "HK_EPS_LR_ADCS" )
			data.addColumn( "number", "HK_EPS_LR_CDMS" )
			data.addColumn( "number", "HK_EPS_LR_PL" )
			data.addColumn( "number", "HK_EPS_BAT1_1_V" )
			data.addRows( {
				{ 1254919329367, 1.8, nil, 6, nil, 8 },
				{ 1254835956727, 2.7, 5.4, 3, 2, 4 },
				{ 1254829817287, 4, 2.4, 8, 3.4, 3 },
				{ 1254740605880, 4.7, 2.1, 2, 6, 2 },
				{ 1254740581690, 4.5, 1.6, 1, 9.4, 1 },
				{ 1254740557343, 3.8, 0.7, 0.6, 8, 0.5 },
			} )
			return data, options
		end,

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
		
		group:insert(c)
		
	end
	
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	-----------------------------------------------------------------------------
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	-----------------------------------------------------------------------------
	
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	-----------------------------------------------------------------------------
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene