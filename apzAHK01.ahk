#Requires AutoHotkey v2.0
#SingleInstance

#o::Reload

; Activar app aprovechando teclas poco usadas
SetTitleMatchMode(2)
; ScrollLock:: WinActivate("Freeplane")
; SC045:: WinActivate("Visual Studio Code") ;PauseBreak key
F13:: WinActivate("Freeplane")
F14:: WinActivate("Krita")
F15:: WinActivate("ApzTool")
F16:: WinActivate("drawio")
F17:: WinActivate("ScreenToGif")
F22:: WinActivate("Double Commander")
F24:: WinActivate("Firefox")

; Cambiando el teclado a Hiragana
SC045::{            ;PauseBreak key
    Send("{Alt Down}{LShift Down}{LShift Up}{Alt Up}")
    ; SoundBeep(999,300)
    Sleep(100)
    Send("{LCtrl Down}{CapsLock Down}{CapsLock Up}{LCtrl Up}")
    ComObject("SAPI.SpVoice").Speak("japanese keyboard")
}

; Centrear el cursor en medio de ventana actual
OutX := 0, OutY := OutWidth := OutHeight := 0

CapsLock::{
    moverCursorAlCentro()
}

moverCursorAlCentro(){
    CoordMode("Mouse", "Window")
    WinGetPos(&OutX, &OutY, &OutWidth, &OutHeight, "A")
    Sleep(100)
    MouseMove(OutWidth/2, OutHeight/2, 20)
}

; Automate cortes de video en Blender VSE a botones extra de mouse
#HotIf WinActive("ahk_exe blender.exe")
XButton1::{
    Send("{PgDn}")
    Sleep(100)
    Send("{x}")
    Sleep(100)
    Send("{shift}{Backspace}")
    Sleep(100)
}
XButton2::{  
    Send("k") 
}

; Copiar image path al clipboard para IrfanView
#HotIf WinActive("ahk_exe i_view64.exe")
^+c::{
    Send("+p")
}
; ReAprovechar la tecla Ins para 3 shortcuts: insert image interna, insert image externa, insert file o hyperlink
CoordMode "Mouse","Screen"
#HotIf WinActive('Freeplane')
Insert::{
	MiGui := Gui()
	Btn1 := MiGui.AddButton("x5 y5 w75", "image↓")
	Btn1.OnEvent("Click", Btn1_Click)
	Btn1_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
		Send("{Insert}")
	}
	Btn2 := MiGui.AddButton("x80 y5 w75", "image↑")
	Btn2.OnEvent("Click", Btn2_Click)
	Btn2_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
		Send("!{K}")
	}
	Btn3 := MiGui.AddButton("x160 y5 w75", "link")
	Btn3.OnEvent("Click", Btn3_Click)
	Btn3_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
		Send("^+{K}")
	}
	
	MouseGetPos &RatonX, &RatonY
	MiGui.Show()
	WinMove RatonX, RatonY, , , MiGui
}
#HotIf

; Alt & Tab::{
;     Send("^!{Tab}")
; }

;---------------------------Creacion de anotacion----------------------------------------
CoordMode "Mouse","Screen"

F19::{
	MiGui := Gui()	;Gui("Resize")	pero pone barra encima
	MiGui.Opt("AlwaysOnTop")
		
		MiGui.AddEdit("w500 h500 x-3 y-2 cyellow Background393939","abc def ghi")
		MiGui.Show()
		WinSetStyle "-0xC00000", "A"
		MouseGetPos &RatonX, &RatonY
		WinMove RatonX, RatonY, 200, 14, MiGui
}
^F19::Reload

#HotIf WinActive("ahk_class AutoHotkeyGUI")
~Alt & LButton:: {
	MouseGetPos &RatonX, &RatonY
	WinMove RatonX, RatonY,,, "A"
}

~Alt & Right:: {
	WinGetPos &X,&Y,&W,&H, "A"
	WinMove ,,W+20,, "A"
}

~Alt & Left:: {
	WinGetPos &X,&Y,&W,&H, "A"
	WinMove ,,W-20,, "A"
}

~Alt & Up:: {
	WinGetPos &X,&Y,&W,&H, "A"
	WinMove ,,,H-14, "A"
}

~Alt & Down:: {
	WinGetPos &X,&Y,&W,&H, "A"
	WinMove ,,,H+14, "A"
}
#HotIf
;--------------------------Creacion de imagen--------------------------------------------
F18::{
	elPath := A_Clipboard	; C:\Users\win\bitmap.png

	if InStr(elPath, A_Space){
		MsgBox('error path has blank spaces!!')
		elPath := "E:\win\Pictures\SavedPictures\MapeadoDeTeclas.png"
	}
	else if not (InStr(elPath, ".png") or InStr(elPath, ".jpg") or InStr(elPath, ".gif")) {
		MsgBox('path en clipboard is not a picture')
		elPath := "E:\win\Pictures\SavedPictures\MapeadoDeTeclas.png"
	}

	aLados := getDimensiones(elPath)

	MiGui := Gui()
	MiGui.MarginX := 0
	MiGui.MarginY := 0
	MiGui.BackColor := "red"
	MiGui.Opt("AlwaysOnTop")
	
	Foto := MiGui.AddPicture("",elPath)
	Foto.OnEvent("DoubleClick", CerrarApp)
	
	MiGui.Show()	;"w185 h162"
	WinSetStyle "-0xC00000", "A"
	WinGetPos &X,&Y,&W,&H, MiGui		

	WinMove X, Y, aLados[1], aLados[2], MiGui
}

getDimensiones(elPath){
	shell := ComObject("WScript.Shell.1")
	exec := shell.exec(A_ComSpec " /C magick.exe identify -ping -format %w,%h " elPath)
	aLados := StrSplit(exec.StdOut.ReadAll(),',')

	if(Integer(aLados[2]) > 600){	;gifs suelen dar valores enormes de 5000+
		aLados[2] := '600'
	}

	return aLados 		;strings array
}

CerrarApp(*){
	WinClose("A")
}

;-------------------hotstrings----------------------------------------------------
::vvv::video.mp4
return