; #Requires AutoHotkey v2.0
; #SingleInstance Force

; Set up window activation detection
DllCall("RegisterShellHookWindow", "UInt", A_ScriptHwnd)
msgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")
OnMessage(msgNum, WindowChanged)

global mouseLocCanChange := true

; Store previous active window ID
previousHwnd := 0

WindowChanged(wParam, lParam, *) {
    global previousHwnd
    static SHELLHOOK_WINDOWACTIVATED := 0x8004
    
    if (wParam = SHELLHOOK_WINDOWACTIVATED) {
        if (lParam != previousHwnd) {
            previousHwnd := lParam
             ; si usuario NO esta presionando LMB && tampoco esta usando ShareX
            if !GetKeyState("LButton", "P") && !GetKeyState("RButton", "P") && !WinActive("ahk_exe ShareX.exe") && !WinActive("ahk_exe kando.exe"){
                Sleep(200)
                SetTimer(moverCursorAlCentro, -100) ; Small delay for stability
            }
        }
    }
}

moverCursorAlCentro(){
    global mouseLocCanChange
    if mouseLocCanChange {
        try {
            CoordMode("Mouse", "Window")
            Sleep(100)
            WinGetPos(&OutX, &OutY, &OutWidth, &OutHeight, "A")
            Sleep(100)
            MouseMove(OutWidth/2, OutHeight/2, 20)
        } catch Error as e {
            ToolTip("No hay selected app")
            SetTimer(ToolTip, -2500)
        }
    }
    mouseLocCanChange := true
}

; MoveToCenter() {
;     ; Get screen dimensions
;     static centerX := A_ScreenWidth // 2
;     static centerY := A_ScreenHeight // 2
    
;     ; Move mouse smoothly to center
;     MouseMove centerX, centerY, 0
; }

; Exit script with Esc
; Esc::ExitApp

