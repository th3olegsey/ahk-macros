#Requires AutoHotkey v2.0
SendMode('Event')
active := false
servers := ['57164210841878498111730906349530', '90019469343601177382903305522678']
n := 1

ui := Gui('AlwaysOnTop')
acCheckbox := ui.AddCheckbox('checked w150','Auto-compete: Off')
stCheckbox := ui.AddCheckbox('checked','Server: Сергей')
ui.Show()
WinSetTransparent(100, A_ScriptName)
die(*){
    ExitApp()
}
ui.OnEvent('Close', die)
macro(){
    if PixelSearch(&x,&y, 542, 358, 1385, 698, 0xDA0000, 2){
        MouseMove(x+50,y+50,1)
        loop 3{
            DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 1, "Int", 0)
        }
        Click()
    }
}
*~l::{
    if acCheckbox.Value AND WinActive('Roblox'){
            global active
        active := !active

        if active{
            SetTimer(macro,1)
            acCheckbox.Text := 'Auto-compete: On'
        }else{
            SetTimer(macro,0)
            acCheckbox.Text := 'Auto-compete: Off'
        }
    }

}
XButton2::{
    loop 3{
        Send(A_Index)
        Click
    }
}
*~b::{
    if stCheckbox.Value{
            if Mod(n,2) == 0{
            Run("roblox://placeId=91355853256093&linkCode=" servers[1])
            stCheckbox.text := 'Server: Сергей'
        }else{
            Run("roblox://placeId=91355853256093&linkCode=" servers[2])
            stCheckbox.text := 'Server: Леша'
        }
        global n := n + 1
    }

}