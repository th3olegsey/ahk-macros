#Requires AutoHotkey v2.0
text := "ya was vseh ebal ezz"
words := ["a","b","c","d","e","f","g"] ;,"h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
numbers := [0,1,2,3,4,5,6,7,8,9]
Insert::
{
    loop 1{
        for W IN words{
            for N IN numbers{
                A_Clipboard := text " " W N
                Send("{Ctrl down}{v}{Ctrl up}")
                Sleep(750)
                Send("{Enter}")
            }
        }
    }
}
^k::ExitApp