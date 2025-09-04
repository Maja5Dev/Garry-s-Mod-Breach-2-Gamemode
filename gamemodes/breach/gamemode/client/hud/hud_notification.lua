
surface.CreateFont("BR2_Notification", {
	font = "Tahoma",
	extended = false,
	size = 24,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

local current_notif = ""
local next_notif_end = 0
local notif_stage = 0
local notif_alpha = 0
function BR2_ShowNotification(text, duration)
	current_notif = text
	duration = duration or 3
	next_notif_end = CurTime() + duration
	notif_stage = 0
	notif_alpha = 0

	-- Add notification sound
end

function BR2_DrawNotifications()
	if next_notif_end > CurTime() then
		-- fade in
		if notif_stage == 0 then
			notif_alpha = notif_alpha + 3
			if notif_alpha >= 255 then
				notif_alpha = 255
				notif_stage = 1
			end
		elseif notif_stage == 1 then -- hold
			notif_alpha = 255
		end

	elseif notif_stage == 1 then
		notif_stage = 2

	elseif notif_stage == 2 then -- fade out
		notif_alpha = notif_alpha - 3
		if notif_alpha <= 0 then
			notif_stage = 0
		end
	end

	if notif_stage > 0 or next_notif_end > CurTime() then
		draw.Text({
			text = current_notif,
			pos = {ScrW() / 2, ScrH() / 1.2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR2_Notification",
			color = Color(255,255,255,notif_alpha * 0.8),
		})
	end
end

net.Receive("br2_notification", function(len)
    local text = net.ReadString()
    local duration = net.ReadFloat()

    BR2_ShowNotification(text, duration)
end)
