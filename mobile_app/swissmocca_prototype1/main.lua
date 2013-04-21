require "CiderDebugger";
-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
storyboard = require "storyboard"
widget = require "widget"
 
require "debug_stefan"
require "debug_marek"

local localdb = require "local-storage"

storyboard.settings = {
	showOverlayTime = 200,
	hideOverlayTime = 120,
	gotoSceneTime = 240,
}

storyboard.currentSelection = {
	sats = {},
	metrics = {}
}

for k,v in pairs( localdb.getCraftsList() ) do
	storyboard.currentSelection.sats[v.name] = false
end

storyboard.gotoScene("scene_home")
--storyboard.gotoScene("scene_inbox")