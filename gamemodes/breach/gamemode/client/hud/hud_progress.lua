
mat_progress_bar_1 = Material("breach2/progress_bar_1_2.png")
mat_progress_bar_2 = Material("breach2/progress_bar_2.png")

progress_bar_time = nil
progress_bar_end = nil
progress_bar_text = nil
function InitiateProgressBar(end_time, text)
	progress_bar_time = end_time
	if text then
		progress_bar_text = text
	end
	progress_bar_end = CurTime() + end_time
end

function EndProgressBar()
	progress_bar_end = nil
	progress_bar_time = nil
	progress_bar_status = 0
end

function FinishProgressBar()
	EndProgressBar()
	if progress_bar_func != nil then
		progress_bar_func()
	end
end

progress_bar_status = 0
function DrawProgressBar()
	if progress_bar_end and progress_bar_time then
		if progress_bar_end < CurTime() then
			FinishProgressBar()
			return
		end
		progress_bar_status = (1 - ((progress_bar_end - CurTime()) / progress_bar_time)) * 100
	end
	if progress_bar_status == 0 then return end

	local x = ScrW()/2-158.5
	local y = ScrH()/1.3

	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(mat_progress_bar_1)
	surface.DrawTexturedRect(x, y, 317, 34)
	
	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(mat_progress_bar_2)
	surface.DrawTexturedRect(x + 8, y, 303*(math.Clamp(progress_bar_status, 0, 100)/100), 34)

	if progress_bar_text then
		draw.Text({
			text = progress_bar_text,
			pos = {ScrW() / 2, y - 16},
			font = "BR2_ProgressBarFont1",
			color = Color(255,255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end

mat_progress = {}
mat_progress["mat_progress_circle_1"] = Material("breach2/progress_circle_1.png")
for i=1, 10 do
	mat_progress["mat_progress_circle_2_"..i..""] = Material("breach2/progress_circle_2_"..i..".png")
end

progress_precision_modifier = 0.5

progress_circle_time = nil
progress_circle_end = nil
progress_circle_color = Color(255,255,255,255)
function InitiateProgressCircle(end_time)
	progress_circle_time = end_time
	progress_circle_end = CurTime() + end_time
end

progress_circle_status = 0
function DrawProgressCircle()
	if progress_circle_end and progress_circle_time then
		if progress_circle_end < CurTime() then
			progress_circle_end = nil
			progress_circle_time = nil
			progress_circle_status = 0
			if progress_circle_func != nil then
				progress_circle_func()
			end
			return
		end
		progress_circle_status = (1 - (((progress_circle_end-progress_precision_modifier) - CurTime()) / progress_circle_time)) * 10
	end
	if progress_circle_status == 0 then return end
	local posx = ScrW()/2
	local posy = ScrH()/2
	local size = 64
	surface.SetDrawColor(progress_circle_color)
	for i=1, math.Clamp(progress_circle_status, 0, 10) do
		surface.SetMaterial(mat_progress["mat_progress_circle_2_"..i..""])
		surface.DrawTexturedRect(posx-(size/2), posy-(size/2), size, size)
	end
end

print("[Breach2] client/hud/hud_progress.lua loaded!")
