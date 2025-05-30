--lua_run_cl BR_CreateChatFrame()

surface.CreateFont("BR_CHAT1", {
	font = "Tahoma",
	extended = false,
	size = 30,
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

surface.CreateFont("BR_CHAT2", {
	font = "Tahoma",
	extended = false,
	size = 30,
	weight = 500,
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
})

surface.CreateFont("BR_CHAT3", {
	font = "Tahoma",
	extended = false,
	size = 27,
	weight = 500,
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

function GM:StartChat()
	return true
end

--lua_run_cl add_chat_notification({"test", Color(255,200,0,150)})
add_chat_notification = function(...)
	local args = {...}
	table.ForceInsert(chat_notifications, {args, CurTime()})
end

br2_chat_commands = {
	{
		cmd = "/cmds/",
		func = function()
			for i,v in ipairs(br2_chat_commands) do
				chat.AddText(i .. " - " .. v.cmd)
			end
		end
	},
	{
		cmd = "/clear/",
		func = function()
			if IsValid(chat_frame) and IsValid(chat_frame.textPanel) then
				chat_frame.textPanel:SetText("")
			end
		end
	},
	{
		cmd = "/chatrestart/",
		func = function()
			if IsValid(chat_frame) then
				chat_frame:Remove()
			end
		end
	}
}

chat_notifications = {}
local notif_time = 4
local notif_speed = 100
hook.Add("DrawOverlay", "BR2_DrawNotifs", function()
	if !BR2_ShouldDrawAnyHud() then return end
	local collisions = {}

	for k1,v1 in ipairs(chat_notifications) do
		if v1[3] != true then
			for k2,v2 in ipairs(chat_notifications) do
				if v1[2] == v2[2] then
					v1[3] = true
					table.ForceInsert(collisions, v1)
				end
			end
		end
	end

	for i,v in ipairs(collisions) do
		v[2] = v[2] + 0.00001 * i
	end

	table.sort(chat_notifications, function(a, b) return a[2] > b[2] end)

	for i,v in ipairs(chat_notifications) do
		local alpha = 120
		if v[2] + notif_time < CurTime() then
			alpha = 120 - ((CurTime() - (v[2] + notif_time)) * notif_speed)
		end

		local last_size = 0
		for k,v2 in pairs(v[1]) do
			local Tx, Ty = draw.Text({
				text = v2[1],
				pos = {20 + last_size, ScrH()/1.5-((i-1)*28)},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_CHAT3",
				color = Color(v2[2]["r"], v2[2]["g"], v2[2]["b"], alpha),
			})
			last_size = last_size + Tx
		end

		if alpha < 1 then
			table.RemoveByValue(chat_notifications, v)
		end
	end
end)

concommand.Add("br2_reset_chat", function(ply, cmd, args)
	if IsValid(chat_frame) then
		chat_frame:Remove()
	end
end)

local oldScrW = ScrW()
local function create_proper_chat_frame(size_w, size_h)
	chat_frame = vgui.Create("DFrame")
	chat_frame:ShowCloseButton(false)
	chat_frame:SetSizable(false)
	chat_frame:SetDraggable(false)
	chat_frame:SetSize(size_w, size_h)
	chat_frame:SetPos(10, ScrH()-size_h-10)
	chat_frame:SetDeleteOnClose(false)
	chat_frame:SetTitle("")
	chat_frame.Think = function(self, w, h)
		chat_frame:SetPos(10, ScrH()-size_h-10)
	end
	oldScrW = ScrW()
end

local our_messages = {}
function BR_CreateChatFrame(pop_up)
	if !BR2_ShouldDrawAnyHud() then return end
	if IsValid(chat_frame) and IsValid(chat_frame.textPanel) then
		chat_frame.textPanel:GotoTextEnd()
	end
	
	local chat_color = Color(25,27,29,255)
	local size_w = math.Clamp(ScrW()/3.5, 400, ScrW())
	local size_h = math.Clamp(ScrH()/3.5, 225, ScrH())
	if pop_up then
		if IsValid(chat_frame) and oldScrW == ScrW() then
			chat_frame:SetVisible(true)
			chat_frame:MakePopup()
			if chat_input_panel and IsValid(chat_input_panel) then
				chat_input_panel:RequestFocus()
			end
			return
		else
			create_proper_chat_frame(size_w, size_h)
			chat_frame:MakePopup()
		end
	else
		create_proper_chat_frame(size_w, size_h)
		chat_frame:SetVisible(false)
		chat_frame:KillFocus()
	end

	local gap = 8
	chat_frame.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(chat_color.r, chat_color.g, chat_color.b, 140))
		--draw.RoundedBox(0, gap, gap, w-(gap*2), h-(gap*2), Color(0, 0, 0, 180))
		
		--if input.IsKeyDown(KEY_ESCAPE) then
			--chat_frame:Close()
			--gui.HideGameUI()
		--end
	end
	
	chat_input_panel = vgui.Create("DTextEntry", chat_frame)
	chat_input_panel:SetPos(gap, size_h*0.8)
	chat_input_panel:SetSize(size_w-(gap*2), size_h*0.2-gap)
	chat_input_panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(chat_color.r, chat_color.g, chat_color.b, 180))
		local dtext = self:GetText()
		if #dtext < 1 then
			dtext = "Write a message"
		end
		draw.Text({
			text = dtext,
			pos = {10, h/2},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_CHAT2",
			color = Color(255,255,255,80),
		})
	end

	if pop_up then
		chat_input_panel:RequestFocus()
	end

	chat_input_panel:SetMouseInputEnabled(true)
	chat_input_panel:SetKeyBoardInputEnabled(true)
	chat_input_panel:SetText("")
	local function finish_typing(txt)
		local txt = chat_input_panel:GetText()
		for k,v in pairs(br2_chat_commands) do
			if txt == v.cmd then
				v.func()
				chat_input_panel:SetText("")
				return
			end
		end

		if txt == "" then
			chat_frame:Close()
			if chat_input_panel and IsValid(chat_input_panel) and chat_input_panel:HasFocus() then
				chat_input_panel:KillFocus()
			end
			gui.HideGameUI()
			return true
		end
		
		if string.Trim(txt) != "" then
			table.ForceInsert(our_messages, txt)
			LocalPlayer():ConCommand("say "..txt)
		end
		chat_input_panel:SetText("")
	end

	chat_input_panel.OnKeyCodeTyped = function(self, key)
		local txt = chat_input_panel:GetText()
		if key == KEY_UP or key == KEY_DOWN then
			if #our_messages > 0 then
				local found = false
				for i,v in ipairs(our_messages) do
					if v == txt then
						if key == KEY_UP then
							if our_messages[i-1] then
								chat_input_panel:SetText(our_messages[i-1])
								found = true
							end
						else
							if our_messages[i+1] then
								chat_input_panel:SetText(our_messages[i+1])
								found = true
							end
						end
					end
				end
				if found == false then
					if key == KEY_UP then
						chat_input_panel:SetText(our_messages[#our_messages])
					else
						chat_input_panel:SetText(our_messages[1])
					end
				end
			end

		elseif key == KEY_ESCAPE then
			chat_input_panel:SetText("")
			chat_frame:Close()
			if chat_input_panel and IsValid(chat_input_panel) and chat_input_panel:HasFocus() then
				chat_input_panel:KillFocus()
			end
			gui.HideGameUI()

		elseif key == KEY_ENTER then
			finish_typing()
		end
	end
	
	local chat_enter_button = vgui.Create("DButton", chat_input_panel)
	chat_enter_button:SetText("")
	chat_enter_button:Dock(RIGHT)
	chat_enter_button:SetSize((size_w-(gap*2))*0.2, 0)
	chat_enter_button.Paint = function(self, w, h)
		--draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 180))
		draw.Text({
			text = "SEND",
			pos = {w/2, h/2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			font = "BR_CHAT1",
			color = Color(255,255,255,80),
		})
	end

	chat_enter_button.DoClick = function()
		finish_typing()
	end
	
	if !chat_frame.textPanel then
		chat_frame.textPanel = vgui.Create("RichText", chat_frame)
		local chat_text_panel = chat_frame.textPanel
		chat_text_panel:SetPos(gap, gap)
		chat_text_panel:SetSize(size_w-(gap*2), (size_h-(gap*2)) - size_h*0.2)
		chat_text_panel:SetText("")
		function chat_text_panel:PerformLayout()
			chat_text_panel:SetFontInternal("BR_CHAT3")
			chat_text_panel:SetFGColor(Color(255, 255, 255))
		end
		chat_text_panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(chat_color.r, chat_color.g, chat_color.b, 180))
		end
	end
end

hook.Add("ChatText", "BR_Chat_ServerNotifications", function(index, name, text, mtype)
	if mtype == "joinleave" or mtype == "none" then
		if !IsValid(chat_frame) then
			BR_CreateChatFrame(false)
		end

		if IsValid(chat_frame) and IsValid(chat_frame.textPanel) then
			if !chat_frame:IsVisible() then
				table.ForceInsert(chat_notifications, {{{text, Color(255,255,255)}}, CurTime()})
			end
			chat_frame.textPanel:InsertColorChange(66, 217, 244, 255)
			chat_frame.textPanel:AppendText(text.."\n")
		end
	end
	return true
end)

local oldAddText = chat.AddText
function chat.AddText(...)
	if IsValid(chat_frame) and IsValid(chat_frame.textPanel) then
		local args = {...}
		
		for _, obj in pairs(args) do
			if type(obj) == "table" then
				chat_frame.textPanel:InsertColorChange(obj.r, obj.g, obj.b, 255)
			elseif type(obj) == "string" then
				chat_frame.textPanel:AppendText(obj)
			elseif obj:IsPlayer() then
				local col = GAMEMODE:GetTeamColor(obj)
				chat_frame.textPanel:InsertColorChange(col.r, col.g, col.b, 255)
				chat_frame.textPanel:AppendText(obj:Nick())
			end
		end

		if !chat_frame:IsVisible() then
			local next_color = Color(255,255,255,255)
			local whole_text = {}
			
			for _, obj in pairs(args) do
				if type(obj) == "table" then
					next_color = Color(obj.r, obj.g, obj.b, 255)
				elseif type(obj) == "string" then
					table.ForceInsert(whole_text, {obj, next_color})
					next_color = Color(255,255,255,255)
				elseif obj:IsPlayer() then
					table.ForceInsert(whole_text, {obj:Nick(), GAMEMODE:GetTeamColor(obj)})
					next_color = Color(255,255,255,255)
				end
			end

			if #whole_text > 0 then
				table.ForceInsert(chat_notifications, {whole_text, CurTime()})
			end
		end
		chat_frame.textPanel:AppendText("\n")
	end
end

print("[Breach2] client/cl_chat.lua loaded!")
