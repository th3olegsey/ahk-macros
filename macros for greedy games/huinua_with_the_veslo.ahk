#Requires AutoHotkey v2.0
SendMode("Event")
XButton2::
{
    loop 9{
        Send(A_Index)
        Sleep(21)
        Click("L")
        Sleep(21)
    }
}