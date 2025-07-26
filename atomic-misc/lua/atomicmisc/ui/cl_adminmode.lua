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

File: addons/atomic-misc/lua/atomicmisc/ui/cl_adminmode.lua
Size: 2480 B

]===]
local PANEL = {}

PIXEL.RegisterFont("AdminMode.Ply", "Open Sans Bold", 25)

function PANEL:Init()
end

function PANEL:PerformLayout(w, h)
    if not self.hasPlayer then return end
    self.name:Dock(LEFT)
    self.name:DockMargin(PIXEL.Scale(10), 0, 0, 0, 0)
end

function PANEL:SetPlayer(ply)
    self.name = vgui.Create("PIXEL.Label", self)

    local text = ply:Name()
    local textLength = PIXEL.GetTextSize(text, "AdminMode.Ply")

    self.name:SetText(text)
    self.name:SetFont("AdminMode.Ply")
    self.name:SetWide(textLength)

    local s5 = PIXEL.Scale(5)

    self.copyid = vgui.Create("PIXEL.TextButton", self)
    self.copyid:SetText("Copy SID64")
    self.copyid:Dock(RIGHT)
    self.copyid:DockMargin(s5, s5, s5 * 3, s5)

    self.copyid.DoClick = function(s)
        local steamid = ply:SteamID64() or "BOT"
        SetClipboardText(steamid)
        chat.AddText(PIXEL.Colors.Positive, "Copied " .. ply:Name() .. "'s SteamID to your clipboard!")
    end

    self.hasPlayer = true
end

vgui.Register("ATOMIC.AdminMode.PlayersNearItem", PANEL, "Panel")
PANEL = {}

function PANEL:Init()
    self.CloseButton:Remove()
    self:SetPos(PIXEL.Scale(650), PIXEL.Scale(850))
    self:SetSize(PIXEL.Scale(600), PIXEL.Scale(200))
    self:SetTitle("Players Near")
    self.scroll = vgui.Create("PIXEL.ScrollPanel", self)

    self.items = {}
    self.lastRun = CurTime()
end

function PANEL:LayoutContent(w, h)
    self.scroll:SetPos(0, PIXEL.Scale(35))
    self.scroll:SetSize(w, h - PIXEL.Scale(35))

    for k, v in ipairs(self.items) do
        v:Remove()
    end

    self.items = {}
    local players = {}
    local localPly = LocalPlayer()
    local s25 = PIXEL.Scale(35)

    for k, v in ipairs(player.GetAll()) do
        if v == localPly then continue end
        local result = localPly:GetPos():DistToSqr(v:GetPos()) < 200000

        if result then
            table.insert(players, v)
        end
    end

    local lastPos = 0
    for k, v in ipairs(players) do
        local item = vgui.Create("ATOMIC.AdminMode.PlayersNearItem", self.scroll)
        item:SetPlayer(v)
        item:SetSize(w, s25)
        item:SetPos(0, lastPos)
        lastPos = lastPos + s25
        table.insert(self.items, item)
    end
    self.scroll:Rebuild()
end

function PANEL:Think()
    if CurTime() - self.lastRun > 0.5 then
       self.lastRun = CurTime()
       self:InvalidateLayout(true)
    end
end

vgui.Register("ATOMIC.AdminMode.PlayersNear", PANEL, "PIXEL.Frame")