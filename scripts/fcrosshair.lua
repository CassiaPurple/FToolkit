local remove = {
	CHudCrosshair = true,
}

local dc_r = CreateClientConVar("fc_dc_r", 0  ):GetInt()
local dc_g = CreateClientConVar("fc_dc_g", 150):GetInt()
local dc_b = CreateClientConVar("fc_dc_b", 130):GetInt()
local hc_r = CreateClientConVar("fc_hc_r", 33 ):GetInt()
local hc_g = CreateClientConVar("fc_hc_g", 91 ):GetInt()
local hc_b = CreateClientConVar("fc_hc_b", 51 ):GetInt()

hook.Add("HUDShouldDraw","FCrosshair",function(name)
	if remove[name] then return false end
end )

hook.Add("HUDPaint","FCrosshair",function()
	local HoverColor,DefaultColor = Color(hc_r,hc_g,hc_b),Color(dc_r,dc_g,dc_b)
	local tr = LocalPlayer():GetEyeTrace()
	local c_col = IsValid(tr.Entity) and HoverColor or DefaultColor
	local trp = {
		x=ScrW()/2,
		y=ScrH()/2,
	}
	draw.RoundedBox(0,trp.x+8,trp.y,16,4,Color(0,0,0))
	draw.RoundedBox(0,trp.x+9,trp.y+1,14,2,c_col)
	draw.RoundedBox(0,trp.x-20,trp.y,16,4,Color(0,0,0))
	draw.RoundedBox(0,trp.x-19,trp.y+1,14,2,c_col)
	draw.RoundedBox(0,trp.x,trp.y+8,4,16,Color(0,0,0))
	draw.RoundedBox(0,trp.x+1,trp.y+9,2,14,c_col)
	draw.RoundedBox(0,trp.x,trp.y-20,4,16,Color(0,0,0))
	draw.RoundedBox(0,trp.x+1,trp.y-19,2,14,c_col)
end)