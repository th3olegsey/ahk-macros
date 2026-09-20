#Requires AutoHotkey v2.0
;global scrHei := 600
;global scrWid := 300
global scrHei := A_ScreenHeight/3
global scrWid := A_ScreenHeight/3
global tarCol := 0x0B0B0B
global acc := 12
openRoblox(*){
    if(StrLen(jobidEdit.Value) != 0){
        Run("roblox://placeId=79245845160905&gameInstanceId=" jobidEdit.Value)
        OutputDebug("JobID=" jobidEdit.Value)
    }
    else{
        Run("roblox://placeId=79245845160905")
    }
}
autorejoin(*){
    if(autorejoinCheckbox.Value = 1){
        ;OutputDebug('autorejoin: true')
        loop{
            if((WinActive("Roblox")
            AND PixelSearch(&a, &b, scrHei-5,scrWid-5,scrHei+5,scrWid+5,tarCol,acc)
            AND PixelSearch(&a, &b, scrHei*2-5,scrWid-5,scrHei*2+5,scrWid+5,tarCol,acc)
            AND PixelSearch(&a, &b, scrHei-5,scrWid*2-5,scrHei+5,scrWid*2+5,tarCol,acc)
            AND PixelSearch(&a, &b, scrHei*2-5,scrWid*2-5,scrHei*2+5,scrWid*2+5,tarCol,acc))
            OR AutorejoinCheckbox.Value = 0){
                if(AutorejoinCheckbox.Value = 1){
                    ;OutputDebug("conditions:" WinActive("Roblox") PixelSearch(&a, &b, scrHei,scrWid,scrHei,scrWid,tarCol,acc) PixelSearch(&a, &b, scrHei*2,scrWid,scrHei*2,scrWid,tarCol,acc) PixelSearch(&a, &b, scrHei,scrWid*2,scrHei,scrWid*2,tarCol,acc) PixelSearch(&a, &b, scrHei*2,scrWid*2,scrHei*2,scrWid*2,tarCol,acc))
                    OutputDebug("rejoin")
                    openRoblox
                    Sleep(10000)
                }
                autorejoin
                break
            }
            Sleep(100)
            ;OutputDebug("conditions:" WinActive("Roblox") PixelSearch(&a, &b, scrHei,scrWid,scrHei,scrWid,tarCol,acc) PixelSearch(&a, &b, scrHei*2,scrWid,scrHei*2,scrWid,tarCol,acc) PixelSearch(&a, &b, scrHei,scrWid*2,scrHei,scrWid*2,tarCol,acc) PixelSearch(&a, &b, scrHei*2,scrWid*2,scrHei*2,scrWid*2,tarCol,acc))
            OutputDebug("checking")
        }
    }
}
macro_gui := Gui("AlwaysOnTop")
macro_gui.AddText("", "JobID:")
jobidEdit := macro_gui.AddEdit("w220", "")

AutorejoinCheckbox := macro_gui.AddCheckbox("", "Autorejoin")
AutorejoinCheckbox.OnEvent("Click", autorejoin)

lauchRobloxButton := macro_gui.AddButton("", "Launch roblox")
lauchRobloxButton.OnEvent("Click", openRoblox)

macro_gui.Show()
^k::Reload
;b::{ ;debugging stuff
;    MouseGetPos(&a, &b)
;    OutputDebug(a ", " b)
;    OutputDebug(1/(A_ScreenWidth/a) ", " 1/(A_ScreenHeight/b))
;}

;0.4