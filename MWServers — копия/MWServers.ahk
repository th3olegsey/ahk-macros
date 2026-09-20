#Requires AutoHotkey v2.0
#Include libs\Jxon.ahk

global Places := Map(
"Normal", "91355853256093",
"Pro", "91355853256093",
"Elite", "91355853256093"
)

global PLACE_ID := Places["Normal"]
global baseUrl := "https://games.roblox.com/v1/games/"

http := ComObject("WinHttp.WinHttpRequest.5.1")
currentServer := ""

staticServers := Map(
"Normal", [
{name: "Сергей", place: "91355853256093", code: "57164210841878498111730906349530"},
{name: "Леша", place: "91355853256093", code: "90019469343601177382903305522678"}
],
"Pro", [
{name: "Сергей", place: "91355853256093", code: "57164210841878498111730906349530"},
{name: "Леша", place: "91355853256093", code: "90019469343601177382903305522678"}
],
"Elite", [
{name: "Сергей", place: "91355853256093", code: "57164210841878498111730906349530"},
{name: "Леша", place: "91355853256093", code: "90019469343601177382903305522678"}
]
)

; - - - = = = # # # C O M P A C T G U I # # # = = = - - -
madHopperGui := Gui("AlwaysOnTop -MaximizeBox -MinimizeBox", "MWServers")
madHopperGui.SetFont("s9", "Segoe UI")

madHopperGuiTabs := madHopperGui.AddTab3("w175 h215", ["Main", "VIP"])

; --- ВКЛАДКА 1: MAIN ---
madHopperGuiTabs.UseTab(1)

mainRadio1 := madHopperGui.AddRadio("x15 y35 Checked", "Norm")
mainRadio2 := madHopperGui.AddRadio("yp x+8", "Pro")
mainRadio3 := madHopperGui.AddRadio("yp x+8", "Elite")

mainRadio1.OnEvent("Click", SwitchMainCategory)
mainRadio2.OnEvent("Click", SwitchMainCategory)
mainRadio3.OnEvent("Click", SwitchMainCategory)

LV := madHopperGui.Add("ListView", "x12 y60 w160 r5 -Hdr -Multi", ["Long id", "Server", "Plrs"])
LV.ModifyCol(1, 0)
LV.ModifyCol(2, 105)
LV.ModifyCol(3, 35)

updateServersBtn := madHopperGui.AddButton("x12 y158 w78 h22", "Update")
rejoinBtn := madHopperGui.AddButton("x+4 yp w78 h22", "Rejoin")
inviteBtn := madHopperGui.AddButton("x12 y+3 w78 h22", "Copy ID")
joinClipboardBtn := madHopperGui.AddButton("x+4 yp w78 h22", "Join ID")

serversOnlineText := madHopperGui.AddText("x14 y207 w160 cGray", "Online: -")

; --- ВКЛАДКА 2: VIP SERVERS ---
madHopperGuiTabs.UseTab(2)

categoryRadio1 := madHopperGui.AddRadio("x15 y35 Checked", "Norm")
categoryRadio2 := madHopperGui.AddRadio("yp x+8", "Pro")
categoryRadio3 := madHopperGui.AddRadio("yp x+8", "Elite")

categoryRadio1.OnEvent("Click", SwitchCategory)
categoryRadio2.OnEvent("Click", SwitchCategory)
categoryRadio3.OnEvent("Click", SwitchCategory)

LVPs := madHopperGui.Add("ListView", "x12 y60 w160 r7.3 -Hdr -Multi", ["Link code", "Name", "PlaceId"])
LVPs.ModifyCol(1, 0)
LVPs.ModifyCol(2, 140)
LVPs.ModifyCol(3, 0)

DisplayCategory("Normal")

; Назначение событий
LV.OnEvent("DoubleClick", LV_DoubleClick)
LV.OnEvent("Click", quickJoin)
updateServersBtn.OnEvent("Click", updateServers)
inviteBtn.OnEvent("Click", copyJobId)
rejoinBtn.OnEvent("Click", rejoin)
joinClipboardBtn.OnEvent("Click", joinFromClipboard)
LVPs.OnEvent("DoubleClick", LVPs_DoubleClick)

madHopperGui.Show("w185 h230")
WinSetTransparent(110, "MWServers")

; --- ФУНКЦИИ И ОБРАБОТЧИКИ ---

SwitchMainCategory(Ctrl, *){
global PLACE_ID
targetMode := (Ctrl.Text = "Norm") ? "Normal" : Ctrl.Text
PLACE_ID := Places[targetMode]
updateServers()
}

SwitchCategory(Ctrl, *){
targetMode := (Ctrl.Text = "Norm") ? "Normal" : Ctrl.Text
DisplayCategory(targetMode)
}

DisplayCategory(catName) {
LVPs.Delete()
for ps in staticServers[catName] {
LVPs.Add(, ps.code, ps.name, ps.place)
}
}

LV_DoubleClick(LV, RowNumber){
RowText := LV.GetText(RowNumber, 1)
if (RowText = "") {
return
}
global currentServer := RowText
Run("roblox://placeId=" PLACE_ID "&gameInstanceId=" RowText)
serversOnlineText.Text := "Joined active server"
}

updateServers(*){
try {
if (LV.GetCount != 0)
LV.Delete()

serversOnlineText.Text := "Searching..."

cursor := ""
visibleServersCount := 0
maxPagesToSearch := 4
currentPage := 0

loop {
currentPage += 1
currentApiUrl := baseUrl . PLACE_ID . "/servers/Public?limit=100"
if (cursor != "")
currentApiUrl .= "&cursor=" . cursor

http.Open("GET", currentApiUrl, false)
http.Send()
apicall := http.ResponseText

if (apicall == "") {
serversOnlineText.Text := "Status: API Error"
return
}

root := Jxon_Load(&apicall)
if (root.Has("errors")) {
serversOnlineText.Text := "Status: API Block"
return
}

serversData := root["data"]
for s in serversData {
if (s["playing"] >= s["maxPlayers"])
continue

TS := StrSplit(s["id"], "-")
displayId := (TS.Length >= 3) ? TS[2] "-" TS[3] : "Unknown"

LV.Add(, s["id"], displayId, s["playing"] "/" s["maxPlayers"])
visibleServersCount += 1

if (visibleServersCount >= 50)
break 2
}

if (root.Has("nextPageCursor") && root["nextPageCursor"] != "" && root["nextPageCursor"] != json_null() && currentPage < maxPagesToSearch)
cursor := root["nextPageCursor"]
else
break
}

serversOnlineText.Text := "Available: " visibleServersCount
}
catch {
serversOnlineText.Text := "Status: Network Error"
}
}

json_null() {
return ""
}

copyJobId(*){
if(currentServer){
A_Clipboard := currentServer
serversOnlineText.Text := "ID copied!"
}
}

joinFromClipboard(*){
clipText := Trim(A_Clipboard)
if (clipText = "" || RegExMatch(clipText, "\s")) {
serversOnlineText.Text := "Bad ID in Clipboard"
MsgBox("В буфере обмена нет корректного JobID. Сначала скопируй его!", "Ошибка")
return
}
global currentServer := clipText
Run("roblox://placeId=" PLACE_ID "&gameInstanceId=" clipText)
serversOnlineText.Text := "Joining Custom ID..."
}

quickJoin(LV, RowNumber){
if(GetKeyState("Alt")){
RowText := LV.GetText(RowNumber, 1)
if (RowText = "") {
return
}
global currentServer := RowText
Run("roblox://placeId=" PLACE_ID "&gameInstanceId=" RowText)
}
}

LVPs_DoubleClick(LV, RowNumber){
codeText := LV.GetText(RowNumber, 1)
pIdText := LV.GetText(RowNumber, 3)
if (codeText != "") {
Run("roblox://placeId=" pIdText "&linkCode=" codeText)
}
}

rejoin(*){
if (currentServer != "")
Run("roblox://placeId=" PLACE_ID "&gameInstanceId=" currentServer)
}

updateServers()