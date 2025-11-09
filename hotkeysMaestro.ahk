; purpose: Krita/Blender hotkeys must rule over Gimp, Inkscape, Houdini, Daz
;
;
;

global estaMMactivo := true                       ; booleano superGlobal para desActivar ModoMaestro

; SetCapsLockState('AlwaysOff')

; ~CapsLock::{
;     global estaMMactivo
;     estaMMactivo := !estaMMactivo
;     estaMMactivo ? SoundBeep(750, 200) : SoundBeep( 500, 200)       ; SI: volver a vanilla hotkeys en apps.... NO: normalmente override hotkeys
;     estaMMactivo ? SetScrollLockState("Off") : SetScrollLockState("On")
    ; CapsLock::Send("{End}")
; }

#HotIf WinActive("ahk_exe gimp-3.exe")		    ; Cambiar segun la verion de GIMP
    ; g::estaMMactivo ? Send("m") : Send("g")     ; MoveTool
    ; ^t::estaMMactivo ? Send("{Shift}{t}") : Send("{LCtrl}{t}")     ; UnifiedTransformTool
    ; Rectangular selection tool
    ; ^t::MsgBox("sjdlfksf")
    ; Send("!+{K}")
#HotIf WinActive("ahk_exe krita.exe")
    ; g::estaMMactivo ? Send("t") : Send("g")     ; MoveTool ctrl alt shift g
    +MButton::MButton
    F16::{
        A_Clipboard := StrReplace(A_Clipboard,"/","\")
    }
#HotIf WinActive("ahk_exe blender.exe")
    ; LCtrl::Send("{RControl}")
    ;LShift & LCtrl::MsgBox("nonono")
#HotIf





