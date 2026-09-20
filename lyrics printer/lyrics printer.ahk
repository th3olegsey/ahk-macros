#Requires AutoHotkey v2.0
SendMode("Event")
*^l:: ;ctrl + l
{
    lyrics := FileRead("lyrics.txt") ;Reads .txt file
    lyrics_array := StrSplit(lyrics, "`n") ;Splits 1 massive sting into arrays
    loop lyrics_array.Length ; start loop
    {
        text := SubStr(lyrics_array[A_Index], 1, StrLen(lyrics_array[A_Index])-1)
        Send("{Raw}/")
        Sleep 100
        A_Clipboard := text
        Send("{Ctrl down}{v}{Ctrl up}")
        ;Send("{Raw}" text) ;Print string
        Sleep 100
        Send("{Enter}")
        Sleep(100)
        ;Sleep(StrLen(lyrics_array[A_Index])*100) ;wait
    }
}
*^k::Reload()