#Requires AutoHotkey v2.0
CoordMode('Mouse','Screen')
offset := 10
step := 1
if FileExist('strategy.txt'){
    __ := FileRead('strategy.txt')
}else{
    FileAppend('','strategy.txt')
}
_ := StrSplit(__, '`n')

followCursor(){
    MouseGetPos(&X, &Y)
    stratGui.Move(X+offset, Y+offset)
}

stratGui := Gui('AlwaysOnTop -Border', 'Strategy')      ;####################
text := stratGui.AddText('w300 h30', '1. ' _[1])        ;# Creating the GUI #
text.SetFont('S10')                                     ;####################

MouseGetPos(&X, &Y)                        ;#######################
stratGui.Show('x' x+offset ' y' y+offset ' NoActivate')  ;# Showing the GUI and #
SetTimer(followCursor, 10)                 ;#  updating position  #
WinSetTransparent(100, 'Strategy')         ;#######################

~XButton1::{
    global step
    strategy := FileRead('strategy.txt')
    stratSteps := StrSplit(strategy,'`n')
    if step < stratSteps.Length{
        step := step + 1
    }
    text.Text := step '. ' stratSteps[step]
}
~XButton2::{
    global step
    strategy := FileRead('strategy.txt')
    stratSteps := StrSplit(strategy,'`n')
    if step > 1{
        step := step - 1
    }
    text.Text := step '. ' stratSteps[step]
}
;k::ExitApp()