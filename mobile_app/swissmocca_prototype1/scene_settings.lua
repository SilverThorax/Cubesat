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

function scene:refreshListOfSatellites()
	
	-- TODO: store in database
	
	
	
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	-----------------------------------------------------------------------------
	
	local backButton = widget.newButton{
		label = "back",
		width = 90,
		height = 35,
		font = "Arial",
		fontSize = 13,
		labelColor = { default = {0,0,0}, over = {255,255,255} },
		onEvent = function( event )
			storyboard.gotoScene( "scene_home" )
		end
	}
	group:insert( backButton )
	backButton.x, backButton.y = 10 + backButton.width*.5, 10 + backButton.height*.5
	
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