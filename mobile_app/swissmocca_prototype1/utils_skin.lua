local M = {}

M.param = 0

function M.getBasicToggleButton( onCallback, offCallback )
	local g = display.newGroup()
	g.on = display.newGroup()
	g.off = display.newGroup()
	g:insert(g.on)
	g:insert(g.off)
	g.on.isVisible = false
	g.toggleState = false
	g.toggle = function( performCallbacks )
		g.toggleState = not g.toggleState
		if g.toggleState then
			g.off.isVisible = false
			g.on.isVisible = true
			g.on:toFront()
			if performCallbacks then onCallback() end
		else
			g.on.isVisible = false
			g.off.isVisible = true
			g.off:toFront()
			if performCallbacks then offCallback() end
		end
	end
	g:addEventListener( "touch", function( event )
		if event.phase == "ended" then g.toggle( true ) end
	end )
	return g
end

function M.getSatelliteToggleButton( satData, onCallback, offCallback )
	local b = M.getBasicToggleButton( onCallback, offCallback )
	
	local r_on = display.newRect( b.on, 0,0, 200, 100 )
	r_on:setFillColor( 255, 255, 0 )
	
	local r_off = display.newRect( b.off, 0,0, 200, 100 )
	r_off:setFillColor( 255, 255, 255 )
	
	return b
end

return M


