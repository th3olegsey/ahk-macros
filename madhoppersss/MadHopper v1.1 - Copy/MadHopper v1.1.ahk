#Requires AutoHotkey v2.0
Jxon_Load(&src, args*) {
	key := "", is_key := false
	stack := [ tree := [] ]
	next := '"{[01234567890-tfn'
	pos := 0
	
	while ( (ch := SubStr(src, ++pos, 1)) != "" ) {
		if InStr(" `t`n`r", ch)
			continue
		if !InStr(next, ch, true) {
			testArr := StrSplit(SubStr(src, 1, pos), "`n")
			
			ln := testArr.Length
			col := pos - InStr(src, "`n",, -(StrLen(src)-pos+1))

			msg := Format("{}: line {} col {} (char {})"
			,   (next == "")      ? ["Extra data", ch := SubStr(src, pos)][1]
			  : (next == "'")     ? "Unterminated string starting at"
			  : (next == "\")     ? "Invalid \escape"
			  : (next == ":")     ? "Expecting ':' delimiter"
			  : (next == '"')     ? "Expecting object key enclosed in double quotes"
			  : (next == '"}')    ? "Expecting object key enclosed in double quotes or object closing '}'"
			  : (next == ",}")    ? "Expecting ',' delimiter or object closing '}'"
			  : (next == ",]")    ? "Expecting ',' delimiter or array closing ']'"
			  : [ "Expecting JSON value(string, number, [true, false, null], object or array)"
			    , ch := SubStr(src, pos, (SubStr(src, pos)~="[\]\},\s]|$")-1) ][1]
			, ln, col, pos)

			throw Error(msg, -1, ch)
		}
		
		obj := stack[1]
        is_array := (obj is Array)
		
		if i := InStr("{[", ch) { ; start new object / map?
			val := (i = 1) ? Map() : Array()	; ahk v2
			
			is_array ? obj.Push(val) : obj[key] := val
			stack.InsertAt(1,val)
			
			next := '"' ((is_key := (ch == "{")) ? "}" : "{[]0123456789-tfn")
		} else if InStr("}]", ch) {
			stack.RemoveAt(1)
            next := (stack[1]==tree) ? "" : (stack[1] is Array) ? ",]" : ",}"
		} else if InStr(",:", ch) {
			is_key := (!is_array && ch == ",")
			next := is_key ? '"' : '"{[0123456789-tfn'
		} else { ; string | number | true | false | null
			if (ch == '"') { ; string
				i := pos
				while i := InStr(src, '"',, i+1) {
					val := StrReplace(SubStr(src, pos+1, i-pos-1), "\\", "\u005C")
					if (SubStr(val, -1) != "\")
						break
				}
				if !i ? (pos--, next := "'") : 0
					continue

				pos := i ; update pos

				val := StrReplace(val, "\/", "/")
				val := StrReplace(val, '\"', '"')
				, val := StrReplace(val, "\b", "`b")
				, val := StrReplace(val, "\f", "`f")
				, val := StrReplace(val, "\n", "`n")
				, val := StrReplace(val, "\r", "`r")
				, val := StrReplace(val, "\t", "`t")

				i := 0
				while i := InStr(val, "\",, i+1) {
					if (SubStr(val, i+1, 1) != "u") ? (pos -= StrLen(SubStr(val, i)), next := "\") : 0
						continue 2

					xxxx := Abs("0x" . SubStr(val, i+2, 4)) ; \uXXXX - JSON unicode escape sequence
					if (xxxx < 0x100)
						val := SubStr(val, 1, i-1) . Chr(xxxx) . SubStr(val, i+6)
				}
				
				if is_key {
					key := val, next := ":"
					continue
				}
			} else { ; number | true | false | null
				val := SubStr(src, pos, i := RegExMatch(src, "[\]\},\s]|$",, pos)-pos)
				
                if IsInteger(val)
                    val += 0
                else if IsFloat(val)
                    val += 0
                else if (val == "true" || val == "false")
                    val := (val == "true")
                else if (val == "null")
                    val := ""
                else if is_key {
                    pos--, next := "#"
                    continue
                }
				
				pos += i-1
			}
			
			is_array ? obj.Push(val) : obj[key] := val
			next := obj == tree ? "" : is_array ? ",]" : ",}"
		}
	}
	
	return tree[1]
}
Jxon_Dump(obj, indent:="", lvl:=1) {
	if IsObject(obj) {
        If !(obj is Array || obj is Map || obj is String || obj is Number)
			throw Error("Object type not supported.", -1, Format("<Object at 0x{:p}>", ObjPtr(obj)))
		
		if IsInteger(indent)
		{
			if (indent < 0)
				throw Error("Indent parameter must be a postive integer.", -1, indent)
			spaces := indent, indent := ""
			
			Loop spaces ; ===> changed
				indent .= " "
		}
		indt := ""
		
		Loop indent ? lvl : 0
			indt .= indent
        
        is_array := (obj is Array)
        
		lvl += 1, out := "" ; Make #Warn happy
		for k, v in obj {
			if IsObject(k) || (k == "")
				throw Error("Invalid object key.", -1, k ? Format("<Object at 0x{:p}>", ObjPtr(obj)) : "<blank>")
			
			if !is_array ;// key ; ObjGetCapacity([k], 1)
				out .= (ObjGetCapacity([k]) ? Jxon_Dump(k) : escape_str(k)) (indent ? ": " : ":") ; token + padding
			
			out .= Jxon_Dump(v, indent, lvl) ; value
				.  ( indent ? ",`n" . indt : "," ) ; token + indent
		}

		if (out != "") {
			out := Trim(out, ",`n" . indent)
			if (indent != "")
				out := "`n" . indt . out . "`n" . SubStr(indt, StrLen(indent)+1)
		}
		
		return is_array ? "[" . out . "]" : "{" . out . "}"
	
    } Else If (obj is Number)
        return obj
    
    Else ; String
        return escape_str(obj)
	
    escape_str(obj) {
        obj := StrReplace(obj,"\","\\")
        obj := StrReplace(obj,"`t","\t")
        obj := StrReplace(obj,"`r","\r")
        obj := StrReplace(obj,"`n","\n")
        obj := StrReplace(obj,"`b","\b")
        obj := StrReplace(obj,"`f","\f")
        obj := StrReplace(obj,"/","\/")
        obj := StrReplace(obj,'"','\"')
        
        return '"' obj '"'
    }
}
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