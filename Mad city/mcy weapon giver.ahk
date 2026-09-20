#Requires AutoHotkey v2.0
^g:: ; ctrl+g to start
{
    delay := 10 ; in seconds
    weapons := ["duck", "m1014", "deagle", "awp"] ; list of weapons
    loop 1
    {
        loop weapons.Length ; Gives weapons
        {
            Send("{Raw}/") ; Open chat
            Sleep(200)
            SendEvent("{Raw}/wp @a " weapons[A_Index]) ;command
            Sleep(300)
            Send("{Enter}")
            Sleep(300)
        }
        Sleep(delay*1000)
    }
}
^k::ExitApp ;ctrl+k to stop 