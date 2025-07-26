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

File: addons/atomic-misc/lua/atomicmisc/sh_nocollide.lua
Size: 674 B

]===]

local noCollideEnts = {
    ["spawned_ammo"] = true
}

local function checkShouldNoCollide( ent )
    if noCollideEnts[ent:GetClass()] then
        timer.Simple( 0, function()
            if IsValid( ent ) then
                ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
            end
        end )
    end
end

hook.Add( "OnEntityCreated", "AtomicRP.NoCollide.OnEntityCreated", checkShouldNoCollide )
hook.Add( "playerBoughtCustomEntity", "AtomicRP.NoCollide.playerBoughtCustomEntity", function( _, _, ent ) checkShouldNoCollide( ent ) end )
hook.Add( "playerBoughtAmmo", "AtomicRP.NoCollide.playerBoughtAmmo", function( _, _, ent ) checkShouldNoCollide( ent ) end )