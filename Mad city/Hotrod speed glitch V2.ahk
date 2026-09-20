#Requires AutoHotkey v2.0
ExitApp_1(a,b)
{
    ExitApp()
}
mygui := Gui("MinSize200x100")
text := mygui.AddText("", "Нажми H(англ) чтобы активировать")
Button := mygui.AddButton("w300", "Закрыть макрос")
Button.OnEvent("Click", ExitApp_1)
mygui.Show
h::
{
    loop 1000
    {
        Send("{Shift}")
    }
}