#Requires AutoHotkey v2.0

myGui := Gui("")
textgui := myGui.Add("Text","w150","Press Alt+K to close macro")
speedText := myGui.Add("Text",, "Anti-recoil speed:")
speedText.GetPos(&x,&y,&w,&h)
editgui := myGui.Add("Edit","x" x+w " y" y " w30","1")
myGui.Show

Hotkey("*~$LButton")
*~$LButton::
{
    while(GetKeyState("LButton")){
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 0, "Int", Integer(editgui.Value))
        Sleep(1)
    }
}
!k::ExitApp()