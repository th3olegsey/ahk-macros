;data := FileRead('1.txt', 'UTF-8')
;A_Clipboard := data
ui := Gui('AlwaysOnTop')
worldfarmtext := ui.AddText('h20 w150', 'World farming')
worldfarmtext.SetFont('s12')

wf_1of4 := ui.AddButton('','1/4')
wf_1of4.GetPos(&X, &Y, &Width, &Height)
wf_1of4.OnEvent('Click', btnfunc)

wf_2of4 := ui.AddButton('x' X+Width ' y' Y,'2/4')
wf_2of4.GetPos(&X, &Y, &Width, &Height)
wf_2of4.OnEvent('Click', btnfunc)

wf_3of4 := ui.AddButton('x' X+Width ' y' Y,'3/4')
wf_3of4.GetPos(&X, &Y, &Width, &Height)
wf_3of4.OnEvent('Click', btnfunc)

wf_4of4 := ui.AddButton('x' X+Width ' y' Y,'4/4')
wf_4of4.GetPos(&X, &Y, &Width, &Height)
wf_4of4.OnEvent('Click', btnfunc)

ui.Show()
;Fucktions
btnfunc(GuiCtrl, Info){
    if wf_1of4 == GuiCtrl{
        data := FileRead('1.txt', 'UTF-8')
    }
    if wf_2of4 == GuiCtrl{
        data := FileRead('2.txt', 'UTF-8')
    }
    if wf_3of4 == GuiCtrl{
        data := FileRead('3.txt', 'UTF-8')
    }
    if wf_4of4 == GuiCtrl{
        data := FileRead('4.txt', 'UTF-8')
    }
    A_Clipboard := data
    WinActivate('ahk_exe Discord.exe')
    Send('{Up}{Ctrl down}{a}{Ctrl up}{Backspace}{Ctrl down}{v}{Ctrl up}{Enter}')
}