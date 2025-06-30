# valorant-res-switcher
fast res switching for valorant. made this because going through nvidia control panel every time is annoying.

## how to use
download both files and run ValorantResSwitcher.bat (just double click it). 
press Q/W/E/R for quick switching or use the menu.
- Q = 1920x1080 
- W = 1440x1080 (most popular)
- E = 1600x1080 
- R = 1280x1080

works with any gpu. uses windows api not driver stuff.

## install
download ValorantResSwitcher.bat and ValorantResSwitcher.ps1 (keep them in the same folder) then run the .bat file.

## important: adding custom resolutions
**if a resolution doesn't work, you need to add it through your gpu control panel first (ONE TIME setup):**

**nvidia users:**
1. right-click desktop → nvidia control panel
2. display → change resolution
3. click "customize..." button
4. click "create custom resolution"
5. enter your desired resolution (like 1440x1080)
6. test and save

**amd users:**
1. right-click desktop → amd software
2. display → custom resolutions
3. create your resolution

**intel users:**
1. right-click desktop → intel graphics settings
2. display → custom resolutions
3. add your resolution

you can also press [H] in the tool for this guide.

## getting true stretch (important)
valorant resets your res every game so you need to do this:
1. go to device manager and disable all your monitors
2. launch valorant, go into a game
3. set display mode to "windowed fullscreen" and scaling to "fill"
4. use this tool to switch to your stretch res (like 1440x1080)
5. when round ends and youre in lobby, switch back to 1920x1080
6. next game make sure youre on "fill" then switch to stretch res again

if you dont do this youll get black bars instead of true stretch. valorant is weird like that.
will add video guide later.

## troubleshooting
**script closes immediately:** use the .bat file instead of the .ps1
**resolution fails with error code -2:** you need to add that resolution through your gpu control panel first
**still having issues:** try running as administrator

## why
switching stretched res in valorant sucks when you have to go through control panels. this stays open so you can switch fast between games.
tested on windows 10/11 with nvidia and amd cards.

---
**credits:**
- lxzy - main dev - [lxzy.dev](https://lxzy.dev)
- flo - helped test
