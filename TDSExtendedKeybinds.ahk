#Requires AutoHotkey v2.0

rbxDetectMouse(){
    loop 5{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 1, "Int", 0)
    }loop 5{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", -1, "Int", 0)
    }
}

rbxCameraMove(x, y){
    MouseClick('R down')
    DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
    MouseClick('R up')
}
rbxMouseMove(x, y){
    DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
}

mygui := Gui('AlwaysOnTop', 'TDSEK')

mygui.AddCheckbox('','Toggle Auto-skip')

mygui.Show()

^L::{
    MouseMove(0,0) ;settings
    rbxDetectMouse()
    Click()

    MouseMove(0,0) ;toggle
    rbxDetectMouse()
    Click()

    MouseMove(0,0) ;exit
    rbxDetectMouse()
    Click()
}
g::{
    MouseGetPos(&OutputX, &OutputY)
    A_Clipboard := 1/(A_ScreenWidth/OutputX) ', ' 1/(A_ScreenHeight/OutputY)
}