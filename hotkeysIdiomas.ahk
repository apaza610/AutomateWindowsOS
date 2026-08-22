; #Requires AutoHotkey v2.0
; #SingleInstance Force

;-------------------------------------------------------------------------------------------------------
; tecladosArray := Array("00000409","00000804","00000411","00000409","00000804","00000411")        ; ingles chino japones
; tecladosArrNm := Array("ENG",     "CHN",     "romaji",  "ENG",     "CHN",     "hiragana")

~#Space:: {
    Sleep(300)

    hkl := DllCall("GetKeyboardLayout", "UInt"
        , DllCall("GetWindowThreadProcessId", "Ptr", WinExist("A"), "UInt*", 0)
        , "UInt")
    layout := Format("{:08X}", hkl & 0xFFFF)

    lang := ""
    switch layout {
        case "00000409": lang := "ENG"
        case "00000804": lang := "中文"
        case "00000411":
            hwnd := WinExist("A")
            himc := DllCall("imm32\ImmGetContext", "Ptr", hwnd, "Ptr")
            if (himc) {
                DllCall("imm32\ImmSetConversionStatus", "Ptr", himc, "UInt", 0x8, "UInt", 0)
                DllCall("imm32\ImmReleaseContext", "Ptr", hwnd, "Ptr", himc)
            } else {
                ; Correct way to send Ctrl+CapsLock
                Send("^{CapsLock}")
            }
            lang := "日本語"
    }

    CoordMode("ToolTip", "Screen")
    MouseGetPos(&x, &y)
    ToolTip(lang, x + 10, y + 10)
    SetTimer(() => ToolTip(), -400)
}