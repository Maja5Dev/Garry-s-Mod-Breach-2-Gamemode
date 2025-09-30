
net.Receive("br_attach_models", function(len)
	local ply = net.ReadEntity()
    local models = net.ReadTable()

    if not IsValid(ply) or not ply:IsPlayer() then return end

    ply.attachmentModels = models or {}
end)

hook.Add("PostPlayerDraw", "BR2_DrawAttachmentModels", function(ply)
    if not ply.attachmentModels then return end

    for k,v in pairs(ply.attachmentModels) do
        -- Validate entity
        if not IsValid(v.ent) then
            v.ent = ClientsideModel(v.model, RENDERGROUP_OPAQUE)
            if not IsValid(v.ent) then continue end
            v.ent:SetNoDraw(true) -- avoid auto-draw
        end

        -- Find attachment point
        local offsetvec, offsetang
        if v.attachment then
            -- Try using attachment (like "eyes")
            local attachment = ply:GetAttachment(ply:LookupAttachment(v.attachment))
            if attachment then
                offsetvec, offsetang = attachment.Pos, attachment.Ang
            end
        end

        if not offsetvec then
            -- Fallback to bone
            local boneid = ply:LookupBone(v.bone or "ValveBiped.Bip01_Head1")
            if boneid then
                local matrix = ply:GetBoneMatrix(boneid)
                if matrix then
                    offsetvec, offsetang = LocalToWorld(
                        v.pos or Vector(),
                        v.ang or Angle(),
                        matrix:GetTranslation(),
                        matrix:GetAngles()
                    )
                end
            end
        else
            -- Apply custom offsets when using attachment
            local up, right, forward = offsetang:Up(), offsetang:Right(), offsetang:Forward()
            offsetvec = offsetvec
                + right   * (v.offset and v.offset.x or 0)
                + forward * (v.offset and v.offset.y or 0)
                + up      * (v.offset and v.offset.z or 0)

            if v.angOffset then
                offsetang:RotateAroundAxis(right,   v.angOffset.p or 0)
                offsetang:RotateAroundAxis(up,      v.angOffset.y or 0)
                offsetang:RotateAroundAxis(forward, v.angOffset.r or 0)
            end
        end

        -- Apply transform & draw
        if offsetvec and offsetang then
            v.ent:SetPos(offsetvec)
            v.ent:SetAngles(offsetang)
            v.ent:SetupBones()
            v.ent:DrawModel()
        end
    end
end)

-- Cleanup function for a player's attachment models
local function CleanupAttachments(ply)
    if not ply.attachmentModels then return end

    for _, v in pairs(ply.attachmentModels) do
        if IsValid(v.ent) then
            v.ent:Remove()
        end
    end

    ply.attachmentModels = nil
end

hook.Add("EntityRemoved", "CleanupAttachmentModels", function(ent)
    if ent:IsPlayer() then
        CleanupAttachments(ent)
    end
end)
