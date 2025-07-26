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

File: addons/atomic-misc/lua/weapons/gmod_tool/stools/colour.lua
Size: 3521 B

]===]

TOOL.Category = "Render"
TOOL.Name = "#tool.colour.name"

TOOL.ClientConVar[ "r" ] = 255
TOOL.ClientConVar[ "g" ] = 255
TOOL.ClientConVar[ "b" ] = 255
TOOL.ClientConVar[ "a" ] = 255
TOOL.ClientConVar[ "mode" ] = "0"
TOOL.ClientConVar[ "fx" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

local function SetColour( ply, ent, data )

	--
	-- If we're trying to make them transparent them make the render mode
	-- a transparent type. This used to fix in the engine - but made HL:S props invisible(!)
	--
	if ( data.Color && data.Color.a < 255 && data.RenderMode == RENDERMODE_NORMAL ) then
		data.RenderMode = RENDERMODE_TRANSCOLOR
	end

	if ( data.Color ) then ent:SetColor( Color( data.Color.r, data.Color.g, data.Color.b, data.Color.a ) ) end
	if ( data.RenderMode ) then ent:SetRenderMode( data.RenderMode ) end

	if ( SERVER ) then
		duplicator.StoreEntityModifier( ent, "colour", data )
	end

end
duplicator.RegisterEntityModifier( "colour", SetColour )

function TOOL:LeftClick( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end

	local r = self:GetClientNumber( "r", 0 )
	local g = self:GetClientNumber( "g", 0 )
	local b = self:GetClientNumber( "b", 0 )
	local a = self:GetClientNumber( "a", 0 )
	local mode = self:GetClientNumber( "mode", 0 )

	SetColour( self:GetOwner(), ent, { Color = Color( r, g, b, a ), RenderMode = mode} )
	return true

end

function TOOL:RightClick( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	if ( CLIENT ) then return true end

	local clr = ent:GetColor()
	self:GetOwner():ConCommand( "colour_r " .. clr.r )
	self:GetOwner():ConCommand( "colour_g " .. clr.g )
	self:GetOwner():ConCommand( "colour_b " .. clr.b )
	self:GetOwner():ConCommand( "colour_a " .. clr.a )
	self:GetOwner():ConCommand( "colour_mode " .. ent:GetRenderMode() )

	return true

end

function TOOL:Reload( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end

	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end

	SetColour( self:GetOwner(), ent, { Color = Color( 255, 255, 255, 255 ), RenderMode = 0} )
	return true

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.colour.desc" } )

	CPanel:ToolPresets( "colour", ConVarsDefault )

	CPanel:ColorPicker( "#tool.colour.color", "colour_r", "colour_g", "colour_b", "colour_a" )

	CPanel:AddControl( "ListBox", { Label = "#tool.colour.mode", Options = list.Get( "RenderModes" ) } )

end

list.Set( "RenderModes", "#rendermode.normal", { colour_mode = 0 } )
list.Set( "RenderModes", "#rendermode.transcolor", { colour_mode = 1 } )
list.Set( "RenderModes", "#rendermode.transtexture", { colour_mode = 2 } )
list.Set( "RenderModes", "#rendermode.glow", { colour_mode = 3 } )
list.Set( "RenderModes", "#rendermode.transalpha", { colour_mode = 4 } )
list.Set( "RenderModes", "#rendermode.transadd", { colour_mode = 5 } )
list.Set( "RenderModes", "#rendermode.transalphaadd", { colour_mode = 8 } )
list.Set( "RenderModes", "#rendermode.worldglow", { colour_mode = 9 } )
