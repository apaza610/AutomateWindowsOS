; #Requires AutoHotkey v2.0
; #SingleInstance Force

; Run the function
SetCapsLockState("AlwaysOff")
~CapsLock::SeteaIdiomaTeclado()

;-------------------------------------------------------------------------------------------------------
; tecladosArray := Array("00000409","00000804","00000411","00000409","00000804","00000411")        ; ingles chino japones
; tecladosArrNm := Array("ENG", "CHN", "romaji","ENG", "CHN", "hiragana")
tecladosArray := Array("00000409","00000804","00000411")        ; ingles chino japones
tecladosArrNm := Array("ENG", "CHN", "JPN")
global contador := 1
global anteriorKeyb := ""

SeteaIdiomaTeclado()
{   
    global contador
    global esRomaji
    global anteriorKeyb

    anteriorKeyb := tecladosArrNm[contador]

    if (anteriorKeyb = "JPN"){
        ; Send("{LWin down}{Space}{LWin up}")
        Send("{LAlt}{LShift}")
    }

    contador := contador + 1
    if (contador = 4)
        contador := 1

    Sleep(200)
    static WM_INPUTLANGCHANGEREQUEST := 0x0050
    static KLF_ACTIVATE := 0x00000001 ; Activate the layout

    ; IME Conversion Mode Constants (Windows Standard)
    ; static IME_CMODE_ALPHANUMERIC := 0x0000
    ; static IME_CMODE_NATIVE       := 0x0001 ; For Japanese, this usually means Hiragana if Katakana is not also set
    ; static IME_CMODE_KATAKANA     := 0x0002
    ; static IME_CMODE_FULLSHAPE    := 0x0008 ; Often combined with NATIVE by default

    ToolTip("Intentando cambio a: " . tecladosArrNm[contador] )
    SetTimer(ToolTip, -2500)

    ; --- Step 1: Load and Activate the Keyboard Layout ---
    ; LoadKeyboardLayout ensures the HKL is available to the system.
    ; The first parameter is a string representing the HKL, e.g., "E0010411".
    hklLoadedVal := DllCall("LoadKeyboardLayoutW", "Str", tecladosArray[contador], "UInt", KLF_ACTIVATE, "UPtr")

    targetNumericHKL := Integer("0x" . tecladosArray[contador]) ; cadenaHKNdesdeConfig (e.g., "E0010411") needs to be converted to its numeric representation for PostMessage.

    ; Post message to request the input language change.
    ; This is generally preferred for asking applications to pick up the new language.
    hWndFg := WinGetID("A") ; Get the active window
    if (hWndFg)
        PostMessage(WM_INPUTLANGCHANGEREQUEST, KLF_ACTIVATE, targetNumericHKL, , "ahk_id " . hWndFg)
    else ; If no specific active window, broadcast (less common for this direct action)
        PostMessage(WM_INPUTLANGCHANGEREQUEST, KLF_ACTIVATE, targetNumericHKL, , "ahk_id 0xFFFF") ; HWND_BROADCAST

    Sleep(350) ; Wait a bit for the language change to propagate and for the IME to initialize.    
}