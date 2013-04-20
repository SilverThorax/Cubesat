-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
storyboard = require "storyboard"
widget = require "widget"
chartWidget = require "chartWidget"

------
-- Data

require("def_sats")
require("dat_sats")

require("docs_docs")

------

currentSatIndex = 1
currentSat = def_sats[currentSatIndex]

-----

currentSubScenes = {
	satList = nil
}

-----

splash = nil
function showSplash()
	splash = display.newImageRect("SpaceApps.png", 1027, 1280)
	splash.xOrigin = display.viewableContentWidth/2
	splash.yOrigin = display.viewableContentHeight/2
end

logo = nil
function showLogo()
	splash:removeSelf()
	splash = nil
	--
	logo = display.newImageRect("Leonardo.png", 1027, 1280)
	logo.xOrigin = display.viewableContentWidth/2
	logo.yOrigin = display.viewableContentHeight/2
end

function showDefaultScene()
	logo:removeSelf()
	logo = nil
	--
	-- load first scene
	storyboard.gotoScene( "sceneSatList", "fade", 400 ) -- 1
	--storyboard.gotoScene( "sceneSatWidgets", "fade", 400 )
	--storyboard.gotoScene( "sceneAllWidgets", "fade", 400 ) -- 2
	--storyboard.gotoScene( "sceneDocList", "fade", 400 ) -- 3
	--
	initGUI()
end

function startup()
	showSplash()
	timer.performWithDelay( 2000, showLogo, 1 )
	timer.performWithDelay( 4000, showDefaultScene, 1 )
end

startup()

function gotoSceneFromCurrentScene( toSceneName )
	if toSceneName == "sceneSatList" then
		if currentSubScenes.satList ~= nil then
			toSceneName = "sceneSatWidgets"
		else
			-- OK
		end
	end
	storyboard.gotoScene( toSceneName, "fade", 300 )
	--[[
	je voulais faire des transitions, mais ne risque-t-on pas de confondre les menus et les sous-menus ?
	en différenciant la transition (sous-menu = slide, menu = rien) on est plus pro niveau IHM...
	local fromSceneName = storyboard.getCurrentSceneName()
	if fromSceneName == "sceneSatList" then
		if toSceneName == "sceneSatList" then
			-- non sens
		elseif toSceneName == "sceneAllWidgets" then
			storyboard.gotoScene( toSceneName, "slideLeft", 400 )
		elseif toSceneName == "sceneDocList" then
			storyboard.gotoScene( toSceneName, "slideLeft", 800 )
		else then
		end
	elseif fromSceneName == "sceneAllWidgets" then
	elseif fromSceneName == "sceneDocList" then
	else then
	end
	]]--
end

--[[
function showScene(event)
	print("HELLO")
	local t = event.target
	print ("t.id="..t.id)
	local phase = event.phase
	if phase == "ended" then 
		if t.id == 1 then
			gotoSceneFromCurrentScene("sceneSatList")
		elseif t.id == 2 then
			gotoSceneFromCurrentScene("sceneAllWidgets")
		elseif t.id == 3 then
			gotoSceneFromCurrentScene("sceneDocList")
		end
		tabBar.selected(t)
	end
	return true
end
]]--

function initGUI()
	--
	-- Display objects added below will not respond to storyboard transitions
	--
	
	-- table to setup tabBar buttons
	local tabButtons = {
		{ label="Satellites", up="iconSats.png", down="iconSats-down.png", width = 59, height = 40, size = 12, labelColor = { 179, 169, 200, 255 }, selected=true, onPress=function(event) gotoSceneFromCurrentScene("sceneSatList") end },
		{ label="Data", up="iconData.png", down="iconData-down.png", width = 54, height = 40, size = 12, labelColor = { 179, 169, 200, 255 }, onPress=function(event) gotoSceneFromCurrentScene("sceneAllWidgets") end },
		{ label="Documents", up="iconDocs.png", down="iconDocs-down.png", width = 32, height = 40, size = 12, labelColor = { 179, 169, 200, 255 }, onPress=function(event) gotoSceneFromCurrentScene("sceneDocList") end },
	}
	
	-- create the actual tabBar widget
	local tabBar = widget.newTabBar{
		top = display.contentHeight - 75,	-- 50 is default height for tabBar widget
		buttons = tabButtons,
		height = 75,
		background = "tabBarBackground.png",
		--bottomFill = { 121, 108, 148, 255 },
	}

end
