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

File: addons/atomic-misc/lua/atomicmisc/ui/elements/cl_tipjar.lua
Size: 1992 B

]===]
PIXEL.RegisterFont("Tipjar.Md", "Open Sans Bold", 30)

local PANEL = {}

function PANEL:Init()
    self:SetSize(PIXEL.Scale(500), PIXEL.Scale(200))
    self:MakePopup()
    self:Center()
end

function PANEL:SetTipjar(tipjar)
    self.tipjar = tipjar
    self.isOwner = tipjar:Getowning_ent() == LocalPlayer()
    self:SetTitle(tipjar:Getowning_ent():Name() .. "'s Tipjar")

    self.DonateButton = vgui.Create("PIXEL.TextButton", self)
    self.DonateButton:SetText("Donate")
    self.DonateAmmount = vgui.Create("PIXEL.TextEntry", self)
    self.DonateAmmount:SetNumeric(true)
    self.DonateAmmount:SetPlaceholderText("Amount")

    self.DonationList = vgui.Create("PIXEL.ScrollPanel", self)

    self.DonateButton.DoClick = function(s)
        if self.DonateAmmount:GetValue() == "" then return end
        local amount = self.DonateAmmount:GetInt()
        if amount <= 0 then return end

        net.Start("DarkRP_TipJarDonate")
            net.WriteEntity(tipjar)
            net.WriteUInt(amount, 32)
        net.SendToServer()
    end

    if self.isOwner then
        self.DonateButton:SetEnabled(false)
    end

    local lastPos = 0
    for k, v in ipairs(tipjar.madeDonations) do
        local text = v.name .. ": " .. PIXEL.FormatMoney(v.amount)
        local label = vgui.Create("PIXEL.Label", self.DonationList)
        local textW, textH = PIXEL.GetTextSize(text, "Tipjar.Md")
        label:SetText(text)
        label:SetFont("Tipjar.Md")
        label:SetSize(textW, textH)
        label:SetPos(0, lastPos)
        lastPos = lastPos + 10 + textH
    end
    self:InvalidateLayout(true)
end

function PANEL:LayoutContent(w, h)
    if not IsValid(self.tipjar) then return end
    self.DonateButton:SetPos(w * 0.05, h * 0.6)
    self.DonateAmmount:SetPos(w * 0.05, h * 0.35)
    self.DonateAmmount:SetSize(w * 0.2, h * 0.2)
    self.DonationList:SetPos(w * 0.4, h * 0.2)
    self.DonationList:SetSize(w * 0.58, h * 0.75)
end

vgui.Register("PIXEL.Tipjar", PANEL, "PIXEL.Frame")