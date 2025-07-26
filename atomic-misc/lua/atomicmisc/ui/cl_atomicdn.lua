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

File: addons/atomic-misc/lua/atomicmisc/ui/cl_atomicdn.lua
Size: 1654 B

]===]
/*
Helper functions for UI Drawing via AtomicCDN
*/

ATOMIC = ATOMIC or {}

local cached = {}

if not file.IsDir("atomiccdn", "DATA") then
    file.CreateDir("atomiccdn")
end

function ATOMIC.CDNDL(id)
    if cached[id] then return cached[id] end

    if file.Exists("atomiccdn/" .. id .. ".png", "DATA") then
        cached[id] = Material("../data/atomiccdn/" .. id .. ".png", "noclamp mips")
        print("[CDNDL] Loaded Cashed material " .. id)
        return cached[id]
    end

    cached[id] = true

    http.Fetch("https://darkrpcdn.atomicnetworks.co/img/" .. id .. ".png", function(bod)
        file.Write("atomiccdn/" .. id .. ".png", bod)
        cached[id] = Material("../data/atomiccdn/" .. id .. ".png", "noclamp mips")
        print("[CDNDL] Cashed material " .. id)
    end, function(err)
        print("[CDNDL] ", "Invalid Material (" .. err .. ")")
    end)

    return cached[id]
end

local isColor = IsColor
function ATOMIC.DrawCDNRotated(x, y, w, h, rot, id, color)

    if isColor(color) then
        surface.SetDrawColor(color)
    else
        surface.SetDrawColor(color_white)
    end

    local mat = ATOMIC.CDNDL(id)

    if mat == true then
        local _min = math.min(w, h)
        surface.SetDrawColor(color_white)
        surface.SetMaterial(cached["spinner"])
        surface.DrawTexturedRectRotated(x + w / 2, y + h / 2, _min, _min, (CurTime() * 10) % 360)

        return
    end

    surface.SetMaterial(cached[id])
    surface.DrawTexturedRectRotated(x + w / 2, y + h / 2, w, h, rot)
end

function ATOMIC.DrawCDN(x, y, w, h, id, color)
    ATOMIC.DrawCDNRotated(x, y, w, h, 0, id, color)
end

ATOMIC.CDNDL("spinner")