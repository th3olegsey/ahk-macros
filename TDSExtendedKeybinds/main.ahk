#Requires AutoHotkey v2.0

currentHotkey := IniRead('ini.ini','keys', 'toggle_autoskip_hotkey', 'f1')

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
    if GuiCtrlObj == hotkeyInput{
        global hotkeyInput, currentHotkey
        Hotkey(currentHotkey, 'off')
        currentHotkey := hotkeyInput.Value
        IniWrite(currentHotkey, 'ini.ini' ,'keys', 'toggle_autoskip_hotkey')
        Hotkey('~' currentHotkey, toggleAutoSkip, 'on')
    }
}
exitOnClose(*){
    ExitApp()
}

mygui := Gui('AlwaysOnTop', 'TDSEK')
mygui.tabs := mygui.AddTab3(,['Toggle', 'Edit keys'])
toggleAutoSkipCheckbox := mygui.AddCheckbox('','[VIP] Toggle Auto skip')
mygui.OnEvent('Close', exitOnClose)

mygui.tabs.UseTab(2)
hotkeyInput := mygui.AddHotkey(, currentHotkey)
hotkeyInput.OnEvent('Change', saveHotkey)

mygui.Show()

Hotkey('~' currentHotkey, toggleAutoSkip)
toggleAutoSkip(*){
    if WinActive('Roblox') AND toggleAutoSkipCheckbox.Value{
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
    }
}
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
