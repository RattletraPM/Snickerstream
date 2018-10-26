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
		Local $sLine = FileReadLine($hFile, $i)
		If StringInStr($sLine,$sRef)<>0 Then
			FileClose($hFile)
			Return StringLeft($sLine, $iLenght)
		EndIf
	Next
	FileClose($hFile)
	Return "NOVERSION"
EndFunc

; #INDEX# =======================================================================================================================
; Name...........: _GetGithubLatestReleaseTag
; Description ...: Gets the latest release tag from a GitHub repo using the official API
; Syntax.........: _GetGitCommit($sUser, $sRepo)
; Return values .: Success	-	Latest release tag (as string)
;					Failure - Returns a blank string and sets @error to 1
; Remarks .......: None
; Author(s) .....: RattletraPM
; Dll ...........: None
; ===============================================================================================================================
Func _GetGithubLatestReleaseTag($sUser,$sRepo)
	Local $sAPIRead=BinaryToString(InetRead("https://api.github.com/repos/"&$sUser&"/"&$sRepo&"/releases/latest",1))
	Local Const $sTag=',"tag_name":'
	If StringInStr($sAPIRead,$sTag)<>0 Then
		Return StringTrimLeft(StringLeft($sAPIRead,StringInStr($sAPIRead,',"target_commitish":')-2),StringInStr($sAPIRead,$sTag)+12)
	Else
		SetError(-1)
		Return ""
	EndIf
EndFunc