--[[
FToolkit: An automated script loader
by Flex
--]]

require("filesystem")

local function FSWrite(name,str)
	local f = filesystem.Open(name,"wb","DATA")
	if not f then return end

	f:Write(str)
	f:Close()
end

file.CreateDir("ftoolkit")

FTK = FTK or {
	FileList = {
		"autojump.lua",
		"ctp.lua",
		"fcrosshair.lua",
		"fesp.lua",
		"fzoom.lua",
		"picker2.lua",
		"propinfo.lua",
		"smartsnap.lua",
		"smeg.lua",
	}
}

ErrorNoHalt[[.
Loading FTK...
 ______   ______   __  __
/\  ___\ /\__  _\ /\ \/ /
\ \  __\ \/_/\ \/ \ \  _"-.
 \ \_\      \ \_\  \ \_\ \_\
  \/_/       \/_/   \/_/\/_/
Written by Flex (STEAM_0:0:58178275)
https://github.com/LUModder/FToolkit
]]

if epoe then
local message = [[
FFFFFFFFFFFFFFFFFFFFFFTTTTTTTTTTTTTTTTTTTTTTTKKKKKKKKK    KKKKKKK
F--------------------FT---------------------TK-------K    K-----K
F--------------------FT---------------------TK-------K    K-----K
FF------FFFFFFFFF----FT-----TT-------TT-----TK-------K   K------K
  F-----F       FFFFFFTTTTTT  T-----T  TTTTTTKK------K  K-----KKK
  F-----F                     T-----T          K-----K K-----K   
  F------FFFFFFFFFF           T-----T          K------K-----K    
  F---------------F           T-----T          K-----------K     
  F---------------F           T-----T          K-----------K     
  F------FFFFFFFFFF           T-----T          K------K-----K    
  F-----F                     T-----T          K-----K K-----K   
  F-----F                     T-----T        KK------K  K-----KKK
FF-------FF                 TT-------TT      K-------K   K------K
F--------FF                 T---------T      K-------K    K-----K
F--------FF                 T---------T      K-------K    K-----K
FFFFFFFFFFF                 TTTTTTTTTTT      KKKKKKKKK    KKKKKKK
]]
	message = string.Explode("\n",message)
	local longest = 0
	for k, v in pairs(message) do
		if v:len() > longest then longest = v:len() end
	end
	epoe.MsgN("")
	for k, line in pairs(message) do
		for i=1, line:len() do
			local hue = ((i-1) / longest) * 360
			epoe.MsgC(HSVToColor(hue, 0.375, 1), line:sub(i, i))
		end
		epoe.MsgN("")
	end
	epoe.MsgN("")
end

local message = [[
FFFFFFFFFFFFFFFFFFFFFFTTTTTTTTTTTTTTTTTTTTTTT                               lllllll kkkkkkkk             iiii          tttt          
F--------------------FT---------------------T                               l-----l k------k            i----i      ttt---t          
F--------------------FT---------------------T                               l-----l k------k             iiii       t-----t          
FF------FFFFFFFFF----FT-----TT-------TT-----T                               l-----l k------k                        t-----t          
  F-----F       FFFFFFTTTTTT  T-----T  TTTTTTooooooooooo      ooooooooooo    l----l  k-----k    kkkkkkkiiiiiiittttttt-----ttttttt    
  F-----F                     T-----T      oo-----------oo  oo-----------oo  l----l  k-----k   k-----k i-----it-----------------t    
  F------FFFFFFFFFF           T-----T     o---------------oo---------------o l----l  k-----k  k-----k   i----it-----------------t    
  F---------------F           T-----T     o-----ooooo-----oo-----ooooo-----o l----l  k-----k k-----k    i----itttttt-------tttttt    
  F---------------F           T-----T     o----o     o----oo----o     o----o l----l  k------k-----k     i----i      t-----t          
  F------FFFFFFFFFF           T-----T     o----o     o----oo----o     o----o l----l  k-----------k      i----i      t-----t          
  F-----F                     T-----T     o----o     o----oo----o     o----o l----l  k-----------k      i----i      t-----t          
  F-----F                     T-----T     o----o     o----oo----o     o----o l----l  k------k-----k     i----i      t-----t    tttttt
FF-------FF                 TT-------TT   o-----ooooo-----oo-----ooooo-----ol------lk------k k-----k   i------i     t------tttt-----t
F--------FF                 T---------T   o---------------oo---------------ol------lk------k  k-----k  i------i     tt--------------t
F--------FF                 T---------T    oo-----------oo  oo-----------oo l------lk------k   k-----k i------i       tt-----------tt
FFFFFFFFFFF                 TTTTTTTTTTT      ooooooooooo      ooooooooooo   llllllllkkkkkkkk    kkkkkkkiiiiiiii         ttttttttttt  
]]
message = string.Explode("\n",message)

local longest = 0
for k, v in pairs(message) do
	if v:len() > longest then longest = v:len() end
end
MsgN("")
for k, line in pairs(message) do
	for i=1, line:len() do
		local hue = ((i-1) / longest) * 360
		MsgC(HSVToColor(hue, 0.375, 1), line:sub(i, i))
	end
	MsgN("")
end
MsgN("")

function FTK.Print(txt)
	MsgC(Color(0,150,130),"[FToolkit] ",Color(255,255,255),txt.."\n")
	if epoe then
		epoe.MsgC(Color(0,150,130),"[FToolkit] ")
		epoe.MsgC(Color(255,255,255),txt.."\n")
	end
end
function FTK.ChatPrint(txt)
	chat.AddText(Color(0,150,130),"[FToolkit] ",Color(255,255,255),txt)
end

function FTK.LoadAll()
	for _,f in pairs(file.Find("lua/ftoolkit/*","GAME")) do
		CompileString(file.Read("lua/ftoolkit/"..f,"GAME"),f,false)
		FTK.Print("Loaded "..f)
	end
end

function FTK.LoadAllData()
	for _,f in pairs(file.Find("ftoolkit/*","DATA")) do
		if f == "firstrun.txt" then continue end
		CompileString(file.Read("ftoolkit/"..f,"DATA"),f,false)
		FTK.Print("Loaded "..f)
	end
end

function FTK.LoadSingleFile(f)
	CompileString(file.Read("ftoolkit/"..f,"LUA"),f,false)
	FTK.Print("Loaded "..f)
end

function FTK.LoadDataFile(f)
	CompileString(file.Read("ftoolkit/"..f,"DATA"),f,false)
	FTK.Print("Loaded "..f)
end

function FTK.SaveURL(url,name)
	http.Fetch(url,
	function(content)
		FSWrite("ftoolkit/"..name,content)
		FTK.Print("Wrote "..name.." to data/ftoolkit.")
	end,
	function(err)
		FTK.Print("Error getting file: "..err)
	end)
end

local url = "https://raw.githubusercontent.com/LUModder/FToolkit/scripts/"

function FTK.Update()
	for _,f in pairs(FTK.FileList) do
		if file.Exists("ftoolkit/"..f,"DATA") then
			file.Delete("ftoolkit/"..f )
		end
		FTK.SaveURL(url..f,f)
	end
end

function FTK.LastCommit()
	local lc = {}
	local lc2 = {}
	http.Fetch("https://api.github.com/repos/LUModder/FToolkit/commits",
	function(body)
		lc = util.JSONToTable(body)[1]
		http.Fetch("https://api.github.com/repos/LUModder/FToolkit/commits/"..lc.sha,
		function(body)
			lc2 = util.JSONToTable(body)
			FTK.ChatPrint("Lastest FTK Commit:")
			chat.AddText(Color(255,255,255),"Commit ",Color(0,150,130),lc.sha,Color(255,255,255)," by ",Color(0,150,130),lc.commit.author.name)
			chat.AddText(Color(255,255,255),"\t"..lc.commit.message)
			chat.AddText(Color(0,150,130),"Files:")
			for _,f in pairs(lc2.files) do
				if f.additions == 0 then prefix = "D"
				elseif f.deletions == 0 then prefix = "A"
				else prefix = "U" end
				chat.AddText(Color(0,150,130),prefix,Color(255,255,255),"\t"..f.filename)
			end
		end,
		function(err)
			FTK.Print("Error getting commit info: "..err)
		end)
	end,
	function(err)
		FTK.Print("Error getting commit info: "..err)
	end)
end

function FTK.UpdateCheck()
	FTK.Print("STARTING UPDATE CHECK")
	local upd = 0
	for _,f in pairs(FTK.FileList) do
		http.Fetch(url..f,
		function(a)
			if file.Exists("ftoolkit/"..f,"DATA") and file.Read("ftoolkit/"..f,"DATA") == a then
				FTK.Print(f.." up to date.")
			else
				FTK.Print(f.." missing, modified or needs updating.")
				upd = upd+1
			end
		end,
		function(e)
			FTK.Print("Error reading file: "..e)
		end)
	end
	timer.Simple(5,function()
		FTK.Print("ENDING UPDATE CHECK")
		FTK.Print(upd.." files need to be updated.")
		if upd > 0 then
			FTK.Print("Please backup any modifications and run FTK.Update()")
		end
	end)
end

FTK.Print("Fully loaded! :D")
MsgN()
FTK.Print("\\/\\/\\/\\/\\/\nFTK Functions:\nFTK.LoadDataFile(file) - Runs a file found in data/ftoolkit\nFTK.LoadSingleFile(f) - Load a lua file\nFTK.SaveURL(url,name) - Save a URL to data directory")

http.Fetch("https://raw.githubusercontent.com/LUModder/FToolkit/master/ftoolkit.lua",
	function(a)
		if file.Exists("autorun/client/ftoolkit.lua","LUA") and file.Read("autorun/client/ftoolkit.lua","LUA") == a then
			FTK.ChatPrint("FTK up to date.")
			FTK.Print("FTK up to date.")
		else
			if LocalPlayer():SteamID() == "STEAM_0:0:58178275" then
				FTK.ChatPrint("Running FTK dev version.")
				FTK.Print("Running FTK dev version.")
			else
				FTK.ChatPrint("FTK modified or needs updating.")
				FTK.Print("FTK modified or needs updating.")
			end
		end
	end,
	function(err)
		FTK.Print("Error getting file: "..err)
	end
)

FTK.LastCommit()

if not file.Exists("ftoolkit/firstrun.txt","DATA") then
	FTK.ChatPrint("First run detected, downloading files.")
	FTK.Print("First run detected, downloading files.")
	file.Write("ftoolkit/firstrun.txt","!!!!DO NOT DELETE THIS OR ELSE FTK WILL TRY TO REDOWNLOAD EVERYTHING!!!!")
	FTK.Update()
end

FTK.UpdateCheck()