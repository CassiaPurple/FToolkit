local Zoom = false
local ZoomHowMuch = 1
local ZoomStep = 5
local Extrazoom = 0
local OldSensitivity = GetConVarString("sensitivity")

local _Cmd=FindMetaTable("Player").ConCommand
local Cmd=function(a) _Cmd(LocalPlayer and LocalPlayer():IsValid() and LocalPlayer() or Entity(1),a,true) end
local Now=RealTime
local _ZoomHowMuch=ZoomHowMuch
local _Extrazoom=Extrazoom
local start=Now()
local dezoom
hook.Add("CalcView", 'fzoom', function (ply, origin, angles, fov)
	--_Extrazoom=math.Approach(_Extrazoom,Extrazoom,FrameTime()*100000)
	_ZoomHowMuch=math.Approach(_ZoomHowMuch,ZoomHowMuch,FrameTime()*90)
	if Zoom then
		local frac=(Now()-start)/0.15
		--print(frac)
		local view = {
		origin = LerpVector(frac<= 0 and 0 or frac>=1 and 1 or frac,origin,origin - angles:Forward() * - Extrazoom),
		angles = angles,
		fov = Lerp(frac,fov,_ZoomHowMuch),
		}

		return view
	end

	if dezoom then
		local frac=(Now()-start)/0.2
		--print(frac)print"\n"
		frac=frac<= 0 and 0 or frac>=1 and 1 or frac
		if frac>=1 then dezoom=false end
		local view = {
			origin = LerpVector(frac,origin - angles:Forward() * - _Extrazoom,origin),
			angles = angles,
			fov = Lerp(frac,_ZoomHowMuch,fov),
		}
		return view
	end
end )

local function ChangeSensitivity()
	if Extrazoom > 99 and Extrazoom < 1000 then
		Cmd("sensitivity " .. tostring(1 -(((90 - ZoomHowMuch) + (Extrazoom/1000)) / 100)))
	elseif Extrazoom > 999 and Extrazoom < 10000 then
		Cmd("sensitivity " .. tostring( 1 -(((90 - ZoomHowMuch) + (Extrazoom/10000)) / 100)))
	elseif Extrazoom > 9999 then
		Cmd("sensitivity " .. "0.01")
	elseif Extrazoom < 99 then
		Cmd("sensitivity " .. tostring(1 -(((90 - ZoomHowMuch) + (Extrazoom/100)) / 100)))
	end
end
local enable="+zoom2"
function wtffunc(ply, cmd)
	if cmd == enable then
		if Extrazoom > 0 then
			ChangeSensitivity()
		else
			ChangeSensitivity()
		end
	else
		Cmd("sensitivity " .. OldSensitivity)
	end
	Zoom = not Zoom
	dezoom = not Zoom
	local m=IsValid(LocalPlayer():GetViewModel()) and LocalPlayer():GetViewModel()
	if m and Zoom then
		m:AddEffects(EF_NODRAW)
	elseif m then
		m:RemoveEffects(EF_NODRAW)
	end
	start=Now()
end
concommand.Add(enable, wtffunc)
concommand.Add("-zoom2", wtffunc)

hook.Add("PlayerBindPress", "fzoom", function ( ply, bnd, pressed )
	if Zoom and pressed then
		if string.find(bnd, "invprev") and pressed then
			if ZoomHowMuch > 1 then
				ZoomHowMuch = ZoomHowMuch - ZoomStep
				ChangeSensitivity()
			else
				Extrazoom = Extrazoom + ZoomStep*200
				ChangeSensitivity()
			end
			return true
		elseif string.find(bnd, "invnext") and pressed then
			if ZoomHowMuch < 90 and Extrazoom > 0  then
				Extrazoom = Extrazoom - ZoomStep*200
				ChangeSensitivity()
			elseif ZoomHowMuch < 90 and Extrazoom == 0 then
				ZoomHowMuch = ZoomHowMuch + ZoomStep
				ChangeSensitivity()
			end
			return true
		elseif string.find(bnd, "reload") and pressed then
			ZoomHowMuch = 11
			Extrazoom = 0
			ChangeSensitivity()
			return true
		end
	end
end)

