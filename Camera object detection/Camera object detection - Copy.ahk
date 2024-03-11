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
;;;;;;;;;;;;;;;;;;;;;
Save(s, sn)
{
FileDelete, %A_ScriptDir%\%sn%.txt
FileAppend,
(
%s%
), %A_ScriptDir%\%sn%.txt
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Load(l, sn)
{
	global
Loop, read, %A_ScriptDir%\%sn%.txt
{
    StringSplit, LineArray, A_LoopReadLine, %A_Tab%
    varAHK := LineArray1
}
}
;===================================================;

funcFolderCounting()
{
global


; Set the directory to count folders in
dir := "C:\Users\The_M\pythonProjectGame one\screenshots"

; Count the number of folders in the directory
FolderCount := 0
Loop, %dir%\*.*, 2, 0
{
    if A_LoopFileAttrib contains D
        FolderCount++




; Set the directory to get the latest folder from
dir := "C:\Users\The_M\pythonProjectGame one\screenshots"

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
dir := "C:\Users\The_M\pythonProjectGame one\screenshots\" . latest_folder . "\*.jpg"
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
}



funcFolderCounting()
MsgBox, %FolderCount%
FileDelete, folder.txt
FileAppend, %jjj%, folder.txt
Loop
{
funcFolderCounting()
FolderCount1 := FolderCount
Sleep, 100
funcFolderCounting()
FolderCount2 := FolderCount
if (FolderCount1 != FolderCount2)
{
jjj := FolderCount
FileDelete, folder.txt
FileAppend, %jjj%, folder.txt
}
}