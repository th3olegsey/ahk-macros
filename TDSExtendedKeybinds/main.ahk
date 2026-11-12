#Requires AutoHotkey v2.0
#Include stratGui.ahk

currentToggleAutoSkipHotkey := IniRead('ini.ini','keys', 'toggle_autoskip_hotkey', 'f1')
currentSkipHotkey := IniRead('ini.ini','keys', 'skip_hotkey', 'f2')

rbxDetectMouse(){
    loop 5{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 1, "Int", 0)
    }loop 5{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", -1, "Int", 0)
    }
    Sleep(25)
}
rbxCameraMove(x, y){
    MouseClick('R down')
    DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
    MouseClick('R up')
}
rbxMouseMove(x, y){
    DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
}
saveHotkey(GuiCtrlObj, Info){
    global toggleAutoSkipHotkeyInput, currentToggleAutoSkipHotkey
    global skipHotkeyInput, currentSkipHotkey
    if GuiCtrlObj == toggleAutoSkipHotkeyInput{
        try{
            Hotkey('~' currentToggleAutoSkipHotkey, 'off')
        }
        currentToggleAutoSkipHotkey := toggleAutoSkipHotkeyInput.Value
        IniWrite(currentToggleAutoSkipHotkey, 'ini.ini' ,'keys', 'toggle_autoskip_hotkey')
        Hotkey('~' currentToggleAutoSkipHotkey, toggleAutoSkip, 'on')
    }
    else If GuiCtrlObj == skipHotkeyInput{
        try{
            Hotkey('~' currentSkipHotkey, 'off')
        }
        currentSkipHotkey := skipHotkeyInput.Value
        IniWrite(currentSkipHotkey, 'ini.ini' ,'keys', 'skip_hotkey')
        Hotkey('~' currentSkipHotkey, skipWave, 'on')
    }
}
exitOnClose(*){
    ExitApp()
}

mygui := Gui('AlwaysOnTop', 'TDSEK')
mygui.tabs := mygui.AddTab3(,['Toggle', 'Edit keys'])
mygui.OnEvent('Close', exitOnClose)
toggleAutoSkipCheckbox := mygui.AddCheckbox('','[VIP] Toggle Auto skip')
skipCheckbox := mygui.AddCheckbox('','Skip Wave Hotkey (if possible)')

mygui.tabs.UseTab(2)
toggleAutoSkipHotkeyInput := mygui.AddHotkey('w35', currentToggleAutoSkipHotkey)
toggleAutoSkipHotkeyInput.OnEvent('Change', saveHotkey)
toggleAutoSkipHotkeyInput.GetPos(&X, &Y, &W, &H)
mygui.AddText('x+m-4 yp+4','Toggle Auto Skip Hotkey')

skipHotkeyInput := mygui.AddHotkey('w35 x' X ' y' Y+H, currentSkipHotkey)
skipHotkeyInput.OnEvent('Change', saveHotkey)
skipHotkeyInput.GetPos(&X, &Y, &W, &H)
mygui.AddText('x+m-4 yp+4','Skip Hotkey')

mygui.Show()

Hotkey('~' currentToggleAutoSkipHotkey, toggleAutoSkip)
toggleAutoSkip(*){
    if WinActive('Roblox') AND toggleAutoSkipCheckbox.Value{
        SetTimer(followCursor, 0)
        SendMode('Input')
        stratGui.Hide()

        MouseGetPos(&OutputX, &OutputY)

        MouseMove(A_ScreenWidth*0.98, A_ScreenHeight*0.03) ;settings
        rbxDetectMouse()
        Click()

        MouseMove(A_ScreenWidth*0.33, A_ScreenHeight*0.32) ;gameplay tab
        rbxDetectMouse()
        Click()

        MouseMove(A_ScreenWidth*0.695, A_ScreenHeight*0.39) ;toggle
        rbxDetectMouse()
        Click()

        MouseMove(A_ScreenWidth*0.71, A_ScreenHeight*0.32) ;exit
        rbxDetectMouse()
        Click()

        MouseMove(OutputX, OutputY)
        rbxDetectMouse()

        stratGui.Show('NoActivate')
        SetTimer(followCursor, 10)
        CoordMode('Mouse', 'Screen')
    }
}
Hotkey('~' currentSkipHotkey, skipWave)
skipWave(*){
    if WinActive('Roblox') AND skipCheckbox.Value{
        SetTimer(followCursor, 0)
        SendMode('Input')
        stratGui.Hide()

        MouseGetPos(&OutputX, &OutputY)

        MouseMove(A_ScreenWidth*0.53, A_ScreenHeight*0.17)
        rbxDetectMouse()
        Click()

        MouseMove(OutputX, OutputY)
        rbxDetectMouse()

        stratGui.Show('NoActivate')
        SetTimer(followCursor, 10)
        CoordMode('Mouse', 'Screen')
    }
}
;dev tools
~g::{
    if false{ ;disabled by default. Change false to true to enable it. Note: ~ is strictly required
        MouseGetPos(&OutputX, &OutputY)
        A_Clipboard := 1/(A_ScreenWidth/OutputX) ', ' 1/(A_ScreenHeight/OutputY)
    }
}
~r::{ ;disabled by default.
    if false{
        Reload()
    }
}
