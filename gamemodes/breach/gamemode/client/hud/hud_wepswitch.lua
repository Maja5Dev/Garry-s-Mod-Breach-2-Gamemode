
if IsValid(WepSwitchFrame) then
	WepSwitchFrame:Remove()
end

--WepSwitchFrame = nil
wep_selected = nil
local usedslot = nil
local nextstop = 0

hook.Add("Think", "BR2_WepSwitchThink", function()
	if IsValid(WepSwitchFrame) and CurTime() > nextstop then
		usedslot = nil
		nextstop = 0
		CloseWEP()
	end
end)

function CloseWEP()
	if !IsValid(WepSwitchFrame) then return end
	WepSwitchFrame:SetVisible(false)
	WepSwitchFrame:Close()
	WepSwitchFrame = nil
end

function Switch_SelectPrev()
	local client = LocalPlayer()
	if client:IsSpectator() or !client:Alive() or client:IsFrozen() then return end

	local weps = {}
	table.Add(weps, client:GetWeapons())
	if #weps < 1 then return end

	table.sort(weps, function(a, b) return a:GetSlot() > b:GetSlot() end)
	weps = table.Reverse(weps)

	if usedslot == nil then
		for k,v in pairs(weps) do
			if v == client:GetActiveWeapon() then
				usedslot = k + 1
			end
		end
	else
		usedslot = usedslot + 1
	end

	if usedslot > #weps then
		usedslot = 1
	elseif usedslot < 1 then
		usedslot = #weps
	end

	if IsValid(weps[usedslot]) then
		OpenSlot(weps[usedslot]:GetSlot() + 1)
	end
end

function Switch_SelectNext()
	local client = LocalPlayer()
	if client:IsSpectator() or !client:Alive() or client:IsFrozen() then return end
	
	local weps = {}
	table.Add(weps, client:GetWeapons())
	if #weps < 1 then return end

	table.sort(weps, function(a, b) return a:GetSlot() > b:GetSlot() end)
	weps = table.Reverse(weps)

	if usedslot == nil then
		for k,v in pairs(weps) do
			if v == client:GetActiveWeapon() then
				usedslot = k - 1
			end
		end
	else
		usedslot = usedslot - 1
	end

	if usedslot > #weps then
		usedslot = 1
	elseif usedslot < 1 then
		usedslot = #weps
	end

	if IsValid(weps[usedslot]) then
		OpenSlot(weps[usedslot]:GetSlot() + 1)
	end
end

next_wepswitch = 0
wepswitch_slot = 0
function OpenSlot(slot)
	--if next_wepswitch > CurTime() then return end
	--next_wepswitch = CurTime() + 0.2
	local ply = LocalPlayer()
	if LocalPlayer():IsSpectator() or !LocalPlayer():Alive() then return end
	nextstop = CurTime() + 1
	wepswitch_slot = slot
	if WepSwitchFrame then
		CloseWEP()
		--return
	end
	
	WepSwitchFrame = vgui.Create("DFrame")
	WepSwitchFrame:SetTitle("")
	WepSwitchFrame:SetSize(300, ScrH())
	WepSwitchFrame:SetPos(ScrW() - 300,0)
	WepSwitchFrame:SetDeleteOnClose(true)
	WepSwitchFrame:SetVisible(true)
	WepSwitchFrame:SetDraggable(false)
	WepSwitchFrame:ShowCloseButton(false)
	WepSwitchFrame:MakePopup()
	WepSwitchFrame:SetMouseInputEnabled(false)
	WepSwitchFrame:SetKeyboardInputEnabled(false)
	WepSwitchFrame.Paint = function(self, w, h) end
	WepSwitchFrame.OnClose = function() end
	
	local weps = {}
	table.Add(weps, ply:GetWeapons())
	table.sort(weps, function(a, b) return a:GetSlot() > b:GetSlot() end)
	
	local num = 0
	for k,v in ipairs(weps) do
		if not v then return end
		local panel_w = 500
		local panel_h = 40
		local panel = vgui.Create("DPanel", WepSwitchFrame)
		panel:SetPos(0, (ScrH() - 44) - (num * (panel_h)))
		panel:SetSize(panel_w, panel_h)
		panel.Paint = function(self, w, h)
			if !IsValid(v) then
				if IsValid(WepSwitchFrame) then
					WepSwitchFrame:Remove()
				end
				return
			end
			local color = Color(25, 25, 25, 175)
			if (v:GetSlot() + 1) == wepswitch_slot then
				--wep_selected = v:GetClass()
				wep_selected = v
				color = Color(55, 64, 70, 245)
			end
			if !IsValid(v) or not v then
				if WepSwitchFrame == nil then return end
				WepSwitchFrame:SetVisible(false)
				WepSwitchFrame:Close()
				WepSwitchFrame = nil
				return
			end
			draw.RoundedBox(0, 0, 0, w, h, color)
			draw.Text({
				text = v:GetPrintName(),
				font = "BR2_WepSelectName",
				pos = {33,h/2},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_CENTER,
			})
		end
		
		local islot = vgui.Create("DPanel", panel)
		islot:SetSize(25, panel_h)
		islot.Paint = function(self, w, h)
			if v == nil or !IsValid(v) then
				CloseWEP()
				return
			end
			draw.RoundedBox(0, 0, 0, w, h, Color(50,50,58,255))
			draw.Text({
				text = v:GetSlot() + 1,
				font = "BR2_WepSelectSlot",
				pos = {w/2, h/2},
				color = Color(255,255,255,255),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			})
		end
		
		num = num + 1
	end
end

local metapl = FindMetaTable("Player")
function metapl:SafeSelectWeapon(class)
	if class == nil or !self:HasWeapon(class) then return end
	self.DoWeaponSwitch = self:GetWeapon(class)
end

hook.Add("CreateMove", "WeaponSwitch", function(cmd)
	if !IsValid(LocalPlayer().DoWeaponSwitch) then return end

	cmd:SelectWeapon(LocalPlayer().DoWeaponSwitch)

	if LocalPlayer():GetActiveWeapon() == LocalPlayer().DoWeaponSwitch then
		LocalPlayer().DoWeaponSwitch = nil
	end
end)

print("[Breach2] cl_wepswitch.lua loaded!")