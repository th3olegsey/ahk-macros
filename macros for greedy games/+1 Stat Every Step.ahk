#Requires AutoHotkey v2.0
rbxclick()
{
    MouseGetPos(&mouseX, &mouseY)
    loop 5
    {
        MouseMove(1, 0, 1, "R")
    }
    Click()
    MouseMove(mouseX, mouseY)
    Sleep(10)
}
allstatsup(loops)
{
    loop loops
    {
        MouseMove(78, 934)
        rbxclick()
        MouseMove(81, 986)
        rbxclick()
        MouseMove(81, 1041)
        rbxclick()
    }
    
}
autoclickerIsActive := -1
F1::
{
    global autoclickerIsActive *= -1
}
loop
{
    if(autoclickerIsActive == 1)
    {
        allstatsup(1)
    }
}