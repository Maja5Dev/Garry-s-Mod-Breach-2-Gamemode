AddCSLuaFile()

ENT.PrintName		= "SCP-173"
ENT.Author		    = "Maya"

ENT.Type			= "anim"
ENT.Base			= "base_gmodentity"

--ENT.Type			= "filter"
--ENT.Base			= "base_entity"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Owner = nil

function ENT:SetCurrentOwner(ply)
	self.Owner = ply
	self:SetNWEntity("173Owner", ply)
end

function ENT:OnOwnerDeath()
    if IsValid(self.Owner) then
        self.Owner.entity173 = nil
        self.Owner = nil
    end

    local pos, ang = self:GetPos(), self:GetAngles()

    local broken173 = ents.Create("prop_ragdoll")
    if IsValid(broken173) then
        broken173:SetModel("models/cultist/scp/173.mdl")
        broken173:SetPos(pos)
        broken173:SetAngles(ang + Angle(0,90,0))
        broken173:Spawn()
        broken173:Activate()
    end

    -- remove or hide the old entity
    self:Remove()
end

function ENT:GetCurrentOwner()
	return self.Owner
end

function ENT:OnTakeDamage(dmginfo)
	if self.Owner:IsPlayer() == true then
		self.Owner:TakeDamageInfo(dmginfo)
	end
end

function ENT:Initialize()

end

function ENT:OnRemove()
	hook.Remove("ShouldCollide", "DisableFreeRoam173Collision")
end

function ENT:IsPlayerLooking(ply)
    local dirToEnt = (self:WorldSpaceCenter() - ply:EyePos()):GetNormalized()
    local dot = ply:EyeAngles():Forward():Dot(dirToEnt)
    return dot > 0.8 -- ~36° cone
end

function ENT:IsPlayerVisible(ply, fromPos)
    local target = ply:EyePos()
    local filter = { self, self.Owner, ply:GetActiveWeapon() }

    local trace = util.TraceLine({
        start = fromPos,
        endpos = target,
        filter = filter
    })

    if trace.Entity == ply then return true end

    -- fallback hull check
    trace = util.TraceHull({
        start = fromPos,
        endpos = target,
        mins = Vector(-2, -2, -2),
        maxs = Vector(2, 2, 2),
        filter = filter
    })

    return trace.Entity == ply
end

-- Movement restriction
function ENT:CanMove(pos)
    if !IsValid(self.Owner) then return end

	local cpos = nil
	if pos == self:GetPos() then
		cpos = self:WorldSpaceCenter()
	else
		cpos = pos
	end

	if self.Owner:IsInLowLight() then
		return true
	end

	for k,v in pairs(ents.FindInSphere(pos, 1000)) do
		local timep = CurTime() - (v.nextBlink or 0)

		if not ((timep > 0.08) and (timep < 0.18)) then
			if v:IsPlayer()
			and v:Alive()
			and v:Team() != TEAM_SCP
			and not v:IsSpectator()
			and self:IsPlayerVisible(v, cpos)
			and self:IsPlayerLooking(v)
			and v.blinking_enabled then
				v.seen_173 = CurTime() + 10
				--self.Owner:PrintMessage(HUD_PRINTCENTER, v:Nick() .. " is looking " .. tostring(timep))

				return false -- player is looking, cannot move
			end
		end
	end

	return true -- safe to move
end

function ENT:TryToMoveTo(pos, ang)
	if self:CanMove(self:GetPos()) == true then
		self:SetPos(pos)
		
		if ang != nil then
			self:SetAngles(ang)
		end
	end
end

ENT.BlinkTime = 0.2

function ENT:Think()
    if SERVER then
        self:NextThink(CurTime() + 0.05)

        -- Check if entity can move
        if not self:CanMove(self:GetPos()) then
            self:SetVelocity(Vector(0,0,0)) -- freeze if being looked at
            return true
        end

        -- Blinking + sanity logic
        for k,v in pairs(player.GetAll()) do
            local seen173 = (v.seen_173 or 0) > CurTime()
            local dist = v:GetPos():Distance(self:GetPos())

            if v != self.Owner
            and v:Alive()
            and not v:IsSpectator()
            and v.blinking_enabled
            and ((dist < 600) or seen173)
            and v.usedEyeDrops < CurTime()
            and v.nextBlink < CurTime() then
                local next_blink = math.Rand(4.5, 6.5)

                net.Start("br_blinking")
                    net.WriteFloat(next_blink)
                    net.WriteFloat(v.seen_173 or 0)
                net.Send(v)

                v.nextBlink = CurTime() + next_blink

                if self:IsPlayerVisible(v, self:GetPos()) then
                    v.seen_173 = CurTime() + 10

                    if IsValid(self.Owner:GetActiveWeapon()) then
                        self.Owner:GetActiveWeapon():HorrorSound(v)
                    end

                    v:AddSanity(-1)
                end
            end
        end
    else
        self:NextThink(CurTime() + 0.2)
        if SendLightLevelInfo then
            SendLightLevelInfo()
        end
    end
end
