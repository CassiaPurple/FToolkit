--[[
FToolkit: An automated script loader
by Flex
--]]

require("gaceio")

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

function FTK.LoadAll()
	for _,f in pairs(file.Find("lua/ftoolkit/*","GAME")) do
		RunString(file.Read("lua/ftoolkit/"..f,"GAME"))
		FTK.Print("Loaded "..f)
	end
end

function FTK.LoadAllData()
	for _,f in pairs(file.Find("ftoolkit/*","DATA")) do
		RunString(file.Read("ftoolkit/"..f,"DATA"))
		FTK.Print("Loaded "..f)
	end
end

function FTK.LoadSingleFile(f)
	RunString(file.Read("ftoolkit/"..f,"LUA"))
	FTK.Print("Loaded "..f)
end

function FTK.LoadDataFile(f)
	RunString(file.Read("ftoolkit/"..f,"DATA"))
	FTK.Print("Loaded "..f)
end

function FTK.SaveURL(url,name)
	http.Fetch(url,
	function(content)
		file.Write("ftoolkit/"..name..".txt",content)
		FTK.Print("Wrote "..name.." to data/ftoolkit.")
	end,
	function(err)
		FTK.Print("Error getting file: "..err)
	end)
end

function FTK.SaveURLToLua(url,name)
	http.Fetch(url,
	function(content)
		gaceio.Write("./garrysmod/lua/ftoolkit/"..name,content)
		FTK.Print("Wrote "..name.." to data/ftoolkit.")
	end,
	function(err)
		FTK.Print("Error getting file: "..err)
	end)
end

local url = "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\76\85\77\111\100\100\101\114\47\70\84\111\111\108\107\105\116\47\109\97\115\116\101\114\47\115\99\114\105\112\116\115\47"

function FTK.Update()
	for _,f in pairs(FTK.FileList) do
		if file.Exists("ftoolkit/"..f,"LUA") then
			gaceio.Delete("./garrysmod/lua/ftoolkit/"..f)
		end
		FTK.SaveURLToLua(url..f,f)
	end
end

function FTK.UpdateCheck()
	FTK.Print("STARTING UPDATE CHECK")
	local upd = 0
	for _,f in pairs(FTK.FileList) do
		http.Fetch(url..f,
		function(a)
			if file.Exists("ftoolkit/"..f,"LUA") and file.Read("ftoolkit/"..f,"LUA") == a then
				FTK.Print(f.." up to date.")
				upd = upd+1
			else
				FTK.Print(f.." missing, modified or needs updating.")
			end
		end,
		function(e)
			FTK.Print("Error reading file: "..err)
		end)
	end
	FTK.Print("ENDING UPDATE CHECK")
	FTK.Print(upd.." files need to be updated.")
	FTK.Print("Please backup any modifications and run FTK.Update()")
end

if not file.Exists("ftoolkit/firstrun.txt","DATA") then
	FTK.Print("First run detected, downloading files")
	file.Write("ftoolkit/firstrun.txt","!!!!DO NOT DELETE THIS OR ELSE FTK WILL TRY TO REDOWNLOAD EVERYTHING!!!!")
	FTK.Update()
end

FTK.Print("Fully loaded! :D")
MsgN()
FTK.Print("\\/\\/\\/\\/\\/\nFTK Functions:\nFTK.LoadDataFile(file) - Runs a file found in data/ftoolkit\nFTK.LoadSingleFile(f) - Load a lua file\nFTK.SaveURL(url,name) - Save a URL to data directory\nFTK.SaveURLToLua(url,name) - Save a URL to lua directory")