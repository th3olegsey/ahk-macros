#Requires AutoHotkey v2.0
SendMode("Event")
quickHeal(){
    Send("{3}{Click}")
}
space::{
    Send("{1}{e}{2}{1}{e}")
    quickHeal
}
r::{
    quickHeal
}
f::{
    loop 1{
        Send("{7}{Click}")
    }   
}