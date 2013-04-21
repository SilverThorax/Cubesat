-- require "CiderDebugger";
-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
storyboard = require "storyboard"
widget = require "widget"
 
require "debug_stefan"
require "debug_marek"

storyboard.gotoScene("scene_home")
--storyboard.gotoScene("scene_inbox")