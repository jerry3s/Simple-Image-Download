-- Project: SimpleImageDownload
--
-- Date: August 19, 2010
--
-- Version: 1.0
--
-- File name: main.lua
--
-- Author: Ansca Mobile
--
-- Abstract: A simple way to load an image from the network
-- (Also demonstrates the use of external libraries.)
--
-- Demonstrates: sockets, network, ActivityIndicator
--
-- File dependencies: ui.lua library (included)
--
-- Target devices: Simulator and Device
--
-- Limitations: Requires internet access; no error checking if connection fails
--
-- Update History:
--	v1.1		Added ActivityIndicator during download; also app title on screen
--
-- Comments: 
-- Demonstrates how to download and display a remote image using the LuaSocket
-- libraries that ship with Corona. 
--
-- Note that this method blocks program execution during the download process. 
-- This can be addressed using Lua coroutines for a more "threaded" structure; 
-- future example code should demonstrate this.
--
-- Sample code is MIT licensed, see http://developer.anscamobile.com/code/license
-- Copyright (C) 2010 ANSCA Inc. All Rights Reserved.
---------------------------------------------------------------------------------------


-- Load the relevant LuaSocket modules (no additional files required for these)
local http = require("socket.http")
local ltn12 = require("ltn12")

-- Load external button library (should be in the same folder as main.lua)
local ui = require("ui")

-- Comes here after starting the HTTP image load
--
function showImage()

	-- We need to turn off the Activity Indicator in a different chunk
	native.setActivityIndicator( false )
	
	-- Normally we would io.close(myFile) but ltn12.sink.file does this for us.

	-- Display local file
	testImage = display.newImage("hello.png",system.DocumentsDirectory,60,100);
end

-- Load the image from the network
--
-- Turn on the Activity Indicator showing download
--
function loadImage()
	-- Create local file for saving data
	local path = system.pathForFile( "hello.png", system.DocumentsDirectory )
	local myFile = io.open( path, "w+b" ) 
	
	native.setActivityIndicator( true )		-- show busy

	-- Request remote file and save data to local file
	http.request{ 
    	url = "http://developer.anscamobile.com/demo/hello.png", 
    	sink = ltn12.sink.file(myFile),
	}

	-- Call the showImage function after a short time dealy
	timer.performWithDelay( 400, showImage)
end

-- Add demo button to screen
button1 = ui.newButton{default="btn.png", over="btnA.png", onRelease=loadImage, x = 160, y = 360}

-- Add label for button
b1text = display.newText( "Click To Load", 0, 0, nil, 15 )
b1text:setTextColor( 45, 45, 45, 255 ); b1text.x = 160; b1text.y = 360

-- Displays App title
title = display.newText( "Simple Image Download", 0, 30, native.systemFontBold, 20 )
title.x = display.contentWidth/2		-- center title
title:setTextColor( 255,255,0 )

