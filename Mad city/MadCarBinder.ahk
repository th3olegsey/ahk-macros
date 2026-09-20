#Requires AutoHotkey v2.0
mcbGui := Gui("AlwaysOnTop")
mcbDDLEdit := mcbGui.AddDropDownList("w200",["hyper glider", "terminator", "riptide"])
mcbKillBtn := mcbGui.AddButton("W200", "Spawn")
mcbKillBtn.OnEvent("Click", spawn)
mcbGui.OnEvent("Close", killgui)
inSearchValue := "none"
spawn(*){
    WinActivate("Roblox")
    spawncar(mcbDDLEdit.Text)
}
mcbGui.Show
spawncar(car){
    if(GetKeyState("RButton")){
        Send("{RButton up}")
    }
    SendMode("Event")
    Send("{m}") ;open mobile
    MouseGetPos(&x, &y)
    Sleep(5)
    MouseMove(A_ScreenWidth*0.13, A_ScreenHeight*0.62) ;spawn section
    Click()
    MouseMove(A_ScreenWidth*0.089, A_ScreenHeight*0.58) ;search bar
    Sleep(5)
    Send("{Click 3}")
    SendMode("Input")
    Send("{Raw}" car)
    SendMode("Event")
    MouseMove(A_ScreenWidth*0.055, A_ScreenHeight*0.66) ;spawn
    Click()
    SendMode("Input")
    MouseMove(x,y)
    loop 2{
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 1, "Int", 0) ;update mouse pos in the rolobx client
    }
}
killgui(*){
    ExitApp
}
