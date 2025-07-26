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

File: addons/atomic-misc/lua/weapons/gmod_tool/stools/weld.lua
Size: 2638 B

]===]

TOOL.Category = "Constraints"
TOOL.Name = "#tool.weld.name"

TOOL.ClientConVar[ "forcelimit" ] = "0"
TOOL.ClientConVar[ "nocollide" ] = "0"

TOOL.Information = {
	{ name = "left", stage = 0 },
	{ name = "left_1", stage = 1, op = 2 },
	{ name = "reload" }
}

function TOOL:LeftClick( trace )

	if ( self:GetOperation() == 1 ) then return false end
	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return false end

	-- If there's no physics object then we can't constraint it!
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	local iNum = self:NumObjects()
	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( CLIENT ) then

		if ( iNum > 0 ) then self:ClearObjects() end
		return true

	end

	self:SetOperation( 2 )

	if ( iNum == 0 ) then

		self:SetStage( 1 )
		return true

	end

	if ( iNum == 1 ) then

		-- Get client's CVars
		local forcelimit = self:GetClientNumber( "forcelimit" )
		local nocollide = self:GetClientNumber( "nocollide", 0 ) != 0

		-- Get information we're about to use
		local Ent1, Ent2 = self:GetEnt( 1 ), self:GetEnt( 2 )
		local Bone1, Bone2 = self:GetBone( 1 ), self:GetBone( 2 )

		local constraint = constraint.Weld( Ent1, Ent2, Bone1, Bone2, forcelimit, nocollide )
		if ( constraint ) then

			undo.Create( "Weld" )
				undo.AddEntity( constraint )
				undo.SetPlayer( self:GetOwner() )
			undo.Finish()

			self:GetOwner():AddCleanup( "constraints", constraint )

		end

		-- Clear the objects so we're ready to go again
		self:ClearObjects()

	end

	return true

end

function TOOL:Reload( trace )

	if ( !IsValid( trace.Entity ) || trace.Entity:IsPlayer() ) then return false end
	if ( CLIENT ) then return true end

	self:ClearObjects()

	return constraint.RemoveConstraints( trace.Entity, "Weld" )

end

function TOOL:FreezeMovement()

	return self:GetOperation() == 1 && self:GetStage() == 2

end

function TOOL:Holster()

	self:ClearObjects()

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.weld.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "weld", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Slider", { Label = "#tool.forcelimit", Command = "weld_forcelimit", Type = "Float", Min = 0, Max = 1000, Help = true } )
	CPanel:AddControl( "CheckBox", { Label = "#tool.nocollide", Command = "weld_nocollide" } )

end