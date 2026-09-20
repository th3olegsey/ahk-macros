#Requires AutoHotkey v2.0
Boss := "th"

Players := 2
hpPerPlayer := 1200
Speed := 42
BossWeapon := ["HandBRRT", "boss", "AdminMin", "AdminStinger"]
AttackersWeapon := ["m4a1", "m1014", "deagle"]

eC(cmd)
{
    A_Clipboard := cmd
    Send("{Raw}/") ; Open chat
    Sleep(100)
    Send("{Ctrl down}{v}{Ctrl up}") ;command
    Sleep(35)
    Send("{Enter}")
}

RControl::
{
    eC("/changeteam @a h")
    eC("/changeteam " boss " c")
    eC("/ws " Boss " " Speed)
    loop BossWeapon.Length
    {
        eC("/wp " boss " " BossWeapon[A_Index])
    }
    loop floor((Players-1)*hpPerPlayer/100)-1   ;( base health 100 )|( x armor )
    {
        eC("/armor " Boss)
    }
    eC("/tp " Boss " boss")
}
RAlt::
{
    eC("/changeteam @prisoners police")
    loop AttackersWeapon.Length
    {
        eC("/wp @police " AttackersWeapon[A_Index])
    }
    eC("/tp @police boss")
    eC("/changeteam @police h")
}
^k::ExitApp 