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

File: addons/atomic-misc/lua/vgui/stackerdnumslider.lua
Size: 1599 B

]===]
--[[--------------------------------------------------------------------------
-- 	Namespace Tables
--------------------------------------------------------------------------]]--

local PANEL = {}

--[[--------------------------------------------------------------------------
-- 	Localized Functions & Variables
--------------------------------------------------------------------------]]--

local math = math
local vgui = vgui
local tonumber = tonumber

--[[--------------------------------------------------------------------------
--	Namespace Functions
--------------------------------------------------------------------------]]--

--[[--------------------------------------------------------------------------
--
--	PANEL:SetValue( string, boolean )
--
--]]--
function PANEL:SetValue( val, bSuppress )
	val = math.Clamp( tonumber( val ) or 0, self:GetMin(), self:GetMax() )

	if ( val == nil ) then return end
	if ( self:GetValue() == val ) then return end

	self.Scratch:SetFloatValue( val )
	self:ValueChanged( self:GetValue(), bSuppress )
end

--[[--------------------------------------------------------------------------
--
--	PANEL:ValueChanged( string, value)
--
--]]--
function PANEL:ValueChanged( val, bSuppress )
	val = math.Clamp( tonumber( val ) or 0, self:GetMin(), self:GetMax() )
	self.Slider:SetSlideX( self.Scratch:GetFraction( val ) )	
	if ( self.TextArea ~= vgui.GetKeyboardFocus() ) then
		self.TextArea:SetValue( self.Scratch:GetTextValue() )
	end
	if ( not bSuppress ) then
		self:OnValueChanged( val )
	end
end

vgui.Register( "StackerDNumSlider", PANEL, "DNumSlider" )