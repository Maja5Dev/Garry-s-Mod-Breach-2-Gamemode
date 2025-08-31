
local function FixFlashlight(ply)
	local flashlight3d = ply:GetNWEntity("flashlight3d")
	if flashlight3d:IsValid() then
		flashlight3d:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 15)
		flashlight3d:SetAngles(ply:EyeAngles())
	end
end

local angpow_inc = 0.05
local angpow_dec = 0.05
local angadd = 0
local angmax = 1

local function BreachSway(view, ply)
	local vel = ply:GetVelocity():Length()
	local vel_f = math.Clamp(vel / 100, 0, 2)
	angpow_inc = 0.05 * (vel_f * 0.6)
	angmax = vel_f
	--chat.AddText(tostring(angpow_inc))
	local mvl = ply:KeyDown(IN_MOVELEFT)
	local mvr = ply:KeyDown(IN_MOVERIGHT)

	if !(mvl and mvr) and (mvl or mvr) and vel > 30 then
		if mvl then
			angadd = angadd - angpow_inc
		elseif mvr then
			angadd = angadd + angpow_inc
		end
		if angadd > angmax then
			angadd = angmax
		elseif angadd < -angmax then
			angadd = -angmax
		end
	else
		if angadd < 0 then
			angadd = angadd + angpow_dec
		elseif angadd > 0 then
			angadd = angadd - angpow_dec
		end
	end

	if math.abs(angadd) > 0.1 then
		view.angles = angles + Angle(0, 0, angadd)
	end
	
	return view
end

local wobbleStrengthWalk = 0.3   -- intensity of camera wobble when walking
local wobbleStrengthRun  = 0.6   -- intensity when running
local wobbleSpeed        = 6     -- how fast the wobble cycles

local function Wobble(view, ply)
    if !IsValid(ply) or !ply:Alive() or ply:IsSpectator() then return end

    -- Check movement state
    local vel = ply:GetVelocity():Length2D()
    if vel < 5 then return end -- no wobble if standing still

    local isRunning = ply:KeyDown(IN_SPEED)
    local strength  = isRunning and wobbleStrengthRun or wobbleStrengthWalk

    -- Use CurTime for smooth oscillation
    local time = CurTime() * wobbleSpeed
    local offsetPitch = math.sin(time) * strength
    local offsetYaw   = math.cos(time * 0.5) * (strength * 0.5)

    view.angles = view.angles + Angle(offsetPitch, offsetYaw, 0)

    return view
end

hook.Add("CalcView", "BR2_CalcView", function(ply, position, angles, fov)
	FixFlashlight(ply)

	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) and wep.CalcViewInfo then
		return wep:CalcViewInfo(ply, position, angles, fov)
	end

	local view = {origin = position, angles = angles, fov = fov, drawviewer = false}
	if LocalPlayer():IsInPD() then
		view.angles = Angle(angles.pitch, angles.yaw, -15)
	end

	--view = BreachSway(view, ply)

	--view = Wobble(view, ply) or view
	
	return view
end)

print("[Breach2] client/cl_calcview.lua loaded!")
