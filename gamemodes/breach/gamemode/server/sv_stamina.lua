
local RUN_SPEED_THRESHOLD = 150
local RUN_STAMINA_COST = -4
local RUN_STAMINA_RECOVERY = 4
local JUMP_STAMINA_COST = -5
local JUMP_STAMINA_RECOVERY = 1

local function HandleStamina()
    for _, v in ipairs(player.GetAll()) do
        if not (v:Alive() and not v:IsSpectator() and not v:IsDowned() and v.br_usesStamina) then
            continue
        end

        local vel = v:GetVelocity()
        local ct = CurTime()

        -- Jump stamina
        if v.nextJumpStaminaCheck < ct then
            local jumpChange = JUMP_STAMINA_RECOVERY

            if not v:OnGround() and vel.z > 0 then
                jumpChange = JUMP_STAMINA_COST
            end

            v:AddJumpStamina(jumpChange)
            v.nextJumpStaminaCheck = ct + 0.05
        end

        -- Run stamina
        if v.nextRunStaminaCheck < ct then
            local runChange = RUN_STAMINA_RECOVERY

            if vel:Length() >= v:GetRunSpeed() and (v:KeyDown(IN_FORWARD) or v:KeyDown(IN_BACK) or v:KeyDown(IN_MOVELEFT) or v:KeyDown(IN_MOVERIGHT)) then
                runChange = RUN_STAMINA_COST
                v.lastRunning = ct

            elseif (ct - (v.lastRunning or 0)) < 2 then
                runChange = RUN_STAMINA_COST + 1
            end

            v:AddRunStamina(runChange)
            v.nextRunStaminaCheck = ct + 0.05
        end

		-- DEBUG
		--v:PrintMessage(HUD_PRINTCENTER, "Run Stamina: "..math.Round(v.br_run_stamina).." | Velocity: "..math.Round(vel:Length()).." | Run speed: "..math.Round(v:GetRunSpeed()))
    end
end
hook.Add("Tick", "BR2_HandleStamina", HandleStamina)

local player_meta = FindMetaTable("Player")
function player_meta:AddJumpStamina(amount)
	self.br_jump_stamina = self.br_jump_stamina or 100
	self.br_jump_stamina = math.Clamp(self.br_jump_stamina + amount, 0, 100)
end

function player_meta:AddRunStamina(amount)
	self.br_run_stamina = self.br_run_stamina or 3000
	self.br_run_stamina = math.Clamp(self.br_run_stamina + amount, 0, 3000)
end

print("[Breach2] server/sv_stamina.lua loaded!")
