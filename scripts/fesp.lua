local FESPOn = CreateClientConVar("fesp_on",0,false)
local BoundingOn = CreateClientConVar("fesp_bounding",1)
local DrawDist = CreateClientConVar("fesp_drawdist",2000)

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

local function Bounding(p,c)
	if not BoundingOn:GetBool() then return end
	local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = ESPGetPos(p)
	local ESPPos = MinY
	surface.SetDrawColor(c)
	//Top Box
	surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
	surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
	surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
	surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

	//Bottom Box
	surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
	surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
	surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
	surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

	//Verticals
	surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
	surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
	surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
	surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
end

local function Printer(p)
	local node = p:GetPos()+Vector(0,0,20)
	cam.Start2D()
		local pos = node:ToScreen()
		draw.DrawText("Distance: "..math.Round(p:GetPos():Distance(LocalPlayer():GetPos())),"BudgetLabel",pos.x,pos.y,Color(200,100,100),TEXT_ALIGN_CENTER)
		if p.Base == "rprint_base" then
			draw.DrawText("$"..p:GetMoney(),"BudgetLabel",pos.x,pos.y-10,Color(200,200,100),TEXT_ALIGN_CENTER)
		end
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
	for _,ply in pairs(player.GetAll()) do
		if ply:GetFriendStatus() == "friend" then
			Friend(ply)
		else
			Player(ply)
		end
	end
end)

FPS()
