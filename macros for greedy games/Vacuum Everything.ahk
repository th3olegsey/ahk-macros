#Requires AutoHotkey v2.0
rbxclick()
{
    MouseGetPos(&mouseX ,&mouseY)
    loop 5
    {
        MouseMove(1, 0, 1, "R")
    }
    Click()
    Sleep(100)
    MouseMove(A_ScreenWidth*.5, A_ScreenHeight*.6)
    loop 5
    {
        MouseMove(0, 1, 1, "R")
    }
}
surface()
{
    MouseMove(A_ScreenWidth * 0.97, A_ScreenHeight * 0.03)
    rbxclick()
    Sleep(100)
}
sell()
{
    MouseMove(A_ScreenWidth * 0.5, A_ScreenHeight * 0.92)
    rbxclick()
    Sleep(100)
}
^g::
{
    OutputDebug("g")
    loop
    {
        if(PixelSearch(&g, &gg, A_ScreenWidth * 0.74 + 10, A_ScreenHeight * 0.92 + 10, A_ScreenWidth * 0.74 - 10, A_ScreenHeight * 0.92 - 10, "0x81d46a"))
        {
            sell()
        }
    }
}
^h::
{
    OutputDebug("h")
    loop
    {
        surface
        Sleep 10000
    }
}
z::surface
^k::ExitApp()
;For debugging
f::MouseMove(A_ScreenWidth * 0.74, A_ScreenHeight * 0.92)