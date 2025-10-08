
function BR_DEFAULT_MAP_Organize_Cameras()
	if istable(MAPCONFIG.CAMERAS) then
		for k,v in pairs(MAPCONFIG.CAMERAS) do
			for k2,v2 in pairs(v.cameras) do
				local camera = ents.Create("br2_camera")
				
				if IsValid(camera) then
					camera:SetModel("models/props/cs_assault/camera.mdl")
					camera:SetPos(v2.pos)
					camera:SetAngles(v2.ang)
					camera:Spawn()
					camera.CameraInfo = table.Copy(v2)
					camera.CameraName = v2.name
					camera:SetNWString("CameraName", v2.name)
				end
			end
		end
	else
		ErrorNoHaltWithStack("[Breach2] No cameras found...")
		return
	end
end
