
local player_meta = FindMetaTable("Player")

function player_meta:CheckAttachmentSlot(attachment)
    if not self.attachmentModels then return false end

    for _, v in pairs(self.attachmentModels) do
        if v.attachment == attachment then
            return true
        end
    end

    return false
end

function player_meta:HasAttachmentModel(model)
    if not self.attachmentModels then return false end

    for _, v in pairs(self.attachmentModels) do
        if v.model == model then
            return true
        end
    end

    return false
end
