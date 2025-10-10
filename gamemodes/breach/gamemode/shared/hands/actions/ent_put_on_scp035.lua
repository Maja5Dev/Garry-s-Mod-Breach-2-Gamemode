
function put_on_035()
    local tr = util.TraceLine({
        start = ply:EyePos(),
        endpos = ply:EyePos() + (ply:EyeAngles():Forward() * 70),
        filter = ply
    })
    
    for k,v in pairs(ents.FindInSphere(tr.HitPos, 40)) do
        if v:GetClass() == "breach_035mask" then
            hook.Run("PlayerUse", ply, v)
            v:Use(ply, ply, USE_ON, 0)
        end
    end
end

registerHandsAction("put_on_scp35", {
    name = "Put on the mask",
    desc = "Put on the mask on your face",
	background_color = BR2_Hands_Actions_Colors.ent_important_actions,

    can_do = function(self)
        local tr = util.TraceLine({
            start = self.Owner:EyePos(),
            endpos = self.Owner:EyePos() + (self.Owner:EyeAngles():Forward() * 70),
            filter = self.Owner
        })

        for k,v in pairs(ents.FindInSphere(tr.HitPos, 40)) do
            if v:GetClass() == "breach_035mask" then
                return true
            end
        end

        return false
    end,

    sv_effect = function(self, ply)
        put_on_035()
    end,

    cl_after = function(self)
        WeaponFrame:Remove()
    end
})
