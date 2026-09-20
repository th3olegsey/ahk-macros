#Requires AutoHotkey v2.0
#Include libs\Jxon.ahk
PLACE_ID := 1224212277
api := "https://games.roblox.com/v1/games/" PLACE_ID "/servers/Public?limit=100"
http := ComObject("WinHttp.WinHttpRequest.5.1")
currentServer := ""
; - - - = = = # # # G U I # # # = = = - - -
madHopperGui := Gui("AlwaysOnTop", "MadHopperV1.1")
serversOnlineText := madHopperGui.Add("text","w100" ,"Servers online: -")
serversOnlineText.GetPos(&X, &Y, &W, &H)
lastJoinedServer := madHopperGui.Add("text", "Y" Y+H " X" X " w150", "Current server: -")
LV := madHopperGui.Add("ListView", "r4 w157", ["Long id", "№", "Server", "Playing"])
LV.ModifyCol(1, 0)
LVPos := LV.GetPos(&X, &Y, &W, &H)
updateServersBtn := madHopperGui.AddButton("X" X+W " Y" Y-2 " W80" ,"Update")
updSerBtnPos := updateServersBtn.GetPos(&X, &Y, &W, &H)
inviteBtn := madHopperGui.AddButton("X" X " Y" Y+H " W" W, "Copy JobID")
invBtnPos := inviteBtn.GetPos(&X, &Y, &W, &H)
helpBtn := madHopperGui.AddButton("X" X " Y" Y+H " W" W, "Help")

LV.OnEvent("DoubleClick", LV_DoubleClick)
LV.OnEvent("Click", quickJoin)
updateServersBtn.OnEvent("Click", updateServers)
inviteBtn.OnEvent("Click", copyJobId)
helpBtn.OnEvent("Click", callhelp)

madHopperGui.Show()
WinSetTransparent(100, "MadHopper")

LV_DoubleClick(LV, RowNumber){
    RowText := LV.GetText(RowNumber)
    global currentServer := RowText
    Run("roblox://placeId=1224212277&gameInstanceId=" RowText)
    curSer := StrSplit(RowText, "-")
    lastJoinedServer.Text := "Current server: " curSer[2] "-" curSer[3]
}
updateServers(*){
    http.Open("GET", api, false)
    http.Send()
    apiresponse := http.ResponseText
    root := Jxon_Load(&apiresponse)
    if(root.Has("errors")){
        apiErrors := root["errors"]
        return MsgBox("Error: " apiErrors[1]['message'], "API Error")
    }
    global servers := root["data"]
    global serversOnline := servers.Length
    serversOnlineText.Text := "Servers online: " serversonline
    if(LV.GetCount != 0){
        LV.Delete()
    }
    servercount := 1
    for s in servers{
        TS := StrSplit(s["id"], "-")
        LV.Add(, s["id"], servercount, TS[2] "-" TS[3], s["playing"] "/" s["maxPlayers"])
        servercount += 1
    }
    LV.ModifyCol(1, 0)
    LV.ModifyCol(2)
    LV.ModifyCol(3)
    LV.ModifyCol(4, 47)
}
copyJobId(*){
    if(currentServer){
        A_Clipboard := currentServer
    }
}
quickJoin(LV, RowNumber){
    if(GetKeyState("Alt")){
        RowText := LV.GetText(RowNumber)
        global currentServer := RowText
        Run("roblox://placeId=1224212277&gameInstanceId=" RowText)
        curSer := StrSplit(RowText, "-")
        lastJoinedServer.Text := "Current server: " curSer[2] "-" curSer[3]
    }
}
callhelp(*){
    MsgBox("List controls:`nDouble click - join to the server`nAlt+click - quickly join to the server`n`nButtons:`nUpdate - updates the server list`nCopy JobID - copies server ID from 'current server' param`nHelp - calls this gui", "Help")
}
updateServers