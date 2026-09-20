#Requires AutoHotkey v2.0
psLink := 'https://www.roblox.com/share?code=27fbf668863ee843b58622e5d8741ee0&type=Server'
ui := Gui('AlwaysOnTop')
ui.AddTab3(,['Worlds grind', 'Raids'])

setupMessageWG_text := ui.AddText('', 'Setup your message:')

world := ui.AddDropDownList('Choose1', ['World','grasslands', 'desert', 'swamp', 'jungle', 'frost forest', 'volcano'])
mode := ui.AddDropDownList('Choose1', ['Mode','normal', 'hard', 'nightmare'])

modifiers_text := ui.AddText('', 'Choise modifiers:')

pv_mod := ui.AddCheckbox('','Pov You')
ds_mod := ui.AddCheckbox('','Dizzy Swarm')
oh_mod := ui.AddCheckbox('','One Handed')
sr_mod := ui.AddCheckbox('','Supdoggy`'s Revenge')
hs_mod := ui.AddCheckbox('','Half Strength')
dt_mod := ui.AddCheckbox('','Double Trouble')
mog_mod := ui.AddCheckbox('','Made of Glass')
bb_mod := ui.AddCheckbox('','Barebones')
edit_message_text := ui.AddText('','Edit your message. Send something before editing!')

wg1of4btn := ui.AddButton('','1/4')
wg1of4btn.OnEvent('Click', btnfunc)
wg2of4btn := ui.AddButton('X+M','2/4')
wg2of4btn.OnEvent('Click', btnfunc)
wg3of4btn := ui.AddButton('X+M','3/4')
wg3of4btn.OnEvent('Click', btnfunc)
wg4of4btn := ui.AddButton('X+M','4/4')
wg4of4btn.OnEvent('Click', btnfunc)
wgClosedbtn := ui.AddButton('X+M','Closed')
wgClosedbtn.OnEvent('Click', btnfunc)
btnfunc(guiCtrl, Info){
    if world.Text == 'grasslands'{
        world_message := '[0;1;32mgrasslands[0m'
    }else If world.Text == 'desert'{
        world_message := '[0;1;33mdesert[0m'
    }else if world.Text == 'swamp'{
        world_message := '[0;1;32mswamp[0m'
    }else if world.Text == 'jungle'{
        world_message := '[0;1;32mjungle[0m'
    }else if world.Text == 'frost forest'{
        world_message := '[0;1;32mfrost [0;34mforest[0m'
    }else if world.Text == 'volcano'{
        world_message := '[0;1;31mvolcano[0m'
    }

    if mode.Text == 'normal'{
        mode_message := '[1;32mnormal[0m'
    } else if mode.Text == 'hard'{
        mode_message := '[1;31mhard[0m'
    } else if mode.Text == 'nightmare'{
        mode_message := '[1;35mnightmare[0m'
    }

    modifiers := []
    if pv_mod.Value{
        modifiers.Push('• Pov You`n')
    }
    if ds_mod.Value{
        modifiers.Push('• Dizzy Swarm`n')
    }
    if oh_mod.Value{
        modifiers.Push('• One Handed`n')
    }
    if sr_mod.Value{
        modifiers.Push('• Supdoggy`'s Revenge`n')
    }
    if hs_mod.Value{
        modifiers.Push('• Half Strength`n')
    }
    if dt_mod.Value{
        modifiers.Push('• Double Trouble`n')
    }
    if mog_mod.Value{
        modifiers.Push('• Made of Glass`n')
    }
    if bb_mod.Value{
        modifiers.Push('• Barebones`n')
    }

    if guiCtrl == wg1of4btn{
        progres := '[0;33;40m[[32m@@@@[31m@@@@[33m1/4[31m@@@@@@@@[33m]'
    } else if guiCtrl == wg2of4btn{
        progres := '[0;33;40m[[32m@@@@@@@@[33m2/4[31m@@@@@@@@[33m]'
    } else if guiCtrl == wg3of4btn{
        progres := '[0;33;40m[[32m@@@@@@@@[33m3/4[32m@@@@[31m@@@@[33m]'
    } else if guiCtrl == wg4of4btn{
        progres := '[0;33;40m[[32m@@@@@@@@[33m4/4[32m@@@@@@@@[33m]'
    } else if guiCtrl == wgClosedbtn{
        progres := '[0;33;40m[closed]' ; closed
    }
    main_color_format := '[0;1;34m'
    modifiers_color_formating := '[0;1;32m'
    first := 'Hosting'
    second := 'with following modifiers:`n'
    modifiers_message := ''
    loop modifiers.Length{
        modifiers_message := modifiers_message modifiers[A_Index]
    }
    message := '``````ansi`n' main_color_format '' first ' ' world_message ' ' mode_message ' ' main_color_format '' second '' modifiers_color_formating '' modifiers_message '' progres '`n```````n' psLink
    A_Clipboard := message
    WinActivate('ahk_exe Discord.exe')
    Sleep(50)
    Send('{Up}')
    Sleep(50)
    Send('{Ctrl down}{a}{Ctrl up}{Backspace}')
    Sleep(50)
    Send('{Ctrl down}{v}{Ctrl up}{Enter}')
}
ui.Show