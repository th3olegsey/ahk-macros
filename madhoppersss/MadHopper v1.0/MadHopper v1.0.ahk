#Requires AutoHotkey v2.0
Run("getservers.py")
ids_array := []
selectedServer := 1
http := ComObject("WinHttp.WinHttpRequest.5.1")                    ;#gpt
Sleep(1500)
updateServers(*){
    if(ids_array.Length >= 1){
        OutputDebug("Found servers in the ids_array! Cleaning...")
        selectedServer := 1
        loop ids_array.Length{
            ids_array.Pop
        }
    }
    http.Open("GET", "http://127.0.0.1:5000/server_ids", false)    ;#############
    http.Send()                                                    ;#ChatGPT code
    json := http.ResponseText                                      ;#############

    json_dirt_array := StrSplit(SubStr(json, 2, -2), ",")
    loop json_dirt_array.Length{
        ids_array.Push(SubStr(json_dirt_array[A_Index], 2, -1))
    }
    global serversOnline := ids_array.Length
    serversOnlineTxt.Text := "Servers online: " ids_array.Length
    global selectedServer
    firstSelServ := StrSplit(ids_array[1], "-")
    selectedServerTxt.Text := "Selected server: " selectedServer " / " ids_array.Length ", " firstSelServ[2] "-" firstSelServ[3]

    loop ids_array.Length{ ;Debug
        OutputDebug(ids_array[A_Index])
    }
    OutputDebug("Succesfully updated servers: " serversOnline)

}
prevSer(*){
    selectedServer := selectedServer - 1
    if(selectedServer < 1){
        selectedServer := ids_array.Length
    }
    global selectedServer
    shortSelSer := StrSplit(ids_array[selectedServer], "-")
    selectedServerTxt.Text := "Selected server: " selectedServer " / " ids_array.Length ", " shortSelSer[2] "-" shortSelSer[3]
    if(autojoinChk.Value = 1){
        rejoin
    }
}
rejoin(*){
    shortSelSer := StrSplit(ids_array[selectedServer], "-")
    currentServerTxt.Text := "Current server: " shortSelSer[2] "-" shortSelSer[3]
    Run("roblox://placeId=1224212277&gameInstanceId=" ids_array[selectedServer])
}
nextSer(*){
    selectedServer := selectedServer + 1
    if(selectedServer > ids_array.Length){
        selectedServer := 1
    }
    global selectedServer
    shortSelSer := StrSplit(ids_array[selectedServer], "-")
    selectedServerTxt.Text := "Selected server: " selectedServer " / " ids_array.Length ", " shortSelSer[2] "-" shortSelSer[3]
    if(autojoinChk.Value = 1){
        rejoin
    }
}
invite(*){
    A_Clipboard := "roblox://placeId=1224212277&gameInstanceId=" ids_array[selectedServer] "\n-# Copy and paste this link in ur browser to join"
}
madHopperGui := Gui("AlwaysOnTop", "MadHopperV1.0")
; - - - = = = # # # G U I # # # = = = - - -
guitabs := madHopperGui.AddTab3("", ["Main", "Setting"])
serversOnlineTxt := madHopperGui.AddText("W85", "Servers online: --")
serversOnlineTxt.GetPos(&Xsot, &Ysot, &Wsot, &Hsot)

currentServerTxt := madHopperGui.AddText("X" Xsot " Y" Ysot+Hsot " W125", "Current server: -")
currentServerTxt.GetPos(&Xcst, &Ycst, &Wcst, &Hcst)

selectedServerTxt := madHopperGui.AddText("X" Xcst " Y" Ycst+Hcst " W179", "Selected server: 0 / 0, Loading")
selectedServerTxt.GetPos(&Xsst, &Ysst, &Wsst, &Hsst)
; B U T T O N S
prevSerBtn := madHopperGui.AddButton("W50", "<")
prevSerBtn.GetPos(&X, &Y, &W, &H)

rejoinBtn := madHopperGui.AddButton("X" X+W " Y" Y " W120", "(Re)Join")
rejoinBtn.GetPos(&X, &Y, &W, &H)

nextSerBtn := madHopperGui.AddButton("X" X+W " Y" Y " W50", ">")
updateServersBtn := madHopperGui.AddButton("X" Xsot+Wsot+38 " Y" Ysot-3, "Update server list")

inviteBtn := madHopperGui.AddButton("X" Xsst+Wsst " Y" Ysst-5, "Invite")

prevSerBtn.OnEvent("Click", prevSer)
rejoinBtn.OnEvent("Click", rejoin)
nextSerBtn.OnEvent("Click", nextSer)
updateServersBtn.OnEvent("Click", updateServers)
inviteBtn.OnEvent("Click", invite)
; C H E C K E R S
guitabs.UseTab(2)
autojoinChk := madHopperGui.AddCheckbox("", "Auto-join")

madHopperGui.Show()

WinSetTransparent(100, "MadHopper")
updateServers