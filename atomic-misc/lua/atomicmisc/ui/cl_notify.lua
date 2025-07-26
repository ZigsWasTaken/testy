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

File: addons/atomic-misc/lua/atomicmisc/ui/cl_notify.lua
Size: 1899 B

]===]
local notifyList = {}

net.Receive("ATOMIC.DarkRP.Notify", function()
    local topText = net.ReadString()
    local bottomText = net.ReadString()
    table.insert(notifyList, {
        top = topText,
        bot = bottomText,
        startTime = 0
    })
end)

PIXEL.RegisterFont("DarkRPNotify.Text", "Open Sans SemiBold", 32)

local scrw, scrh = ScrW, ScrH
local curTime = CurTime
local lerp = Lerp
local max = math.max
local frameTime = FrameTime
local yPos = -scrh()
hook.Add("HUDPaint", "ATOMIC.DarkRP.Notify", function()
    if not notifyList[1] then return end
    local w, h = scrw(), scrh()
    local ft = frameTime() * 5

    local notify = notifyList[1]
    local time = curTime()
    if notify.scrollOut then
        yPos = lerp(ft, yPos, notify.lerpPos)
        if yPos <= notify.lerpPos * 0.9 then table.remove(notifyList, 1) end
    else
        yPos = lerp(ft, yPos, 0)
    end

    if notify.startTime == 0 then notify.startTime = time end
    local topW, topH = PIXEL.GetTextSize(notify.top, "DarkRPNotify.Text")
    local botW, botH = PIXEL.GetTextSize(notify.bot, "DarkRPNotify.Text")
    if notify.bot == "" then botW = 0 botH = 0 end
    local alertW = PIXEL.GetTextSize("Alert", "DarkRPNotify.Text")
    local tW = max(topW, botW, alertW) + PIXEL.Scale(100)
    local tH = topH + botH + PIXEL.Scale(50)
    wPos = w * 0.5

    PIXEL.DrawRoundedBox(PIXEL.Scale(6), wPos - tW / 2, h * 0.052 + yPos, tW, tH, PIXEL.Colors.Header)
    PIXEL.DrawSimpleText("Alert", "DarkRPNotify.Text", wPos, h * 0.07 + yPos, PIXEL.Colors.PrimaryText, 1, 1)
    PIXEL.DrawSimpleText(notify.top, "DarkRPNotify.Text", wPos, h * 0.1 + yPos, PIXEL.Colors.PrimaryText, 1, 1)
    PIXEL.DrawSimpleText(notify.bot, "DarkRPNotify.Text", wPos, h * 0.13 + yPos, PIXEL.Colors.PrimaryText, 1, 1)

    if time - notify.startTime >= 3 then
        notify.scrollOut = true
        notify.lerpPos = -tW
    end
end)