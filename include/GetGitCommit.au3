#include-once
#include <File.au3>

; #INDEX# =======================================================================================================================
; Name...........: _GetGitCommit
; Description ...: Reads the latest Git commit hash from the packed-refs file based on the parameters given
; Syntax.........: _GetGitCommit($sRef, [[$iLenght=7], $sPackedRefsPath=".git\packed-refs"])
; Return values .: Success	-	Latest Git commit hash
;					Failure - NOVERSION or NOGIT
; Remarks .......: This function has only been tested with Git on Windows using a GitHub project
; Author(s) .....: RattletraPM
; Dll ...........: None
; ===============================================================================================================================
Func _GetGitCommit($sRef,$iLenght=7,$sPackedRefsPath=".git\packed-refs")
	If FileExists($sPackedRefsPath)==0 Then Return "NOGIT"
	If $iLenght>40 Then $iLenght=40
	Local $hFile=FileOpen($sPackedRefsPath, 0)

	For $i=1 to _FileCountLines($sPackedRefsPath)
		$sLine = FileReadLine($hFile, $i)
		If StringInStr($sLine,$sRef)<>0 Then
			FileClose($hFile)
			Return StringLeft($sLine, $iLenght)
		EndIf
	Next
	FileClose($hFile)
	Return "NOVERSION"
EndFunc