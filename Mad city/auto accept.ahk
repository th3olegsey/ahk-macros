#Requires AutoHotkey v2.0
executions := 0
SendMode("Event")
autoSkipFunc(*){
    while(autoAcceptCheckbox.Value == 1){
        if(PixelSearch(&asd, &dsa, A_ScreenWidth*(1-0.47)+20, A_ScreenHeight*0.95+20, A_ScreenWidth*(1-0.47)-20, A_ScreenHeight*0.95-20, 0xef4646) AND PixelSearch(&asd, &dsa, A_ScreenWidth*0.47+20, A_ScreenHeight*0.95+20, A_ScreenWidth*0.47-20, A_ScreenHeight*0.95-20, 0X22bf86))
        {
            Send("{1}{2}{1 2}{e down}")
            Sleep 20
            Send("{e up}")
            if(GetKeyState("RButton")){
                Send("{RButton up}")
            }
            MouseGetPos(&currentX, &currentY)
            MouseMove(A_ScreenWidth*0.47, A_ScreenHeight*0.95)
            loop 15
            {
                DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", -1, "Int", 0)
            }
            Click()
            MouseMove(currentX, currentY)
            if(executions >= 15){
                MsgBox("Are you stuck?`nThe program will be closed.")
                ExitApp()
            }
            global executions += 1
        }
        else{
            global executions := 0
        }
        Sleep(250)
    }
}
^k::ExitApp() ;ctrl+k to close program
myGui := Gui("AlwaysOnTop")

autoAcceptCheckbox := myGui.AddCheckbox("W200","Autoaccept")
autoAcceptCheckbox.OnEvent("Click", autoSkipFunc)

myGui.Show
myGui.OnEvent("Close", closefunc)
closefunc(*){
    ExitApp
}