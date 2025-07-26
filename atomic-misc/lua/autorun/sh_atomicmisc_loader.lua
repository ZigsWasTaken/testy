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

File: addons/atomic-misc/lua/autorun/sh_atomicmisc_loader.lua
Size: 843 B

]===]
ATOMIC = ATOMIC or {}

local function loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")

    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v
        print("Including " .. dirs)
        if v:StartWith("cl_") then
            if SERVER then AddCSLuaFile(dirs)
            else include(dirs) end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then include(dirs) end
        end
    end

    for k,v in ipairs(fol) do
        loadDirectory(dir .. "/" .. v)
    end
end

local function loadAddon()
    print("[Atomic Misc] Loading")
    loadDirectory("atomicmisc")
    print("[Atomic Misc] Loaded")
end

if PIXEL.UI then
    loadAddon()
    return
end

hook.Add("PIXEL.UI.FullyLoaded", "ATOMIC.Misc.WaitForPIXELUI", loadAddon)


