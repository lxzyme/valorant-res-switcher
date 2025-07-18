Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class UniversalDisplay {
    [DllImport("user32.dll")]
    public static extern int ChangeDisplaySettings(ref DEVMODE devMode, int flags);
    
    [StructLayout(LayoutKind.Sequential)]
    public struct DEVMODE {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;
        public int dmPositionX;
        public int dmPositionY;
        public int dmDisplayOrientation;
        public int dmDisplayFixedOutput;
        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmFormName;
        public short dmLogPixels;
        public int dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;
        public int dmDisplayFlags;
        public int dmDisplayFrequency;
    }
}
"@

function Set-UniversalResolution {
    param(
        [int]$Width,
        [int]$Height
    )
    
    $devMode = New-Object UniversalDisplay+DEVMODE
    $devMode.dmSize = [System.Runtime.InteropServices.Marshal]::SizeOf($devMode)
    $devMode.dmPelsWidth = $Width
    $devMode.dmPelsHeight = $Height
    $devMode.dmFields = 0x80000 -bor 0x100000
    
    $result = [UniversalDisplay]::ChangeDisplaySettings([ref]$devMode, 0)
    
    if ($result -eq 0) {
        Write-Host "[SUCCESS] " -NoNewline -ForegroundColor Green
        Write-Host "Resolution changed to " -NoNewline -ForegroundColor White
        Write-Host "$Width x $Height" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 300
    } else {
        Write-Host "[ERROR] " -NoNewline -ForegroundColor Red
        Write-Host "Failed to change resolution. Error code $result" -ForegroundColor Red
        Write-Host "Try running as Administrator or check if resolution is supported." -ForegroundColor Yellow
    }
}

function Open-DeviceManager {
    Write-Host ""
    Write-Host "Opening Device Manager..." -ForegroundColor Yellow
    try {
        Start-Process "devmgmt.msc"
        Write-Host "[SUCCESS] " -NoNewline -ForegroundColor Green
        Write-Host "Device Manager opened" -ForegroundColor White
        Start-Sleep -Milliseconds 500
    }
    catch {
        Write-Host "[ERROR] " -NoNewline -ForegroundColor Red
        Write-Host "Failed to open Device Manager" -ForegroundColor Red
    }
}

function Show-Header {
    Clear-Host
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "                VALORANT RESOLUTION SWITCHER v1.1              " -ForegroundColor White
    Write-Host "                      Created by lxzy                          " -ForegroundColor Magenta
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    NVIDIA AMD Intel Any GPU   Uses Windows Display API        " -ForegroundColor Yellow
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Gray
}

function Show-QuickMenu {
    Write-Host ""
    Write-Host "FAST SWITCHING" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  [Q] " -NoNewline -ForegroundColor Cyan
    Write-Host "1920x1080 " -NoNewline -ForegroundColor White
    Write-Host "Native 16 to 9" -ForegroundColor Gray
    
    Write-Host "  [W] " -NoNewline -ForegroundColor Cyan
    Write-Host "1440x1080 " -NoNewline -ForegroundColor White
    Write-Host "Stretched - Most Popular" -ForegroundColor Gray
    
    Write-Host "  [E] " -NoNewline -ForegroundColor Cyan
    Write-Host "1600x1080 " -NoNewline -ForegroundColor White
    Write-Host "Less Stretched" -ForegroundColor Gray
    
    Write-Host "  [R] " -NoNewline -ForegroundColor Cyan
    Write-Host "1280x1080 " -NoNewline -ForegroundColor White
    Write-Host "More Stretched" -ForegroundColor Gray
    
    Write-Host "  [D] " -NoNewline -ForegroundColor Cyan
    Write-Host "Device Manager " -NoNewline -ForegroundColor White
    Write-Host "" -ForegroundColor Gray
    Write-Host ""
}

function Show-FullMenu {
    Write-Host "ALL RESOLUTION OPTIONS" -ForegroundColor Blue
    Write-Host ""
    Write-Host "  [1] 1920x1080 Native             [6] 1024x768 Classic" -ForegroundColor Gray
    Write-Host "  [2] 1440x1080 Stretched          [7] 1280x960 Classic" -ForegroundColor Gray  
    Write-Host "  [3] 1600x1080 Stretched          [8] 1720x1080 Wide" -ForegroundColor Gray
    Write-Host "  [4] 1280x1080 Stretched          [9] Custom Resolution" -ForegroundColor Gray
    Write-Host "  [5] 1350x1080 Stretched          [H] How to add resolutions" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  [0] Exit Program" -ForegroundColor Red
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Gray
    Write-Host ""
}

function Show-ResolutionGuide {
    Clear-Host
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host "                HOW TO ADD MORE RESOLUTIONS                     " -ForegroundColor White
    Write-Host "================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "NVIDIA USERS:" -ForegroundColor Green
    Write-Host "1. Right-click desktop -> NVIDIA Control Panel" -ForegroundColor White
    Write-Host "2. Display -> Change resolution" -ForegroundColor White
    Write-Host "3. Click 'Customize...' button" -ForegroundColor White
    Write-Host "4. Click 'Create Custom Resolution'" -ForegroundColor White
    Write-Host "5. Enter width/height (e.g., 1440x1080)" -ForegroundColor White
    Write-Host "6. Set refresh rate to match your monitor" -ForegroundColor White
    Write-Host "7. Click 'Test' then 'OK' if it works" -ForegroundColor White
    Write-Host ""
    
    Write-Host "AMD USERS:" -ForegroundColor Red
    Write-Host "1. Right-click desktop -> AMD Software" -ForegroundColor White
    Write-Host "2. Display -> Custom Resolutions" -ForegroundColor White
    Write-Host "3. Click 'Create New'" -ForegroundColor White
    Write-Host "4. Enter your desired resolution" -ForegroundColor White
    Write-Host "5. Test and save if working" -ForegroundColor White
    Write-Host ""
    
    Write-Host "INTEL USERS:" -ForegroundColor Blue
    Write-Host "1. Right-click desktop -> Intel Graphics Settings" -ForegroundColor White
    Write-Host "2. Display -> Custom Resolutions" -ForegroundColor White
    Write-Host "3. Add your custom resolution" -ForegroundColor White
    Write-Host ""
    
    Write-Host "POPULAR VALORANT RESOLUTIONS TO ADD:" -ForegroundColor Yellow
    Write-Host "- 1440x1080 (Most popular stretched)" -ForegroundColor White
    Write-Host "- 1600x1080 (Less stretched)" -ForegroundColor White
    Write-Host "- 1280x1080 (More stretched)" -ForegroundColor White
    Write-Host "- 1350x1080 (Alternative stretched)" -ForegroundColor White
    Write-Host ""
    
    Write-Host "NOTE: Always test custom resolutions before applying" -ForegroundColor Yellow
    Write-Host "If your screen goes black, wait 15 seconds for auto-revert." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "TIP: Use [D] option to open Device Manager" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Press any key to return to main menu..." -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Get-CustomResolution {
    Write-Host "CUSTOM RESOLUTION SETUP" -ForegroundColor Magenta
    Write-Host "================================" -ForegroundColor Gray
    Write-Host ""
    Write-Host "NOTE: Resolution must be added through GPU control panel first!" -ForegroundColor Yellow
    Write-Host "Use [H] option to learn how to add new resolutions." -ForegroundColor Yellow
    Write-Host ""
    
    do {
        $width = Read-Host "Enter width example 1440"
        if ($width -match '^\d+$' -and [int]$width -gt 0 -and [int]$width -le 7680) { 
            break 
        }
        Write-Host "Please enter a valid width 1-7680" -ForegroundColor Red
    } while ($true)
    
    do {
        $height = Read-Host "Enter height example 1080"
        if ($height -match '^\d+$' -and [int]$height -gt 0 -and [int]$height -le 4320) { 
            break 
        }
        Write-Host "Please enter a valid height 1-4320" -ForegroundColor Red
    } while ($true)
    
    return @{Width = [int]$width; Height = [int]$height}
}

function Show-Credits {
    Clear-Host
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host "                                                                " -ForegroundColor Green
    Write-Host "              Thanks for using lxzy Res Switcher                " -ForegroundColor Green
    Write-Host "                                                                " -ForegroundColor Green
    Write-Host "              Good luck in your Valorant games                  " -ForegroundColor Yellow
    Write-Host "                                                                " -ForegroundColor Green
    Write-Host "================================================================" -ForegroundColor Green
    Write-Host ""
}

$ResolutionMap = @{
    'q' = @{Width = 1920; Height = 1080; Name = "Native"}
    'w' = @{Width = 1440; Height = 1080; Name = "Stretched"}
    'e' = @{Width = 1600; Height = 1080; Name = "Less Stretched"}  
    'r' = @{Width = 1280; Height = 1080; Name = "More Stretched"}
    '1' = @{Width = 1920; Height = 1080; Name = "Native"}
    '2' = @{Width = 1440; Height = 1080; Name = "Stretched"}
    '3' = @{Width = 1600; Height = 1080; Name = "Stretched"}
    '4' = @{Width = 1280; Height = 1080; Name = "Stretched"}
    '5' = @{Width = 1350; Height = 1080; Name = "Stretched"}
    '6' = @{Width = 1024; Height = 768; Name = "Classic"}
    '7' = @{Width = 1280; Height = 960; Name = "Classic"}
    '8' = @{Width = 1720; Height = 1080; Name = "Wide"}
}

do {
    Show-Header
    Show-QuickMenu
    Show-FullMenu
    
    $userChoice = Read-Host "Select resolution option"
    $userChoice = $userChoice.ToLower().Trim()
    
    if ($userChoice -eq '0' -or $userChoice -eq 'exit' -or $userChoice -eq 'quit') {
        Show-Credits
        Start-Sleep -Seconds 3
        break
    }
    elseif ($userChoice -eq 'd' -or $userChoice -eq 'device' -or $userChoice -eq 'devmgmt') {
        Open-DeviceManager
        Write-Host ""
        Write-Host "Press any key to return to menu..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    elseif ($userChoice -eq 'h' -or $userChoice -eq 'help') {
        Show-ResolutionGuide
    }
    elseif ($userChoice -eq '9' -or $userChoice -eq 'custom') {
        $customRes = Get-CustomResolution
        Write-Host ""
        Write-Host "Applying custom resolution $($customRes.Width)x$($customRes.Height)..." -ForegroundColor Yellow
        Set-UniversalResolution -Width $customRes.Width -Height $customRes.Height
        Write-Host ""
        Write-Host "Press any key to return to menu..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    elseif ($ResolutionMap.ContainsKey($userChoice)) {
        $selectedRes = $ResolutionMap[$userChoice]
        
        Write-Host "Changing to $($selectedRes.Width)x$($selectedRes.Height) $($selectedRes.Name)..." -ForegroundColor Yellow
        Set-UniversalResolution -Width $selectedRes.Width -Height $selectedRes.Height
        
        Write-Host ""
        Write-Host "Press any key to return to menu..." -ForegroundColor Cyan
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    else {
        Write-Host ""
        Write-Host "Invalid selection. Please try again." -ForegroundColor Red
        Start-Sleep -Seconds 1
    }
    
} while ($true)
