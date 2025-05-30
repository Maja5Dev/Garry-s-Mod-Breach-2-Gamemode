
local function HandleStamina()
	for k,v in pairs(player.GetAll()) do
		if v:Alive() and v:IsSpectator() == false and v.br_usesStamina then
			local vel = v:GetVelocity()
			
			if v.nextJumpStaminaCheck < CurTime() then
				local jump_stamina_change = 1
				if !v:OnGround() and vel.z > 0 then
					jump_stamina_change = jump_stamina_change - 6
				end
				v:AddJumpStamina(jump_stamina_change)
				v.nextJumpStaminaCheck = CurTime() + 0.02
			end

			if v.nextRunStaminaCheck < CurTime() then
				local run_stamina_change = 3
				if vel:Length() > 150 and (v:KeyDown(IN_FORWARD) or v:KeyDown(IN_BACK) or v:KeyDown(IN_MOVELEFT) or v:KeyDown(IN_MOVERIGHT)) then
					run_stamina_change = run_stamina_change - 5
					v.lastRunning = CurTime()

				elseif (CurTime() - v.lastRunning) < 2 then
					run_stamina_change = run_stamina_change - 3
				end
				
				v:AddRunStamina(run_stamina_change)
				v.nextRunStaminaCheck = CurTime() + 0.01
				
				--v:PrintMessage(HUD_PRINTCENTER, tostring(v.br_run_stamina) .. " / " .. tostring(run_stamina_change))
			end
		end
	end
end
hook.Add("Tick", "BR2_HandleStamina", HandleStamina)

local player_meta = FindMetaTable("Player")
function player_meta:AddJumpStamina(amount)
	self.br_jump_stamina = self.br_jump_stamina or 100
	self.br_jump_stamina = math.Clamp(self.br_jump_stamina + amount, 0, 100)
end

function player_meta:AddRunStamina(amount)
	self.br_run_stamina = self.br_run_stamina or 2000
	self.br_run_stamina = math.Clamp(self.br_run_stamina + amount, 0, 2000)
end

print("[Breach2] server/sv_stamina.lua loaded!")
