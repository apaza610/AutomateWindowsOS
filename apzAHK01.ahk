#Requires AutoHotkey v2.0
#SingleInstance

#Include "hotkeysMaestro.ahk"

; #o::Reload
;#o::KeyHistory

~<!Tab::{										; ~ makes the AltTab work with no alteration
	Sleep(500)									; wait till the alt tab menu exist
	while WinActive("ahk_exe AltTabTer.exe")
		Sleep(500)
	Sleep(300)									; time needed to wake up app
	moverCursorAlCentro()
}

SetTitleMatchMode(2)
; ScrollLock:: WinActivate("Freeplane")
; SC045:: WinActivate("Visual Studio Code") ;PauseBreak key

; Cambiando el teclado a Hiragana
SC045::{            ;PauseBreak key
    Send("{Alt Down}{LShift Down}{LShift Up}{Alt Up}")
    ; SoundBeep(999,300)
    Sleep(100)
    Send("{LCtrl Down}{CapsLock Down}{CapsLock Up}{LCtrl Up}")
    ; ComObject("SAPI.SpVoice").Speak("japanese keyboard")
}

; Centrear el cursor en medio de ventana actual
OutX := 0, OutY := OutWidth := OutHeight := 0

; SetCapsLockState('AlwaysOff')
; CapsLock::Send("{End}")

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
	Btn1 := MiGui.AddButton("x5 y5 w75", "img↓")
	Btn1.OnEvent("Click", Btn1_Click)
	Btn1_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
		Send("{Insert}")
	}
	Btn2 := MiGui.AddButton("x80 y5 w75", "img↑")
	Btn2.OnEvent("Click", Btn2_Click)
	Btn2_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
		Send("!+{K}")
	}
	Btn3 := MiGui.AddButton("x160 y5 w75", "link")
	Btn3.OnEvent("Click", Btn3_Click)
	Btn3_Click(*){
		CerrarApp()
		WinActivate('Freeplane')
	}
	
	MouseGetPos &RatonX, &RatonY
	MiGui.Show("w225 h0")
	WinSetStyle "-0xC00000", "A"
	WinMove RatonX, RatonY, , , MiGui
}

#HotIf

;---------------------------Teclas de Funcion-------------------------------------------
;#F13::MsgBox("Tecla NumLock")
;--------------------------Creacion de miniIMAGEN--------------------------------------------
F14::{		;Tecla Divide
	elPath := A_Clipboard	; C:\Users\win\bitmap.png

	if InStr(elPath, A_Space){
		MsgBox('error path has blank spaces!!')
		elPath := "E:\win\Pictures\SavedPictures\MapeadoDeTeclas.png"
	}
	else if not (InStr(elPath, ".png") or InStr(elPath, ".jpg") or InStr(elPath, ".gif")) {
		; MsgBox('path en clipboard is not a picture')
		elPath := "E:\win\Pictures\Screenshots\MapeadoDeTeclas.png"
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

;---------------------------Creacion de miniNOTE--------------------------------
CoordMode "Mouse","Screen"
F15::{
	MiGui := Gui()	;Gui("Resize")	pero pone barra encima
	MiGui.Opt("AlwaysOnTop")
		
		MiGui.AddEdit("w500 h500 x-3 y-2 cyellow Background393939","abc def ghi")
		MiGui.Show()
		WinSetStyle "-0xC00000", "A"
		MouseGetPos &RatonX, &RatonY
		WinMove RatonX, RatonY, 200, 14, MiGui
}
^F15::Reload

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
;---------------------------------------------------------------------------------
; F16::{
; 	if WinExist("FuriganaTAGs"){
; 		WinActivate("FuriganaTAGs")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		MsgBox("The app must be opened first")
; 	}
; }

; F17:: {
; 	if WinExist("ApzTool"){
; 		WinActivate("ApzTool")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run("E:\misapps\pcjava\ApazaMmpTool\out\artifacts\ApazaMmpTool_jar\ApazaMmpTool.jar")
; 	}
; }
; F18:: {
; 	if WinExist("drawio"){
; 		WinActivate("drawio")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run("C:\Users\win\AppData\Local\Programs\draw.io\draw.io.exe")
; 	}
; }
; F19:: {
; 	if WinExist("Krita"){
; 		WinActivate("Krita")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run("C:\Program Files\Krita (x64)\bin\krita.exe")
; 	}
; }
+F20:: {
	if WinExist("Freeplane"){
		WinActivate("Freeplane")
		moverCursorAlCentro()
	}
	else{
		Run("C:\Program Files\Freeplane\freeplane.exe")
	}	
}
; #F21::MsgBox("ddddddddddddddddddd")
; F23:: {
; 	if WinExist("Blender"){
; 		WinActivate("Blender")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run("E:\Progs\art3d\blender-4.1\blender.exe")
; 	}
; }

; #F24:: {
; 	if WinExist("ScreenToGif"){
; 		WinActivate("ScreenToGif")
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run("C:\Program Files\ScreenToGif\ScreenToGif.exe")
; 	}
; }

lstBrowsers := ["Firefox", "Brave", "Edge"]
pthBrowsers := ["C:\Program Files\Mozilla Firefox\firefox.exe", "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"]
cntBrowsers := 1
; +F20:: {
; 	global cntBrowsers
; 	if WinExist(lstBrowsers[cntBrowsers]){
; 		WinActivate(lstBrowsers[cntBrowsers])
; 		moverCursorAlCentro()
; 	}
; 	else{
; 		Run(pthBrowsers[cntBrowsers])
; 	}
; 	if cntBrowsers < lstBrowsers.Length
; 		cntBrowsers++
; 	else
; 		cntBrowsers := 1
; }

; lstFileManagers := ["ahk_class CabinetWClass ahk_exe explorer.exe", "Double Commander"]	;"One Commander"
; pthFileManagers := ["ahk_class CabinetWClass ahk_exe explorer.exe", "C:\Program Files\OneCommander\OneCommander.exe"]	;"C:\Program Files\OneCommander\OneCommander.exe"
; cntFileManager := 1
; +F19:: {
	; global cntFileManager
	; if WinExist(lstFileManagers[cntFileManager]){
	; 	WinActivate(lstFileManagers[cntFileManager])
	; 	moverCursorAlCentro()
	; }
	; else{
	; 	Run(pthFileManagers[cntFileManager])
	; }
	; if cntFileManager < lstFileManagers.Length
	; 	cntFileManager++
	; else
	; 	cntFileManager := 1
; 	moverCursorAlCentro()
; }
+F8::MsgBox("+f8")
;-------------------hotstrings----------------------------------------------------
return
::vvv::vid0.mp4
::ppp::<?php ?>{Left 3}
::sss::show_debug_message(