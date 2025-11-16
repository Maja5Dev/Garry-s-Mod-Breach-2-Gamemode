
net.Receive("br_use_battery_on_item", function()
    local open = net.ReadBool()

    if open then
        CreateBatteryFrame()
    else
        if IsValid(WeaponFrame) then
            WeaponFrame:Remove()
        end
    end
end)

function CreateBatteryFrame()
	if IsValid(WeaponFrame) then
		WeaponFrame:Remove()
	end

	local font_structure = {
		font = "Tahoma",
		extended = false,
		size = 20,
		weight = 2000,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = true,
		additive = false,
		outline = false,
	}

	surface.CreateFont("BR_MEDKIT_TITLE", font_structure)
	font_structure.size = 26
	surface.CreateFont("BR_MEDKIT_CONTENT_NAME", font_structure)
	font_structure.size = 14
	surface.CreateFont("BR_MEDKIT_CONTENT_AMOUNT", font_structure)
	font_structure.size = 22
	surface.CreateFont("BR_MEDKIT_CONTENT_USE", font_structure)

	WeaponFrame = vgui.Create("DFrame")
	WeaponFrame:SetSize(400, 400)
	WeaponFrame:SetTitle("")
	WeaponFrame.Paint = function(self, w, h)
		if IsValid(self) == false then
			return false
		end

		draw.Text({
			text = "Replace battery:",
			pos = {4, 4},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_TOP,
			font = "BR_MEDKIT_TITLE",
			color = Color(255,255,255,255),
		})

		if input.IsKeyDown(KEY_ESCAPE) then
			self:KillFocus()
			self:Remove()
			gui.HideGameUI()
			return false
		end
	end

	local last_y = 24

	local weapons_with_batteries = {}

	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if isnumber(v.BatteryLevel) then
			table.ForceInsert(weapons_with_batteries, v)
		end
	end

	for k,v in pairs(weapons_with_batteries) do
		local panel = vgui.Create("DPanel", WeaponFrame)
		panel:SetSize(400 - 8, 50 - 8)
		panel:SetPos(4, 4 + last_y)
		panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 100))

			draw.Text({
				text = v.PrintName,
				pos = {16, h / 2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_MEDKIT_CONTENT_NAME",
				color = Color(255,255,255,255),
			})
		end

		local panel2 = vgui.Create("DButton", panel)
		panel2:SetPos(208, 0)
		panel2:SetSize(100 - 8, 50 - 8)
		panel2:SetText("")
		panel2.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 100))
			draw.Text({
				text = "PUT IN",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_MEDKIT_CONTENT_USE",
				color = Color(255,255,255,255),
			})
		end

		panel2.DoClick = function()
			net.Start("br_use_battery_on_item")
				net.WriteString(v:GetClass())
			net.SendToServer()
		end

		last_y = last_y + (50 - 8) + 6
	end

    if #weapons_with_batteries == 0 then
        local no_weapons_label = vgui.Create("DLabel", WeaponFrame)
        no_weapons_label:SetPos(4, 28)
        no_weapons_label:SetSize(300 - 8, 20)
        no_weapons_label:SetText("-")
        no_weapons_label:SetFont("BR_MEDKIT_CONTENT_USE")
        no_weapons_label:SetColor(Color(255,255,255,255))
        last_y = last_y + 20 + 6
    end

	WeaponFrame:SetSize(300, last_y + 4)
	WeaponFrame:Center()
	WeaponFrame:MakePopup()
end
