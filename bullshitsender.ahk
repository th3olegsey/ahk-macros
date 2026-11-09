#Requires AutoHotkey v2.0
SendMode('Event')
sendsmth(text){
    Send('/')
    Sleep 50
    Send('{raw}' text)
    Sleep 50
    Send('{Enter}')
    Sleep 50
}
butttonfunc(guiCtrl, Info){
    WinActivate('Roblox')
    if guiCtrl == brown_button{
        word_list := ['Near', 'Internet', 'Good', 'Game', 'Eraser', 'Rate']
        for word in word_list{
            sendsmth(word)
        }
    }
}
mygui := Gui('AlwaysOnTop')
brown_button := mygui.AddButton('w200',"Brown")
brown_button.OnEvent('Click', butttonfunc)
mygui.Show()