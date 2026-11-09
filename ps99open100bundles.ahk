#Requires AutoHotkey v2.0
bloxMoveMouse(x,y){
    loop 8{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", x, "Int", y)
    }
}
getScreenRatio(){
    MouseGetPos(&OutputX, &OutputY)
    Xratio := 1/(A_ScreenWidth/OutputX)
    Yratio := 1/(A_ScreenHeight/OutputY)
    A_Clipboard := Xratio ' ' Yratio
}
doMacro(){
; 0.26 0.37
; 0.34 0.62
    MouseMove(A_ScreenWidth*0.26, A_ScreenHeight*0.37)
    bloxMoveMouse(1,0)
    Click('R')
    Sleep(100)
    MouseMove(A_ScreenWidth*0.34, A_ScreenHeight*0.62)
    bloxMoveMouse(1,0)
    Click()
    Sleep(450)
}
h::doMacro()