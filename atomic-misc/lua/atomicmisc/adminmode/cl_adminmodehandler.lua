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

File: addons/atomic-misc/lua/atomicmisc/adminmode/cl_adminmodehandler.lua
Size: 827 B

]===]

AdminModeHandler = AdminModeHandler or {}

local convar = CreateClientConVar( "atomic_showplayersnear", "1" )

function AdminModeHandler.CreateAdminNearPanel()
    if not convar:GetBool() then return end
    AdminModeHandler.RemoveAdminNearPanel()
    AdminModeHandler.AdminNearPanel = vgui.Create( "ATOMIC.AdminMode.PlayersNear" )
    print( "[AtomicAdmin] Checking for nearby players" )
end

function AdminModeHandler.RemoveAdminNearPanel()
    if IsValid( AdminModeHandler.AdminNearPanel ) then
        AdminModeHandler.AdminNearPanel:Remove()
    end
end

hook.Add( "OnPlayerChangedTeam", "AdminModeHandler.AdminMode.OnPlayerChangedTeam", function( ply, _, newTeam )
    if newTeam ~= TEAM_STAFF then
        AdminModeHandler.RemoveAdminNearPanel()
        return
    end

    AdminModeHandler.CreateAdminNearPanel()
end )