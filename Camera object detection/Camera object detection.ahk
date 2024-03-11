;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Name:
; Camera object detection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#singleinstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;;;;;;;;;;;;;;;;;;;
jjj1 := 10
jjj2 := 1
Gui, Color, 121212
Gui, Font, s23
Gui, Add, Picture, x10 y10 w300 h100, red.png
Gui, Add, Picture, x10 y150 w360 h740,
Gui, Add, Text, cWhite x320 y10 w60 h60, %jjj1%.0
Gui, Font, s12
Gui, Add, Button, x320 y75 w60 h30 gButton, +5 sec
Gui, Add, Button, x320 y105 w60 h30 gButton2, -5 sec
Gui, Font, s23
Gui, Show, x-550 y-30 h900
;Gui, Show,
GuiControl, Show, Static1
SoundBeep, 1000, 100
SoundBeep, 1000, 100
Sleep, 5
SoundBeep, 1000, 100

var1 := A_ScriptFullPath

StringTrimRight, fullNameDir, var1, 52

;MsgBox, % fullNameDir




; Set the directory to count folders in
dir := fullNameDir . "\screenshots"

; Count the number of folders in the directory
FolderCount := 0
Loop, %dir%\*.*, 2, 0
{
    if A_LoopFileAttrib contains D
        FolderCount++
}



; Set the directory to get the latest folder from
dir := fullNameDir . "\screenshots"

; Get a list of all the folders in the directory
FileList := ""
Loop, %dir%\*, 2, 1
{
    if A_LoopFileAttrib contains D
        FileList .= A_LoopFileName "`n"
}

; Get the latest folder in the directory
latest_folder := ""
Loop, Parse, FileList, `n
{
    if (A_LoopField > latest_folder)
        latest_folder := A_LoopField
}

; Display the latest folder
;MsgBox, % "The latest folder in " dir " is " latest_folder










latest_folder := latest_folder
dir := fullNameDir . "\screenshots\" . latest_folder . "\*.jpg"
file_count := 0
nnn := 1
Loop, %dir%
{
    file_count := file_count + 1
    file_path := A_LoopFileFullPath

VarImage%nnn% := file_path
nnn++
}

;MsgBox, % "Total files read: " . file_count
;MsgBox, %VarImage1%`n%VarImage2%`n%VarImage3%


funcFolderCounting()
{
global




latest_folder := latest_folder
dir := fullNameDir . "\screenshots\" . latest_folder . "\*.jpg"
file_count := 0
nnn := 1
Loop, %dir%
{
    file_count := file_count + 1
    file_path := A_LoopFileFullPath

VarImage%nnn% := file_path
nnn++
}

;MsgBox, % "Total files read: " . file_count
;MsgBox, %VarImage1%`n%VarImage2%`n%VarImage3%




; Get the latest folder in the directory
latest_folder := ""
Loop, Parse, FileList, `n
{
    if (A_LoopField > latest_folder)
        latest_folder := A_LoopField
}










latest_folder := latest_folder
dir := fullNameDir . "\screenshots\" . latest_folder . "\*.jpg"
file_count := 0
nnn := 1
Loop, %dir%
{
    file_count := file_count + 1
    file_path := A_LoopFileFullPath

VarImage%nnn% := file_path
nnn++
}

;MsgBox, % "Total files read: " . file_count
;MsgBox, %VarImage1%`n%VarImage2%`n%VarImage3%
nnn1 := 1
}






nnn1 := 1
nnn2 := 1
funcFolderCounting()
StartTime := A_TickCount
ppp := 8000
Loop
{
nnn1 := 1
file_count1 := file_count
funcFolderCounting()
file_count2 := file_count
ElapsedTime := A_TickCount - StartTime
if (file_count1 = file_count2) && (ElapsedTime >= 5000)  && (ElapsedTime <= ppp)
{
jjj1 := 10
GuiControl, Text, Static3, %jjj1%.%jjj2%
}
if (file_count1 != file_count2)
{
StartTime := A_TickCount
jjj1 := 9999999999999999999
}
Loop, %file_count%
{
VarImage := VarImage%nnn1%
GuiControl, Text, Static2, %VarImage%
nnn1++
Sleep, 100
if (jjj1 < 0)
{
ExitApp
}
Loop, 100
{
ppp++
}
jjj := jjj + 0.1
jjj++
jjj2--
if (jjj2 <= 0)
{
GuiControl, Text, Static3, %jjj1%.%jjj2%
jjj1--
GuiControl, Text, Static3, %jjj1%.%jjj2%
GuiControl, Text, Static3, %jjj1%.%jjj2%
jjj2 := 9
}
GuiControl, Text, Static3, %jjj1%.%jjj2%
}
nnn1 := 1
Sleep, 100
jjj++
jjj2--
if (jjj2 <= 0)
{
GuiControl, Text, Static3, %jjj1%.%jjj2%
jjj1--
GuiControl, Text, Static3, %jjj1%.%jjj2%
GuiControl, Text, Static3, %jjj1%.%jjj2%
jjj2 := 9
}
GuiControl, Text, Static3, %jjj1%.%jjj2%
if (jjj1 < 0)
{
ExitApp
}
}
ExitApp
Return


Button:
jjj1++
jjj1++
jjj1++
jjj1++
jjj1++
GuiControl, Text, Static3, %jjj1%.%jjj2%
Return

Button2:
jjj1--
jjj1--
jjj1--
jjj1--
jjj1--
GuiControl, Text, Static3, %jjj1%.%jjj2%
Return


GuiClose:
ExitApp
