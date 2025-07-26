--[===[
 _    _______  ___  _____ _____ _   _   _____ _   _
| |  | | ___ \/ _ \|_   _|_   _| | | | /  ___| | | |
| |  | | |_/ / /_\ \ | |   | | | |_| | \ `--.| | | |
| |/\| |    /|  _  | | |   | | |  _  |  `--. \ | | |
\  /\  / |\ \| | | |_| |_  | | | | | |_/\__/ / |_| |
 \/  \/\_| \_\_| |_/\___/  \_/ \_| |_(_)____/ \___/


Files stolen by https://wraith.su - Premium Garry's Mod Cheat

Server Name : ☢️DarkRP.gg ┇ AtomicRP 1 ┇ 22 Tickrate
Server IP : CLIENT

File: addons/atomic-misc/lua/autorun/init_improvedstacker.lua
Size: 531 B

]===]
if ( SERVER ) then
	
	-- needed for custom vgui controls in the menu
	AddCSLuaFile( "vgui/stackercontrolpresets.lua" )
	AddCSLuaFile( "vgui/stackerdnumslider.lua" )
	AddCSLuaFile( "vgui/stackerpreseteditor.lua" )
	
	-- convenience modules
	AddCSLuaFile( "improvedstacker/improvedstacker.lua" )
	AddCSLuaFile( "improvedstacker/localify.lua" )
	
else

	-- needed for custom vgui controls in the menu
	include( "vgui/stackercontrolpresets.lua" )
	include( "vgui/stackerdnumslider.lua" )
	include( "vgui/stackerpreseteditor.lua" )

end