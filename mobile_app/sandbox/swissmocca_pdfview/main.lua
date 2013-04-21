require "CiderDebugger";alwaysLoadUrlRequest = function(e) return true end
 
display.setStatusBar( display.HiddenStatusBar )

W,H = display.viewableContentWidth, display.viewableContentHeight
hW,hH = W*.5, H*.5

--native.showWebPopup( 0, 0, display.viewableContentWidth, display.viewableContentHeight, "OnyxSatellite_SS.pdf", {baseUrl=system.ResourceDirectory, urlRequest=alwaysLoadUrlRequest} )

local wv = native.newWebView( 0, 50, W, H-50 )

wv:request( "OnyxSatellite_SS.pdf", system.ResourceDirectory )


