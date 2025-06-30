# valorant-res-switcher

fast res switching for valorant. made this because going through nvidia control panel every time is annoying.

## how to use

download the ps1 file and run it. press Q/W/E/R for quick switching or use the menu.

- Q = 1920x1080 
- W = 1440x1080 (most popular)
- E = 1600x1080 
- R = 1280x1080

works with any gpu. uses windows api not driver stuff.

## install

just download ValorantResSwitcher.ps1 and run it. might need to run as admin.

if windows blocks it:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

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

## why

switching stretched res in valorant sucks when you have to go through control panels. this stays open so you can switch fast between games.

tested on windows 10/11 with nvidia and amd cards.

---
made by lxzy - [lxzy.dev](https://lxzy.dev)
