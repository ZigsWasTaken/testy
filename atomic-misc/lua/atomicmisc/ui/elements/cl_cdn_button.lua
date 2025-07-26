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

File: addons/atomic-misc/lua/atomicmisc/ui/elements/cl_cdn_button.lua
Size: 1410 B

]===]

local PANEL = {}

AccessorFunc(PANEL, "CDNID", "CDNID", FORCE_STRING)
AccessorFunc(PANEL, "ImageSize", "ImageSize", FORCE_NUMBER)
AccessorFunc(PANEL, "NormalColor", "NormalColor")
AccessorFunc(PANEL, "HoverColor", "HoverColor")
AccessorFunc(PANEL, "ClickColor", "ClickColor")
AccessorFunc(PANEL, "DisabledColor", "DisabledColor")

function PANEL:Init()
    self.ImageCol = PIXEL.CopyColor(color_white)
    self:SetCDNID("spinner")

    self:SetNormalColor(color_white)
    self:SetHoverColor(color_white)
    self:SetClickColor(color_white)
    self:SetDisabledColor(color_white)

    self:SetImageSize(1)
end

function PANEL:PaintBackground(w, h) end

function PANEL:Paint(w, h)
    self:PaintBackground(w, h)

    local imageSize = h * self:GetImageSize()
    local imageOffset = (h - imageSize) / 2

    if not self:IsEnabled() then
        ATOMIC.DrawCDN(imageOffset, imageOffset, imageSize, imageSize, self:GetCDNID(), self:GetDisabledColor())
        return
    end

    local col = self:GetNormalColor()

    if self:IsHovered() then
        col = self:GetHoverColor()
    end

    if self:IsDown() or self:GetToggle() then
        col = self:GetClickColor()
    end

    self.ImageCol = PIXEL.LerpColor(FrameTime() * 12, self.ImageCol, col)

    ATOMIC.DrawCDN(imageOffset, imageOffset, imageSize, imageSize, self:GetCDNID(), self.ImageCol)
end

vgui.Register("PIXEL.CDNButton", PANEL, "PIXEL.Button")