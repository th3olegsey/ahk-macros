#Requires AutoHotkey v2.0
;SendMode("Input")
*~XButton2::
{
    while(GetKeyState("XButton2")){
        Click("R down")
        Click("L")
        Click("R up")
        if(GetKeyState("Shift")){
            Send("{Shift 2 up}")
            OutputDebug("1 true")
        }
    Sleep(1)
    }
}
!k::ExitApp()