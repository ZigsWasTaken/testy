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

File: addons/atomic-misc/lua/vgui/stackerpreseteditor.lua
Size: 1435 B

]===]
--[[--------------------------------------------------------------------------
-- 	Namespace Tables
--------------------------------------------------------------------------]]--

local PANEL = {}

--[[--------------------------------------------------------------------------
-- 	Localized Functions & Variables
--------------------------------------------------------------------------]]--

local vgui = vgui
local pairs = pairs
local AccessorFunc = AccessorFunc
local GetConVarString = GetConVarString

--[[--------------------------------------------------------------------------
--	Namespace Functions
--------------------------------------------------------------------------]]--

AccessorFunc( PANEL, "m_ConCommands", "ConCommands" )

--[[--------------------------------------------------------------------------
--
--	PANEL:Add()
--
--]]--
function PANEL:Add()
	if ( not self.m_ConVars ) then return end
	
	local ToName = self.txtName:GetValue()
	if ( not ToName or ToName == "" ) then return end
	
	-- Todo, Handle name collision
	local tabValues = {}
	
	for k, v in pairs( self.m_ConVars ) do
		tabValues[ v.CCmd ] = GetConVarString( v.CVar )
	end
		
	presets.Add( self.m_strType, ToName, tabValues )
	self:Update()
	self.PresetList:SelectByName( ToName )
	self.txtName:SetText( "" )
	
	if ( self.m_PresetControl ) then
		self.m_PresetControl:Update()
	end
end

vgui.Register( "StackerPresetEditor", PANEL, "PresetEditor" )