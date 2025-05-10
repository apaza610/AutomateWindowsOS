; #Requires AutoHotkey v2.0
; #SingleInstance Force

; Set up window activation detection
DllCall("RegisterShellHookWindow", "UInt", A_ScriptHwnd)
msgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")
OnMessage msgNum, WindowChanged

; Store previous active window ID
previousHwnd := 0

WindowChanged(wParam, lParam, *) {
    global previousHwnd
    static SHELLHOOK_WINDOWACTIVATED := 0x8004
    
    if (wParam = SHELLHOOK_WINDOWACTIVATED) {
        if (lParam != previousHwnd) {
            previousHwnd := lParam
            ; if !GetKeyState("LButton", "P"){        ; si usuario NO esta presionando LMB
                Sleep(200)
                SetTimer(moverCursorAlCentro, -100) ; Small delay for stability
            ; }
        }
    }
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