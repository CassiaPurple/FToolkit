![](https://my.mixtape.moe/fefjeq.png)
=======
Script Loader for Garry's Mod

Requirements
=======
 - [gm_filesystem](https://github.com/danielga/gm_filesystem/releases)
 - GLua knowledge
 - menu2 or lua bypass (depending on your use for this script)

Installation
=======
 - Drop into ```autorun/client/```
 - Ignore the scripts folder (it'll auto download on run)

Usage
=======
 - ```include("autorun/client/ftoolkit.lua")``` OR
 - ```CompileString(file.Read("autorun/client/ftoolkit.lua","LUA"),"FToolkit",true)()```
 - ```RunString(file.Read("autorun/client/ftoolkit.lua","LUA"),"FToolkit",true)```

Chat Commands
=======
All commands start with !, / or .

 - rs - RunString alias
 - ldf - FTK.LoadDataFile alias
 - lsf - FTK.LoadSingleFile alias
 - rs.ldf - FTK.RS.LoadDataFile alias
 - rs.lsf - FTK.RS.LoadSingleFile alias

Credits
=======
As I do not own all the scripts in the scripts folder, so here are the original authors.

 - autojump - Metastruct
 - CTP - CapsAdmin
 - Frametime (integrated in FESP) - Metastruct
 - FZoom - Falco (FPjte)
 - Picker2 - tldevtools/Metastruct
 - Propinfo - Ducky Canard
 - SmartSnap - Various Authors
 - Smeg Hack - mmmaaalll1
 - menu_plugins (used for fading colors in ASCII art) - Various Authors

My own scripts added:

 - FCrosshair
 - FESP