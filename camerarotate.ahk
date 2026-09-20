#Requires AutoHotkey v2.0
SendMode('Event')
h::{
    Click('R down')
    MouseMove(150,0,10,'R')
}

rbxMouseMove(x, y){
    DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
}
