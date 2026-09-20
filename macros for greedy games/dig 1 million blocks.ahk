#Requires AutoHotkey v2.0
SendMode("Event")
setupSpotAndDig()
{
    ;move
    Send("{w down}") 
    Sleep(3580)
    Send("{w up}")
    Sleep(70)
    Send("{a down}")
    Sleep(36)
    Send("{a up}")
    
    ;dig
    MouseMove(A_ScreenWidth*.7-10, A_ScreenHeight*.63, 5)
    Click("R down")
    Click("L down")
    Send("{Left down}")
    Sleep(100)
    speed := 80
    loop 4500
    {
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", -speed, "Int", 0)
        Sleep(1)
    }
    Send("{Left up}")
    Click("R up")
    Click("L up")
    MouseMove(A_ScreenWidth/2.2, A_ScreenHeight/12.4, 5)
    Click("l")
}

FD()
{
    Send("{d down}") 
    Sleep(500)
    Send("{d up}")
    Sleep(70)
    Send("{s down}") 
    Sleep(3200)
    Send("{s up}")
    Sleep(70)
    Send("{a down}") 
    Sleep(500)
    Send("{a up}")
    MouseMove(A_ScreenWidth/2, A_ScreenHeight/2, 15)
    Click("WheelUp", 10)
    MouseMove(A_ScreenWidth/2, A_ScreenHeight/1.7, 15)
    Click("L")
}

SM()
{
    Send("{d down}") 
    Sleep(500)
    Send("{d up}")
    Sleep(70)
    Send("{s down}") 
    Sleep(3200)
    Send("{s up}")
    Sleep(70)
    Send("{a down}") 
    Sleep(500)
    Send("{a up}")
    MouseMove(A_ScreenWidth/2, A_ScreenHeight/2, 15)
    Click("WheelUp", 10)
    MouseMove(A_ScreenWidth/2, A_ScreenHeight/2.5, 15)
    Click("L")
}

F1::
{
    loop
    {
        setupSpotAndDig
        Sleep(1000)
        FD
        Sleep(2000)
        setupSpotAndDig
        Sleep(1000)
        SM
        Sleep(2000)
    }
    
}
g::
{
    ;MouseGetPos(&x, &y)
    ;OutputDebug(A_ScreenWidth/x ', ' A_ScreenHeight/y)
}
k::Reload