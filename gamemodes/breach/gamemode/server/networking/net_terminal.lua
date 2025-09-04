
net.Receive("br_use_terminal_function", function(len, ply)
	if len < 256 and !ply:IsSpectator() and ply:Alive() and ply.br_downed == false and ply.lastTerminal != nil then
		if ply.terminal_delay > CurTime() then return end
		ply.terminal_delay = CurTime() + 0.1

		local str_got = net.ReadString()

		for k,v in pairs(BR2_TERMINALS) do
			if ply.lastTerminal == v then
				if v.pos:Distance(ply:GetPos()) < 170 and istable(v.Info.SettingsFunctions) then
					for k2,v2 in pairs(v.Info.SettingsFunctions) do
						if v2.class == str_got then
							v2.server.func(ply)
							return
						end
					end
				end
				return
			end
		end
	end
end)

net.Receive("br_open_brokenterminal", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() or ply.nextBTerminal > CurTime() then return end

	local net_vec = net.ReadVector()

	for k,v in pairs(MAPCONFIG.BUTTONS_2D.BROKEN_TERMINALS.buttons) do
		if v.pos == net_vec then
			if v.pos:Distance(ply:GetPos()) < 160 then
				local effectdata = EffectData()
				effectdata:SetOrigin(v.pos)
				util.Effect("MetalSpark", effectdata, true)
				sound.Play("weapons/stunstick/spark"..math.random(1,3)..".wav", v.pos, 150, 100, 1)
				sound.Play("ambient/energy/spark"..math.random(5,6)..".wav", v.pos, 150, 100, 1)
				ply:PrintMessage(HUD_PRINTTALK, "You try to start the terminal but an electric shock zaps your hand...")
				ply.nextBTerminal = CurTime() + 5

				ply:TakeDamage(5, ply)
				ply:ViewPunch(Angle(math.random(-30,30), math.random(-30,30), 0))
				ply:SendLua("StunBaton_GotStunned()")
			end
			return
		end
	end
end)

net.Receive("br_open_terminal", function(len, ply)
	if ply:Alive() == false or ply:IsSpectator() then return end
	
	local net_str = net.ReadString()
	if #net_str < 2 then return end
	local login = net.ReadString()
	local password = net.ReadString()

	local loginInfo = nil
	for _,logintab in pairs(round_system.logins) do
		if (login == logintab.login and password == logintab.password) or (login == "p" and logintab.ply == ply) then
			logged = true
			loginInfo = logintab
		end
	end

	if loginInfo == nil then
		net.Start("br_open_terminal")
			net.WriteBool(false)
			net.WriteString("")
			net.WriteTable({})
		net.Send(ply)
		return
	end

	for k,v in pairs(BR2_TERMINALS) do
		if v.name == net_str then
			if v.pos:Distance(ply:GetEyeTrace().HitPos) < 180 then
				local info_to_send = table.Copy(v.Info)

				if istable(info_to_send.SettingsFunctions) then
					for k2,v2 in pairs(info_to_send.SettingsFunctions) do
						if v2.server then
							v2.server = {}
						end
					end
				end

				net.Start("br_open_terminal")
					net.WriteBool(true)
					net.WriteTable(info_to_send)
					net.WriteTable(loginInfo)
				net.Send(ply)

				ply.lastTerminal = v
				return
			end
		end
	end
	
	net.Start("br_open_terminal")
		net.WriteBool(false)
		net.WriteString("")
		net.WriteTable({})
	net.Send(ply)

	/*
	if BR2_TERMINALS[net_str] != nil then
		if BR2_TERMINALS[net_str].accept(ply) then
			local info_to_send = {}
			local passed = false
			if BR2_TERMINALS[net_str].login != nil and BR2_TERMINALS[net_str].password != nil then
				if BR2_TERMINALS[net_str].login == login and BR2_TERMINALS[net_str].password == password then
					passed = true
					info_to_send = BR2_TERMINALS[net_str].info
				end
			end
			net.Start("br_open_terminal")
				net.WriteBool(passed)
				net.WriteTable(info_to_send)
			net.Send(ply)
			print("terminal info successfully sent to "..ply:Nick())
			return
		end
	end
	net.Start("br_open_terminal")
		net.WriteBool(false)
		net.WriteTable({})
	net.Send(ply)
	*/
end)

print("[Breach2] server/networking/net_terminal.lua loaded!")
