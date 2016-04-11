local FESPOn = CreateClientConVar("fesp_on",0,false)
local BoundingOn = CreateClientConVar("fesp_bounding",1)
local Bounding2D = CreateClientConVar("fesp_bounding_2d",0)
local DrawDist = CreateClientConVar("fesp_drawdist",2000)

local TheBones = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_Neck1",
	"ValveBiped.Bip01_Spine4",
	"ValveBiped.Bip01_Spine2",
	"ValveBiped.Bip01_Spine1",
	"ValveBiped.Bip01_Spine",
	"ValveBiped.Bip01_Pelvis",
	"ValveBiped.Bip01_R_UpperArm",
	"ValveBiped.Bip01_R_Forearm",
	"ValveBiped.Bip01_R_Hand",
	"ValveBiped.Bip01_L_UpperArm",
	"ValveBiped.Bip01_L_Forearm",
	"ValveBiped.Bip01_L_Hand",
	"ValveBiped.Bip01_R_Thigh",
	"ValveBiped.Bip01_R_Calf",
	"ValveBiped.Bip01_R_Foot",
	"ValveBiped.Bip01_R_Toe0",
	"ValveBiped.Bip01_L_Thigh",
	"ValveBiped.Bip01_L_Calf",
	"ValveBiped.Bip01_L_Foot",
	"ValveBiped.Bip01_L_Toe0",
}

local function ESPGetPos( Ent )
	if Ent:IsValid() then
		local Points = {
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z )
		}
		local MaxX, MaxY, MinX, MinY
		local V1, V2, V3, V4, V5, V6, V7, V8
		for k, v in pairs( Points ) do
			local ScreenPos = Ent:LocalToWorld( v ):ToScreen()
			if MaxX != nil then
				MaxX, MaxY, MinX, MinY = math.max( MaxX, ScreenPos.x ), math.max( MaxY, ScreenPos.y), math.min( MinX, ScreenPos.x ), math.min( MinY, ScreenPos.y)
			else
				MaxX, MaxY, MinX, MinY = ScreenPos.x, ScreenPos.y, ScreenPos.x, ScreenPos.y
			end

			if V1 == nil then
				V1 = ScreenPos
			elseif V2 == nil then
				V2 = ScreenPos
			elseif V3 == nil then
				V3 = ScreenPos
			elseif V4 == nil then
				V4 = ScreenPos
			elseif V5 == nil then
				V5 = ScreenPos
			elseif V6 == nil then
				V6 = ScreenPos
			elseif V7 == nil then
				V7 = ScreenPos
			elseif V8 == nil then
				V8 = ScreenPos
			end
		end
		return MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8
	end
end

local function ShowBones(p,c)
	if BoundingOn:GetInt() == 0 or BoundingOn:GetInt() == 1 then return end
	local Bones = {}
	local Success = true
	for k, v in pairs(TheBones) do
		if p:LookupBone(v) != nil && p:GetBonePosition(p:LookupBone(v)) != nil then
			table.insert( Bones, p:GetBonePosition(p:LookupBone(v)):ToScreen() )
		else
			Success = false --Just incase entities have some bones but not others (I have no idea if that happens, but I figgured better safe then sorry)
			return
		end
	end
	if Success then
		surface.SetDrawColor(c)
		--Spine
		surface.DrawLine( Bones[1].x, Bones[1].y, Bones[2].x, Bones[2].y )
		surface.DrawLine( Bones[2].x, Bones[2].y, Bones[3].x, Bones[3].y )
		surface.DrawLine( Bones[3].x, Bones[3].y, Bones[4].x, Bones[4].y )
		surface.DrawLine( Bones[4].x, Bones[4].y, Bones[5].x, Bones[5].y )
		surface.DrawLine( Bones[5].x, Bones[5].y, Bones[6].x, Bones[6].y )
		surface.DrawLine( Bones[6].x, Bones[6].y, Bones[7].x, Bones[7].y )

		--Legs
		surface.DrawLine( Bones[7].x, Bones[7].y, Bones[14].x, Bones[14].y )
		surface.DrawLine( Bones[14].x, Bones[14].y, Bones[15].x, Bones[15].y )
		surface.DrawLine( Bones[15].x, Bones[15].y, Bones[16].x, Bones[16].y )
		surface.DrawLine( Bones[16].x, Bones[16].y, Bones[17].x, Bones[17].y )

		surface.DrawLine( Bones[7].x, Bones[7].y, Bones[18].x, Bones[18].y )
		surface.DrawLine( Bones[18].x, Bones[18].y, Bones[19].x, Bones[19].y )
		surface.DrawLine( Bones[19].x, Bones[19].y, Bones[20].x, Bones[20].y )
		surface.DrawLine( Bones[20].x, Bones[20].y, Bones[21].x, Bones[21].y )

		--Arms
		surface.DrawLine( Bones[3].x, Bones[3].y, Bones[8].x, Bones[8].y )
		surface.DrawLine( Bones[8].x, Bones[8].y, Bones[9].x, Bones[9].y )
		surface.DrawLine( Bones[9].x, Bones[9].y, Bones[10].x, Bones[10].y )

		surface.DrawLine( Bones[3].x, Bones[3].y, Bones[11].x, Bones[11].y )
		surface.DrawLine( Bones[11].x, Bones[11].y, Bones[12].x, Bones[12].y )
		surface.DrawLine( Bones[12].x, Bones[12].y, Bones[13].x, Bones[13].y )

	end
end

local function Bounding(p,c)
	if BoundingOn:GetInt() == 0 or BoundingOn:GetInt() == 2 then return end
	local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = ESPGetPos(p)
	local ESPPos = MinY
	surface.SetDrawColor(c)
	if Bounding2D:GetBool() then
		surface.DrawLine( MaxX, MaxY, MinX, MaxY )
		surface.DrawLine( MaxX, MaxY, MaxX, MinY )
		surface.DrawLine( MinX, MinY, MaxX, MinY )
		surface.DrawLine( MinX, MinY, MinX, MaxY )
	else
		--Top Box
		surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
		surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
		surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
		surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

		--Bottom Box
		surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
		surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
		surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
		surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

		--Verticals
		surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
		surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
		surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
		surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
	end
end

local function Printer(p)
	local node = p:GetPos()+Vector(0,0,20)
	cam.Start2D()
		local pos = node:ToScreen()
		draw.DrawText("Distance: "..math.Round(p:GetPos():Distance(LocalPlayer():GetPos())),"BudgetLabel",pos.x,pos.y,Color(100,200,100),TEXT_ALIGN_CENTER)
		if p.Base == "rprint_base" then
			draw.DrawText("$"..p:GetMoney(),"BudgetLabel",pos.x,pos.y-10,Color(200,200,100),TEXT_ALIGN_CENTER)
		end
	cam.End2D()

	Bounding(p,Color(200,200,100))
end

local function Coin(p)
	if not p.GetValue then return end
	local node = p:GetPos()+Vector(0,0,10)
	cam.Start2D()
		local pos = node:ToScreen()
		draw.DrawText("Distance: "..math.Round(p:GetPos():Distance(LocalPlayer():GetPos())),"BudgetLabel",pos.x,pos.y,Color(100,200,100),TEXT_ALIGN_CENTER)
		draw.DrawText("$"..p:GetValue(),"BudgetLabel",pos.x,pos.y-10,Color(200,200,100),TEXT_ALIGN_CENTER)
	cam.End2D()

	Bounding(p,Color(200,200,100))
end

local wire = Material("models/wireframe")
local function Friend(p)
	local node = p:EyePos()+Vector(0,0,20)
	local rainbow = HSVToColor(RealTime()*50%360,1,0.75)
	cam.Start2D()
		local pos = node:ToScreen()
		draw.DrawText((p:IsSuperAdmin() and "[SA][F] " or p:IsAdmin() and "[A][F] " or "[F] ")..p:Name(),"BudgetLabel",pos.x,pos.y-20,rainbow,TEXT_ALIGN_CENTER)
		draw.DrawText(team.GetName(p:Team()),"BudgetLabel",pos.x,pos.y-10,team.GetColor(p:Team()),TEXT_ALIGN_CENTER)
		draw.DrawText("Distance: "..math.Round(p:GetPos():Distance(LocalPlayer():GetPos())),"BudgetLabel",pos.x,pos.y,Color(100,200,100),TEXT_ALIGN_CENTER)
		draw.DrawText("Health: "..p:Health(),"BudgetLabel",pos.x,pos.y+10,Color(200,100,100),TEXT_ALIGN_CENTER)
		draw.DrawText(IsValid(p:GetActiveWeapon()) and p:GetActiveWeapon():GetClass() or "dead","BudgetLabel",pos.x,pos.y+20,Color(100,200,200),TEXT_ALIGN_CENTER)
		draw.DrawText("$"..(p.getDarkRPVar and p:getDarkRPVar("money") or p.GetCoins and p:GetCoins() or p.GetMoney and p:GetMoney() or ""),"BudgetLabel",pos.x,pos.y+30,Color(200,200,100),TEXT_ALIGN_CENTER)
	cam.End2D()

	Bounding(p,rainbow)
	ShowBones(p,rainbow)
end

local function Player(p)
	if p:GetPos():Distance(LocalPlayer():GetPos()) > DrawDist:GetInt() then return end
	if p == LocalPlayer() then return end
	local node = p:EyePos()+Vector(0,0,30)
	cam.Start2D()
		local pos = node:ToScreen()
		draw.DrawText((p:IsSuperAdmin() and "[SA] " or p:IsAdmin() and "[A] " or "")..p:Name(),"BudgetLabel",pos.x,pos.y-20,Color(255,255,255),TEXT_ALIGN_CENTER)
		draw.DrawText(team.GetName(p:Team()),"BudgetLabel",pos.x,pos.y-10,team.GetColor(p:Team()),TEXT_ALIGN_CENTER)
		draw.DrawText("Distance: "..math.Round(p:GetPos():Distance(LocalPlayer():GetPos())),"BudgetLabel",pos.x,pos.y,Color(100,200,100),TEXT_ALIGN_CENTER)
		draw.DrawText("Health: "..p:Health(),"BudgetLabel",pos.x,pos.y+10,Color(200,100,100),TEXT_ALIGN_CENTER)
		draw.DrawText(IsValid(p:GetActiveWeapon()) and p:GetActiveWeapon():GetClass() or "dead","BudgetLabel",pos.x,pos.y+20,Color(100,200,200),TEXT_ALIGN_CENTER)
		draw.DrawText("$"..(p.getDarkRPVar and p:getDarkRPVar("money") or p.GetCoins and p:GetCoins() or p.GetMoney and p:GetMoney() or ""),"BudgetLabel",pos.x,pos.y+30,Color(200,200,100),TEXT_ALIGN_CENTER)
	cam.End2D()

	Bounding(p,Color(200,100,100))
	ShowBones(p,Color(200,100,100))
end

local surface=surface
local FrameTime=FrameTime
local min,max=1/33,1/33
local sc=400

local function FPS()
	if g_FrameTime then
		g_FrameTime:Remove()
	end
	g_FrameTime = vgui.Create'EditablePanel'
	g_FrameTime:SetRenderInScreenshots(false)
	g_FrameTime:SetWorldClicker(true)
	g_FrameTime:SetZPos(-32000)
	g_FrameTime:SetVisible(true)
	g_FrameTime:SetPos(0,30)

	function g_FrameTime.PerformLayout(self,w,h)
		g_FrameTime:SetSize(400,32)
	end
	g_FrameTime:PerformLayout(0,0)
	g_FrameTime:InvalidateLayout()
	function g_FrameTime.Paint(self,w,h)
		local rainbow = HSVToColor(RealTime()*50%360,1,0.75)
		local q=0.0001
		local ft=FrameTime()

		local qq=1-ft*0.5
		qq=qq<0.001 and 0.001 or qq


		min=math.min(ft,min)
		min=min*qq+ft*(1-qq)

		max=math.max(ft,max)
		max=max*qq+ft*(1-qq)
		surface.SetFont"BudgetLabel"
		surface.SetTextColor(rainbow)

		surface.SetDrawColor(rainbow)
		surface.DrawRect(10,10,ft*sc,5)

		surface.SetDrawColor(222,222,255,255)
		surface.DrawRect(10+ft*sc,8,1,8)

		if max>(1/23) then -- below acceptable fps
			surface.SetDrawColor(255,150,150,255)
			surface.DrawRect(10+(1/23)*sc-1,6,2,12)

		end
		if max>0.5 then -- 2 fps, lol
		surface.SetDrawColor(200,150,150,255)
		surface.DrawRect(10+0.5*sc-3,6,6,12)
		end
		surface.SetDrawColor(200,100,100,255)
		surface.DrawRect(10+ft*sc,10,(max-ft)*sc,5)
		surface.SetTextPos(10+(max)*sc,5)
		surface.DrawText(math.Round(1/max)..' fps')

		surface.SetDrawColor(100,200,100,255)
		surface.DrawRect(10,10,min*sc,5)
		local txt=math.Round(1/min)..' fps'
		local w,h=surface.GetTextSize(txt)
		surface.SetTextPos(math.floor(10+(min)*sc-w*0.2),10+8)
		surface.DrawText(txt)

		--eek it leaked out
		surface.SetTextColor(255,255,255,255)
		surface.SetDrawColor(255,255,255,255)
	end
end

hook.Add("HUDPaint","FTK.ESP",function()
	local rainbow = HSVToColor(RealTime()*50%360,1,0.75)
	draw.DrawText("Players: "..table.Count(player.GetAll()),"BudgetLabel",4,4,rainbow)
	draw.DrawText("Printers: "..table.Count(ents.FindByClass("*print*")),"BudgetLabel",4,14,rainbow)
	if not FESPOn:GetBool() then return end
	for _,ent in pairs(ents.FindByClass("*print*")) do
		Printer(ent)
	end
	for _,ent in pairs(ents.FindByClass("coin")) do
		Coin(ent)
	end
	for _,ply in pairs(player.GetAll()) do
		if ply:GetFriendStatus() == "friend" then
			Friend(ply)
		else
			Player(ply)
		end
	end
end)

FPS()

local function FESPPrint(txt)
	MsgC(Color(0,150,130),"[FESP] ",Color(255,255,255),txt.."\n")
	if epoe then
		epoe.MsgC(Color(0,150,130),"[FESP] ")
		epoe.MsgC(Color(255,255,255),txt.."\n")
	end
end

FESPPrint("Concommands:")
FESPPrint("fesp_on          [0/1]     - Toggle FESP")
FESPPrint("fesp_drawdist    [number]  - How far people can draw (friends, coins and printers excluded)")
FESPPrint("fesp_bounding    [0/1/2/3] - 0: off,               1: bounding boxes only, 2: bones only, 3: both")
FESPPrint("fesp_bounding_2d [0/1]     - 0: 3D bounding boxes, 1: 2D bounding boxes")