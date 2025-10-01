
local player_meta = FindMetaTable("Player")
local entity_meta = FindMetaTable("Entity")

function entity_meta:AddAttachmentModel(tbl)
    if not self.attachmentModels then
        self.attachmentModels = {}
    end

    if self:IsPlayer() and tbl.attachment and self:CheckAttachmentSlot(tbl.attachment) then
        self:PrintMessage(HUD_PRINTTALK, "You are already wearing something in that slot!")
        return false
    end

    table.insert(self.attachmentModels, {
        model = tbl.model,
        bone = tbl.bone,
        pos = tbl.pos,
        ang = tbl.ang,
        attachment = tbl.attachment,
        offset = tbl.offset,
        angOffset = tbl.angOffset,
        ent = nil, -- will be filled clientside
    })

    self:BroadcastAttachmentModels()
end

function player_meta:RemoveAttachmentModels()
    if not self.attachmentModels then return end

    self.attachmentModels = nil
    self:BroadcastAttachmentModels()
end

function RemoveAllAttachmentModels()
    for k,v in pairs(player.GetAll()) do
        v.attachmentModels = nil
    end

    net.Start("br_remove_all_attach_models")
    net.Broadcast()
end

function player_meta:RemoveAttachmentModel(model)
    if not self.attachmentModels then return end

    for k,v in pairs(self.attachmentModels) do
        if v.model == model then
            table.remove(self.attachmentModels, k)
            break
        end
    end

    if #self.attachmentModels == 0 then
        self.attachmentModels = nil
    end

    self:BroadcastAttachmentModels()
end

function player_meta:BroadcastAttachmentModels()
	net.Start("br_attach_models")
        net.WriteEntity(self)
        net.WriteTable(self.attachmentModels or {})
    net.Broadcast()
end

hook.Add("PlayerDisconnected", "CleanupAttachmentModels", function(ply)
    ply:RemoveAttachmentModels()
end)
