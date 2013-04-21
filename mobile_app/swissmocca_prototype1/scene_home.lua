local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
----------------------------------------------------------------------------------
--	NOTE:
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

W,H = display.viewableContentWidth, display.viewableContentHeight
hW,hH = W*.5, H*.5

local widget = require "widget"

function scene:createStaticButtons()
	local group = self.view
	
	local lastY = 675
	
	local newbutton = function( screenname )
		local button = widget.newButton{
			label = screenname,
			font = "Arial",
			fontSize = 13,
			labelColor = { default = {0,0,0}, over = {255,255,255} },
			onEvent = function( event )
				storyboard.gotoScene( "scene_"..screenname )
			end
		}
		group:insert( button )
		button.x, button.y = 10 + button.width*.5, lastY + button.height*1 + 10
		lastY = button.y
	end
	
	newbutton("inbox")
	newbutton("people")
	newbutton("about")
	newbutton("docs")
	newbutton("settings")
	
end


function scene:createDashboardsGrid()
	local group = self.view
	
	local r,c = 0,0
	local nbcols = 8
	local bsize = (W-20)/nbcols
	
	local yOff = 250
	
	local newbutton = function()
		local button = widget.newButton{
			label = "VIZ...",
			width = bsize,
			height = bsize,
			font = "Arial",
			fontSize = 28,
			labelColor = { default = {0,0,0}, over = {255,255,255} },
			onEvent = function( event )
				--storyboard.gotoScene( "scene_"..screenname )
			end
		}
		group:insert( button )
		button.x, button.y = 10 + c*bsize + button.width*.5, yOff + r*bsize + button.height*1 + 10
		c = c+1
		if c >= nbcols then
			c = 0
			r = r+1
		end
		lastY = button.y
	end
	
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	newbutton()
	
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	-----------------------------------------------------------------------------
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	-----------------------------------------------------------------------------
	
	local bg = display.newImageRect( group, "SwissCube-10-White-NOLOGO.jpg", 700, 247 )
	bg.xScale = 1.1
	bg.yScale = 1.1
	bg.x, bg.y = hW, bg.height*.5
	
	scene:createStaticButtons()
	
	scene:createDashboardsGrid()
	
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