surface.CreateFont( "Aurora6", {
	font 		= "white rabbit",
	size 		= 12,
	weight 		= 400,
	antialias 	= true,
	additive 	= false,
})
    local PropAng
    local PropPos
    local PropMod
    local PropClass
    local PropID
    local PropMat
    local MePos
    local MeAng

  function FormatNumbers(num)
  if !num then return "0" end
  local int, rem = math.modf(tonumber(num))
  local val, ret, n = tostring(int), "", 0
  while true do
    ret = ret .. val[#val - n]
    n = n + 1
    if (n % 3) == 0 and n < #val then
      ret = ret..","
    end
    if n > #val then break end
  end
  if rem ~= 0 then
    return string.reverse(ret)..string.sub(tostring(rem), 2)
  else
    return string.reverse(ret)
  end
end

function PropInfo()
  local Number = 330
  local Number1 = ScrW()-16
  local AlignX = 2
  local AlignY = 2
 local tr = LocalPlayer():GetEyeTrace()

 draw.SimpleText(LocalPlayer():Ping(),"Aurora6",Number1,Number,Color(255,255,255,255),AlignX,AlignY)
 draw.SimpleText("Player Angle(Y,P,R): "..tostring(LocalPlayer( ):EyeAngles( )) or "none" .."","Aurora6",Number1,Number+110,Color(000,000,255,255),AlignX,AlignY)
 draw.SimpleText("Player Pos(X,Y,Z): "..tostring(LocalPlayer():GetPos()) or "none" .."","Aurora6",Number1,Number+125,Color(000,000,255,255),AlignX,AlignY)

  if (tr.Entity:IsValid()) then
  PropAng = tostring(tr.Entity:GetAngles()) or "none"
  PropPos = tostring(tr.Entity:GetPos()) or "none"
  PropMod = tostring(tr.Entity:GetModel()) or "none"
  PropClass = tostring(tr.Entity:GetClass()) or "none"
  PropID = tostring(tr.Entity:EntIndex()) or "none"
  PropMat = tostring(tr.Entity:GetMaterial()) or "none"


  draw.SimpleText("Posistion(X,Y,Z): ".. PropPos .."","Aurora6",Number1,Number+15,Color(000,255,000,255),AlignX,AlignY)
  draw.SimpleText("Angle(Y,P,R): ".. PropAng .."","Aurora6",Number1,Number+30,Color(000,255,000,255),AlignX,AlignY)
  draw.SimpleText("Model: ".. PropMod .."","Aurora6",Number1,Number+45,Color(000,255,000,255),AlignX,AlignY)
  draw.SimpleText("Class: ".. PropClass .."","Aurora6",Number1,Number+60,Color(000,255,000,255),AlignX,AlignY)
  draw.SimpleText("EntID: ".. PropID .."","Aurora6",Number1,Number+75,Color(000,255,000,255),AlignX,AlignY)
  draw.SimpleText("Material: ".. PropMat .."","Aurora6",Number1,Number+90,Color(000,255,000,255),AlignX,AlignY)
end


 	if (gmod.GetGamemode().Name == "Aurora" ) then
	
    local Credits = FormatNumbers(AU:GetPlayerData("credits"))
    local Score = FormatNumbers(AU:GetPlayerData("score"))
    draw.SimpleText(string.format("Credits: "..Credits),"Aurora6",Number1,Number-50,Color(255,000,000,255),AlignX,AlignY)
    draw.SimpleText(string.format("Score: "..Score),"Aurora6",Number1,Number-35,Color(255,000,000,255),AlignX,AlignY)
 end
end
function printInfo()
  local tr = LocalPlayer():GetEyeTrace()
  if (tr.Entity:IsValid()) then
    PropAng = tostring(tr.Entity:GetAngles()) or "none"
    PropPos = tostring(tr.Entity:GetPos()) or "none"
    PropMod = tostring(tr.Entity:GetModel()) or "none"
    PropClass = tostring(tr.Entity:GetClass()) or "none"
    PropID = tostring(tr.Entity:EntIndex()) or "none"
    PropMat = tostring(tr.Entity:GetMaterial()) or "none"
  end
  MeAng = tostring(LocalPlayer( ):EyeAngles( )) or "none"
  MePos = tostring(LocalPlayer():GetPos()) or "none"
  local DermaPanel = vgui.Create( "DFrame" )
  DermaPanel:SetPos( 50,50 )
  DermaPanel:SetSize( 300, 450 )
  DermaPanel:SetTitle( "Entity Info" )
  DermaPanel:SetVisible( true )
  DermaPanel:SetDraggable( false )
  DermaPanel:ShowCloseButton( true )
  DermaPanel:MakePopup()
  if (tr.Entity:IsValid()) then
    local AngLabel = vgui.Create("DLabel",DermaPanel)
    AngLabel:SetPos(5,27)
    AngLabel:SetText("Prop's Angle")
    AngLabel:SizeToContents()
    local AngBox = vgui.Create( "TextEntry", DermaPanel )
    AngBox:SetPos(5,45)
    AngBox:SetSize(200,25)
    AngBox:SetText(PropAng)
    local AngButton = vgui.Create( "DButton", DermaPanel )
    AngButton:SetPos(210,45)
    AngButton:SetSize(75,25)
    AngButton:SetText("Copy")
    AngButton.DoClick = function( button )
      SetClipboardText( PropAng )
      DermaPanel:Close()
    end
    local PosLabel = vgui.Create("DLabel",DermaPanel)
    PosLabel:SetPos(5,75)
    PosLabel:SetText("Prop's Position")
    PosLabel:SizeToContents()
    local PosBox = vgui.Create( "TextEntry", DermaPanel )
    PosBox:SetPos(5,93)
    PosBox:SetSize(200,25)
    PosBox:SetText(PropPos)
    local PosButton = vgui.Create( "DButton", DermaPanel )
    PosButton:SetPos(210,93)
    PosButton:SetSize(75,25)
    PosButton:SetText("Copy")
    PosButton.DoClick = function( button )
      SetClipboardText( PropPos )
      DermaPanel:Close()
    end
    local ModLabel = vgui.Create("DLabel",DermaPanel)
    ModLabel:SetPos(5,123)
    ModLabel:SetText("Prop's Model")
    ModLabel:SizeToContents()
    local ModBox = vgui.Create( "TextEntry", DermaPanel )
    ModBox:SetPos(5,141)
    ModBox:SetSize(200,25)
    ModBox:SetText(PropMod)
    local ModButton = vgui.Create( "DButton", DermaPanel )
    ModButton:SetPos(210,141)
    ModButton:SetSize(75,25)
    ModButton:SetText("Copy")
    ModButton.DoClick = function( button )
      SetClipboardText( PropMod )
      DermaPanel:Close()
    end
    local ClassLabel = vgui.Create("DLabel",DermaPanel)
    ClassLabel:SetPos(5,171)
    ClassLabel:SetText("Prop's Class")
    ClassLabel:SizeToContents()
    local ClassBox = vgui.Create( "TextEntry", DermaPanel )
    ClassBox:SetPos(5,189)
    ClassBox:SetSize(200,25)
    ClassBox:SetText(PropClass)
    local ClassButton = vgui.Create( "DButton", DermaPanel )
    ClassButton:SetPos(210,189)
    ClassButton:SetSize(75,25)
    ClassButton:SetText("Copy")
    ClassButton.DoClick = function( button )
      SetClipboardText( PropClass )
      DermaPanel:Close()
    end
    local IDLabel = vgui.Create("DLabel",DermaPanel)
    IDLabel:SetPos(5,219)
    IDLabel:SetText("Prop's Entity ID")
    IDLabel:SizeToContents()
    local IDBox = vgui.Create( "TextEntry", DermaPanel )
    IDBox:SetPos(5,237)
    IDBox:SetSize(200,25)
    IDBox:SetText(PropID)
    local IDButton = vgui.Create( "DButton", DermaPanel )
    IDButton:SetPos(210,237)
    IDButton:SetSize(75,25)
    IDButton:SetText("Copy")
    IDButton.DoClick = function( button )
      SetClipboardText( PropID )
      DermaPanel:Close()
    end
    local MatLabel = vgui.Create("DLabel",DermaPanel)
    MatLabel:SetPos(5,267)
    MatLabel:SetText("Prop's Material")
    MatLabel:SizeToContents()
    local MatBox = vgui.Create( "TextEntry", DermaPanel )
    MatBox:SetPos(5,285)
    MatBox:SetSize(200,25)
    MatBox:SetText(PropMat)
    local MatButton = vgui.Create( "DButton", DermaPanel )
    MatButton:SetPos(210,285)
    MatButton:SetSize(75,25)
    MatButton:SetText("Copy")
    MatButton.DoClick = function( button )
      SetClipboardText( PropMat )
      DermaPanel:Close()
    end
    local PPosLabel = vgui.Create("DLabel",DermaPanel)
    PPosLabel:SetPos(5,335)
    PPosLabel:SetText("Player's Position")
    PPosLabel:SizeToContents()
    local PPosBox = vgui.Create( "TextEntry", DermaPanel )
    PPosBox:SetPos(5,353)
    PPosBox:SetSize(200,25)
    PPosBox:SetText(MePos)
    local PPosButton = vgui.Create( "DButton", DermaPanel )
    PPosButton:SetPos(210,353)
    PPosButton:SetSize(75,25)
    PPosButton:SetText("Copy")
    PPosButton.DoClick = function( button )
      SetClipboardText( MePos )
      DermaPanel:Close()
    end
    local PAngLabel = vgui.Create("DLabel",DermaPanel)
    PAngLabel:SetPos(5,383)
    PAngLabel:SetText("Player's Angle")
    PAngLabel:SizeToContents()
    local PAngBox = vgui.Create( "TextEntry", DermaPanel )
    PAngBox:SetPos(5,401)
    PAngBox:SetSize(200,25)
    PAngBox:SetText(MeAng)
    local PAngButton = vgui.Create( "DButton", DermaPanel )
    PAngButton:SetPos(210,401)
    PAngButton:SetSize(75,25)
    PAngButton:SetText("Copy")
    PAngButton.DoClick = function( button )
      SetClipboardText( MeAng )
      DermaPanel:Close()
    end
  else
    local PAngLabel = vgui.Create("DLabel",DermaPanel)
    PAngLabel:SetPos(5,27)
    PAngLabel:SetText("Player's Angle")
    PAngLabel:SizeToContents()
    local PAngBox = vgui.Create( "TextEntry", DermaPanel )
    PAngBox:SetPos(5,45)
    PAngBox:SetSize(200,25)
    PAngBox:SetText(MeAng)
    local PAngButton = vgui.Create( "DButton", DermaPanel )
    PAngButton:SetPos(210,45)
    PAngButton:SetSize(75,25)
    PAngButton:SetText("Copy")
    PAngButton.DoClick = function( button )
      SetClipboardText( MeAng )
      DermaPanel:Close()
    end
    local PPosLabel = vgui.Create("DLabel",DermaPanel)
    PPosLabel:SetPos(5,75)
    PPosLabel:SetText("Player's Position")
    PPosLabel:SizeToContents()

    local PPosBox = vgui.Create( "TextEntry", DermaPanel )
    PPosBox:SetPos(5,93)
    PPosBox:SetSize(200,25)
    PPosBox:SetText(MePos)
    local PPosButton = vgui.Create( "DButton", DermaPanel )
    PPosButton:SetPos(210,93)
    PPosButton:SetSize(75,25)
    PPosButton:SetText("Copy")
    PPosButton.DoClick = function( button )
      SetClipboardText( MePos )
      DermaPanel:Close()
    end
  end
end

hook.Add("HUDPaint", "PropInfo", PropInfo)
concommand.Add("print_propinfo", printInfo)
