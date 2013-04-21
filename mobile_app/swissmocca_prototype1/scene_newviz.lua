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

local widget = require "widget"

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	-----------------------------------------------------------------------------
	
	local bg = display.newRect( group, oX, oY, W, H )
	bg:setFillColor( 0, 0, 255 )
	
	local selectSatsButton = function()
		local button = widget.newButton{
			label = "Select sats",
			width = 200,
			font = "Arial",
			fontSize = 28,
			labelColor = { default = {0,0,0}, over = {255,255,255} },
			onEvent = function( event )
				if event.phase == "ended" then
					storyboard.showOverlay( "scene_over_selectsats", { effect = "fromRight", time = sett.showOverlayTime, isModal = true } )
				end
			end
		}
		group:insert( button )
		button.x, button.y = 400, 200
	end
	selectSatsButton()
	
	
	
	local selectMetricsButton = function()
		local button = widget.newButton{
			label = "Select metrics",
			width = 200,
			font = "Arial",
			fontSize = 28,
			labelColor = { default = {0,0,0}, over = {255,255,255} },
			onEvent = function( event )
				if event.phase == "ended" then
					storyboard.showOverlay( "scene_over_selectmetrics", { effect = "fromRight", time = sett.showOverlayTime, isModal = true } )
				end
			end
		}
		group:insert( button )
		button.x, button.y = 400, 300
	end
	selectMetricsButton()
	
	
	
	local visualizeSelectionButton = function()
		local button = widget.newButton{
			label = "Visualize",
			width = 200,
			font = "Arial",
			fontSize = 28,
			labelColor = { default = {0,0,0}, over = {255,255,255} },
			onEvent = function( event )
				if event.phase == "ended" then
					storyboard.gotoScene( "scene_viz", { effect = "slideLeft", time = sett.gotoSceneTime } )
				end
			end
		}
		group:insert( button )
		button.x, button.y = 400, 600
	end
	visualizeSelectionButton()
	
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