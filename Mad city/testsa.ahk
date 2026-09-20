#Requires AutoHotkey v2.0
^g:: ; ctrl+g to start
{
    delay := 5 ; in seconds
    defaultWait := 300
    weapons := ["m4a1", "stinger", "m1014", "deagle", "grenade"] ; list of weapons
    cmd(cmd)
    {
        Send("{Raw}/")
	    Sleep(defaultWait)
	    SendEvent("{Raw}" cmd) ; TPs all that are on the cop team that want to respawn
        Sleep(defaultWait)
        Send("{Enter}")
    }
    coords := [
        "bank",
        "[45,50,300]",
        "[700,50,620]",
        "schwiftybuilding",
        "neighborhood",
	    "club",
	    "casino",
	    "airport",
	    "[485,50,-420]"
    ] ; Array of coords (as strings)
    loop
    {
        ; pick random coord
        randIndex := Random(1, coords.Length)
        randCoord := coords[randIndex]
        cmd("/tp @police " randCoord)
        cmd("/changeteam @police neutral")
        loop weapons.Length ; Gives weapons
        {
            cmd("/wp @neutral " weapons[A_Index])
        }
        Sleep(delay*1000)
    }
}
^k::ExitApp ;ctrl+k to stop 