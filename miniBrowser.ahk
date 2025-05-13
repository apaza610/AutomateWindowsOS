; #Requires AutoHotkey v2.0
; #SingleInstance Force

MiniBrowser := Gui()
MiniBrowser.Opt("-Caption")
MiniBrowser.BackColor := "393939"

WB := MiniBrowser.Add("ActiveX", "w500 h600", "Shell.Explorer").Value  ; The last parameter is the name of the ActiveX component.

~+F20:: {
    static guiVisible := false
    guiVisible := !guiVisible  ; Toggle state
    global mouseLocCanChange := false           ; evitar centrear el mouse

    elPath := "file:///"

    if (WinActive("ahk_exe ZBrush.exe")){        
        elPath := elPath . "E:\misapps\AutomateWindowsOS\media\TecladoZBrush.svg"
    }else{
        elPath := elPath . "E:\misapps\AutomateWindowsOS\media\TecladoGral.svg"
    }
    
    if (guiVisible) {
        MiniBrowser.Show("x0 y1200 w520 h620")
        WB.Navigate(elPath)  ; This is specific to the web browser control.
    } else {
        MiniBrowser.Hide()
    }
    ; MiniBrowser.Show("Hide")  ; Start hidden
}

; Optional: Close GUI with Escape
; MiniBrowser.OnEvent("Close", (*) => ExitApp())

