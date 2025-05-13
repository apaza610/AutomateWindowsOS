; #Requires AutoHotkey v2.0
; #SingleInstance Force

global pressCount := 0
global lastPressTime := A_TickCount
global maxInterval := 50  ; Maximum time (in milliseconds) between presses

~F13::                       ; Detectando la tecla 000 mapeada a F13 en mi numpad extra
{
    global lastPressTime
    global pressCount
    currentTime := A_TickCount

    if (currentTime - lastPressTime < maxInterval)
        pressCount += 1
    else
        pressCount := 1
    
    lastPressTime := currentTime

    if (pressCount >= 3)
    {
        ; MsgBox "F4 pressed 3 times quickly!"
        pressCount := 0  ; Reset the counter
        Cadena := FileRead("memoria.txt")
        SendInput(Cadena)
    }
}

^F13::{
    nuevoHotstring := InputBox("Enter new hotstring:", "Custom Hotstring","W350 H90")
    
    FileObj := FileOpen(A_ScriptDir "\memoria.txt", "w")
    FileObj.Write(nuevoHotstring.Value)
    FileObj.Close()
}