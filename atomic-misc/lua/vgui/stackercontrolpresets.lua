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

File: addons/atomic-misc/lua/vgui/stackercontrolpresets.lua
Size: 867 B

]===]
--[[--------------------------------------------------------------------------
-- 	Namespace Tables
--------------------------------------------------------------------------]]--

local PANEL = {}

--[[--------------------------------------------------------------------------
--	Namespace Functions
--------------------------------------------------------------------------]]--

--[[--------------------------------------------------------------------------
--
--	PANEL:OpenPresetEditor()
--
--]]--
function PANEL:OpenPresetEditor()
	if ( not self.m_strPreset ) then return end
	self.Window = vgui.Create( "StackerPresetEditor" )
	self.Window:MakePopup()
	self.Window:Center()
	self.Window:SetType( self.m_strPreset )
	self.Window:SetConVars( self.ConVars )
	self.Window:SetPresetControl( self )
end

vgui.Register( "StackerControlPresets", PANEL, "ControlPresets" )