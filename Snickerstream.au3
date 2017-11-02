#cs
  ___      _    _              _
 / __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __
 \__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \
 |___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|

By RattletraPM - licensed under GNU GPL V3.0
Written for AutoIt v3.3.14.2

TODO: Add features and other stuff. Code has been polished a bit, but it could be even better.

#ce

#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GuiIPAddress.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <Misc.au3>
#include <String.au3>
#include "include\ntr.au3"

;Globbals - Streaming GUI and Drawing
Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hBMP2, $g_hGraphics, $iFPS=0, $iInterpolation=0, $sVersion="v0.75b ", _
$sGUITitle="Snickerstream " & $sVersion, $aWinResize, $xBMP1=0, $xBMP2=40, $yBMP1=0, $yBMP2=240, $iLayoutmode=0, $bNoDisplayIPWarn=0

;Globals - Main GUI
Global $sIpAddr="0.0.0.0", $iPriorityMode=0, $iPriorityFactor=5, $iImageQuality=70, $iQoS=5

;Globals - Config
Global $sFname="settings.ini", $sSectionName="Snickerstream", $aIniSections[11] = ["IpAddr", "PriorityMode", "PriorityFactor", "ImageQuality", _
"QoS", "Interpolation", "Layoutmode", "PCIpAddr", "NoDisplayIPWarn", "Loglevel", "DontCheckSettings"], $sPCIpAddr=$sIpAddr, $iLogLevel=0, $sLogFname="log.txt"

;Globals - Misc
Global $hTimer=TimerInit(), $bStreaming=False

;ProcessSetPriority(@AutoItPID,5)
AutoItSetOption("GUIOnEventMode", 1)	;Use OnEvent mode - a script like this would be awful without it
AutoItSetOption("TCPTimeout",5000)

CreateMainGUIandSettings() ;Create the GUI
LogStart()
LogLine("WARNING: The loglevel is now set to 3. This will produce GIANT logfiles.",3)
LogLine("You should set your loglevel to something else unless you're troubleshooting some issues!",3)
Do
	Sleep(100)
Until $bStreaming=True

Func StreamingLoop()
	LogLine("Recieving stream.",1)
	LogLine("PC IP address: "&$sPCIpAddr,2)
	LogLine("3DS IP address: "&$sIpAddr,2)
	LogLine("Priority: "&$iPriorityMode,2)
	LogLine("Priority factor: "&$iPriorityFactor,2)
	LogLine("Image quaility: "&$iImageQuality,2)
	LogLine("QoS: "&$iQoS,2)
	LogLine("Interpolation mode: "&$iInterpolation,2)
	LogLine("Screen layout: "&$iLayoutmode,2)
	LogLine("-NOTE- The IP addresses should be internal. If you set them to public DO NOT share this log online!",2)
	UDPStartup()	;Start up the UDP protocol
	Global Const $iSocket = UDPBind($sPCIpAddr, "8001")	;Listen to port 8001

    _GDIPlus_Startup() ;initialize GDI+
    Local Const $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	Local $iGUIWidthHeight=Default, $xGUIStyle=Default, $xGUIExStyle=Default
	Global $iWidth = 400, $iHeight = 480	;Default settings for Vertical view mode
	Switch $iLayoutmode	;View modes
		Case 1	;Vertical (inverted)
			Global $yBMP1=240, $yBMP2=0
		Case 2	;Horizontal
			Global $iWidth = 720, $iHeight = 240, $yBMP1=0, $yBMP2=0, $xBMP2=400
		Case 3	;Horizontal (inverted)
			Global $iWidth = 720, $iHeight = 240, $yBMP1=0, $yBMP2=0, $xBMP1=320, $xBMP2=0
		Case 4	;Top only
			Global $iWidth = 400, $iHeight = 240
			CheckOptimal()
		Case 5	;Bottom only
			Global $iWidth = 320, $iHeight = 240, $yBMP2=0, $xBMP2=0
			CheckOptimal()
		Case 6	;Fullscreen (Top)
			Local $iGUIWidthHeight=0, $xGUIStyle=$WS_POPUP, $xGUIExStyle=$WS_EX_TOPMOST
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight, $iScaleFactor=@DesktopHeight/240
			CheckOptimal()
	EndSwitch

	$g_hGUI = GUICreate($sGUITitle, $iWidth, $iHeight,$iGUIWidthHeight,$iGUIWidthHeight,$xGUIStyle,$xGUIExStyle) ;Create the GUI

	;In order to correctly resize the window, we need to get the difference between the graphics object width/height and the actual
	;window width/height. This difference is created by the window's borders and title bar
	$aWinResize=WinGetPos($g_hGUI)
	Global $iWidthDiff=$aWinResize[2]-$iWidth
	Global $iHeightDiff=$aWinResize[3]-$iHeight

    GUISetBkColor($iBgColor, $g_hGUI) ;Set GUI background color
    GUISetState(@SW_SHOW)

    ;Create buffered graphics frame set for smoother gfx object movements
    $g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;Create a graphics object from a window handle
	If $iLayoutmode<>6 Then
		$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGraphics)
	Else
		$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics(400, 240, $g_hGraphics)
	EndIf
    $g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)

    While 1
		CheckKeys()	;Check the keys that are pressed to do various functions
		$aJpeg=_NTRRemoteplayReadJPEG($iSocket)
		If IsArray($aJpeg) Then
			DisplayScreen($aJpeg[0],$aJpeg[1])
		EndIf

		_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;Copy drawn bitmap to graphics handle (GUI)
		_GDIPlus_GraphicsSetInterpolationMode($g_hGraphics,$iInterpolation)	;We need to set the interpolation mode each frame in case the mode gets changed
	WEnd
EndFunc   ;==>Example

Func CheckOptimal()
	Local $sMsg1="It looks like your remoteplay settings aren't optimal. You should change:"&@CRLF&@CRLF
	Local $sMsg2=@CRLF&"then restart NTR CFW to achieve the best possible performance!"&@CRLF&@CRLF& _
	"Click OK to close this message or Cancel if you don't want to be warned about your settings ever again."
	Local $bNotOptimal=False

	If ($iLayoutMode==4 Or $iLayoutMode==6) And $iPriorityMode==0 Then
		$sMsg1=$sMsg1&"* Priority mode to Top Screen"&@CRLF
		$bNotOptimal=True
	EndIf
	If $iLayoutMode==5 And $iPriorityMode==1 Then
		$sMsg1=$sMsg1&"* Priority mode to Bottom Screen"&@CRLF
		$bNotOptimal=True
	EndIf
	If $iPriorityFactor>0 Then
		$sMsg1=$sMsg1&"* Priority factor to 0"&@CRLF
		$bNotOptimal=True
	EndIf

	If $bNotOptimal=True And IniRead($sFname,$sSectionName,$aIniSections[10],0)==0 Then
		$iMsgBoxAnswer = MsgBox(49,"Warning!",$sMsg1&$sMsg2)
		Select
			Case $iMsgBoxAnswer=2	;Cancel selected
				IniWrite($sFname,$sSectionName,$aIniSections[10],1)
		EndSelect
	EndIf
EndFunc

Func DisplayScreen($iScreen, ByRef $bRawJpeg)	;TODO: Ignore top/bottom screens in top only/bottom only mode!
	$iFPS+=1
	$g_hBMP=_GDIPlus_BitmapCreateFromMemory($bRawJpeg)	;Create a GDI+ Bitmap from the image that's stored in memory
	_GDIPlus_ImageRotateFlip($g_hBMP,3)	;The original image needs to be rotated
	If $iScreen==1 And $iLayoutmode<>5 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $xBMP1, $yBMP1) ;Draw the bitmap to the backbuffer
	ElseIf $iScreen=0 And $iLayoutmode<>4 And $iLayoutmode<>6 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $xBMP2, $yBMP2) ;draw bitmap to backbuffer
	EndIf
	_GDIPlus_BitmapDispose($g_hBMP)
EndFunc

Func _CheckPressedOnce($key)
	If Not IsDeclared($key&"IsPressed") Then
		Assign($key&"IsPressed", False, 2)
	EndIf

	If _IsPressed($key) And Eval($key&"IsPressed")==False Then
		Assign($key&"IsPressed", True, 4)
		Return True
	ElseIf _IsPressed($key)==False And Eval($key&"IsPressed")==True Then
		Assign($key&"IsPressed", False, 4)
		Return False
	EndIf
EndFunc

Func CheckKeys()
	;TODO: Polish this shit.
	;...
	;No, really. The following function is a complete and utter eyesore.
	;You have been warned.
	If _CheckPressedOnce("26")==True Then
		$iWidth=$iWidth*1.2
		$iHeight=$iHeight*1.2
		$aWinResize=WinGetPos($g_hGUI)
		WinMove($g_hGUI,"",Default,Default,$iWidth+$iWidthDiff,$iHeight+$iHeightDiff)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
		LogLine("Window size increased to "&$iWidth&"x"&$iHeight&".",1)
	EndIf
	If _CheckPressedOnce("28")==True And $iHeight>=200 Then
		$iWidth=$iWidth/1.2
		$iHeight=$iHeight/1.2
		$aWinResize=WinGetPos($g_hGUI)
		WinMove($g_hGUI,"",Default,Default,$iWidth+$iWidthDiff,$iHeight+$iHeightDiff)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
		LogLine("Window size decreased to "&$iWidth&"x"&$iHeight&".",1)
	EndIf
	If _CheckPressedOnce("25")==True Then
		If $iInterpolation>0 Then $iInterpolation-=1
		LogLine("Interpolation mode changed to "&$iInterpolation&".",1)
	EndIf
	If _CheckPressedOnce("27")==True Then
		If $iInterpolation<7 Then $iInterpolation+=1
		LogLine("Interpolation mode changed to "&$iInterpolation&".",1)
	EndIf
	If _CheckPressedOnce("53")==True Then
		_GDIPlus_ImageSaveToFile($g_hBitmap,"screenshot"&@MDAY&@MON&@YEAR&@HOUR&@MIN&@SEC&@MSEC&".bmp")
	EndIf
	If TimerDiff($hTimer)>=1000 Then
		$hTimer=TimerInit()
		WinSetTitle($g_hGUI,"",$sGUITitle&$iFPS&" FPS")
		LogLine("FPS:"&$iFPS,3)
		$iFPS=0
	EndIf
	If _IsPressed("1B") Then ExitStreaming()
EndFunc

Func CreateMainGUIandSettings()
	;Check if the config file exists. If not, create one with the default config in it.
	If FileExists($sFname) Then
		$sIpAddr=IniRead($sFname,$sSectionName,$aIniSections[0],$sIpAddr)
		$iPriorityMode=IniRead($sFname,$sSectionName,$aIniSections[1],$iPriorityMode)
		$iPriorityFactor=IniRead($sFname,$sSectionName,$aIniSections[2],$iPriorityFactor)
		$iImageQuality=IniRead($sFname,$sSectionName,$aIniSections[3],$iImageQuality)
		$iQoS=IniRead($sFname,$sSectionName,$aIniSections[4],$iQoS)
		$iInterpolation=IniRead($sFname,$sSectionName,$aIniSections[5],$iInterpolation)
		$iLayoutMode=IniRead($sFname,$sSectionName,$aIniSections[6],$iLayoutMode)
		$sPCIpAddr=IniRead($sFname,$sSectionName,$aIniSections[7],@IPAddress1)
		$bNoDisplayIPWarn=IniRead($sFname,$sSectionName,$aIniSections[8],0)
		$iLogLevel=IniRead($sFname,$sSectionName,$aIniSections[9],$iLogLevel)
		If $bNoDisplayIPWarn==0 And $sPCIpAddr<>"0.0.0.0" Then
			Local $iWarnButPressed=MsgBox($MB_ICONWARNING+$MB_YESNO,"Warning!","You've set a specific IP address for your PC in the configuration file. This isn't needed in most cases and will pro"& _
			"bably result in a grey screen when trying to connect to your 3DS."&@CRLF&@CRLF&"Press Yes to revert this setting to the default value and listen to all IPs associated with your comput"& _
			"ers (recommended) or No to keep your custom setting and never display this warning anymore.")
			If $iWarnButPressed==$IDYES Then
				IniWrite($sFname,$sSectionName,$aIniSections[7],"0.0.0.0")
				$sPCIpAddr="0.0.0.0"
			ElseIf $iWarnButPressed==$IDNO Then
				IniWrite($sFname,$sSectionName,$aIniSections[8],1)
			EndIf
		EndIf
	Else
		WriteConfig()
		;If we use WriteConfig for the first time, the written priority mode value will be wrong. We'll (over)write the right one with
		;this small piece of code.
		IniWrite($sFname,$sSectionName,$aIniSections[1],Int($iPriorityMode))
	EndIf

	;This region has been generated by KODA, then changed slightly manually
	#Region ### START Koda GUI section ### Form=\gui\SnickerstreamGUI.kxf
	Global $SnickerstreamGUI = GUICreate($sGUITitle, 459, 162, 192, 124)
	$Label1 = GUICtrlCreateLabel("IP", 24, 24, 14, 17, $SS_CENTERIMAGE)
	$Label2 = GUICtrlCreateLabel("Screen priority", 24, 48, 71, 17, $SS_CENTERIMAGE)
	$Label3 = GUICtrlCreateLabel("Priority factor", 24, 72, 65, 17, $SS_CENTERIMAGE)
	$Label4 = GUICtrlCreateLabel("Image quality", 24, 96, 66, 17, $SS_CENTERIMAGE)
	$Label5 = GUICtrlCreateLabel("QoS Value", 24, 120, 55, 17, $SS_CENTERIMAGE)
	Global $GUI_IpAddr = _GUICtrlIpAddress_Create($SnickerstreamGUI, 104, 24, 105, 17)
	Global $GUI_PriorityMode = GUICtrlCreateCombo("", 104, 48, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Top screen|Bottom screen", "Top screen")
	Global $GUI_PriorityFactor = GUICtrlCreateInput("5", 104, 72, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_ImageQuality = GUICtrlCreateInput("90", 104, 96, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_QoS = GUICtrlCreateInput("20", 104, 120, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$Label6 = GUICtrlCreateLabel("Interpolation", 245, 24, 62, 17, $SS_CENTERIMAGE)
	Global $GUI_Interpolation = GUICtrlCreateCombo("", 322, 22, 115, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	$Label7 = GUICtrlCreateLabel("Screen layout", 245, 48, 69, 17, $SS_CENTERIMAGE)
	Global $GUI_Layoutmode = GUICtrlCreateCombo("", 322, 48, 115, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top)", "Vertical")
	Global $GUI_ConnectBtn = GUICtrlCreateButton("Connect!", 232, 120, 217, 33)
	Global $GUI_RemoteplayBtn = GUICtrlCreateButton("Start remoteplay", 344, 88, 105, 25)
	$Group1 = GUICtrlCreateGroup("Remoteplay settings", 8, 8, 217, 145)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Display settings", 232, 8, 217, 73)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $GUI_AboutBtn = GUICtrlCreateButton("About", 232, 88, 105, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	;Set the limit for the inputs
	GUICtrlSetLimit($GUI_PriorityFactor,3)
	GUICtrlSetLimit($GUI_ImageQuality,3)
	GUICtrlSetLimit($GUI_QoS,3)

	;This is needed in case the config file was loaded, so it'll be shown correctly
	_GUICtrlIpAddress_Set($GUI_IpAddr, $sIpAddr)
	_GUICtrlComboBox_SetCurSel($GUI_PriorityMode,$iPriorityMode)
	GUICtrlSetData($GUI_PriorityFactor,$iPriorityFactor)
	GUICtrlSetData($GUI_ImageQuality,$iImageQuality)
	GUICtrlSetData($GUI_QoS,$iQoS)
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation,$iInterpolation)
	_GUICtrlComboBox_SetCurSel($GUI_Layoutmode,$iLayoutMode)

	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitMain", $SnickerstreamGUI)
	GUICtrlSetOnEvent($GUI_AboutBtn , "AboutMsg")
	GUICtrlSetOnEvent($GUI_RemoteplayBtn, "SendPacket")
	GUICtrlSetOnEvent($GUI_ConnectBtn, "StartStream")
EndFunc

Func UpdateVars()
	;We need to call this function when the user clicked on init remoteplay or connect to correctly update the variables
	$sIpAddr=_GUICtrlIpAddress_Get($GUI_IpAddr)
	$iPriorityMode=Int(Not _GUICtrlComboBox_GetCurSel($GUI_PriorityMode))
	$iPriorityFactor=Int(GUICtrlRead($GUI_PriorityFactor))
	$iImageQuality=Int(GUICtrlRead($GUI_ImageQuality))
	$iQoS=Int(GUICtrlRead($GUI_QoS))
	$iInterpolation=Int(_GUICtrlComboBox_GetCurSel($GUI_Interpolation))
	$iLayoutMode=Int(_GUICtrlComboBox_GetCurSel($GUI_Layoutmode))
EndFunc

Func WriteConfig()
	IniWrite($sFname,$sSectionName,$aIniSections[0],$sIpAddr)
	IniWrite($sFname,$sSectionName,$aIniSections[1],Int(Not $iPriorityMode))
	IniWrite($sFname,$sSectionName,$aIniSections[2],$iPriorityFactor)
	IniWrite($sFname,$sSectionName,$aIniSections[3],$iImageQuality)
	IniWrite($sFname,$sSectionName,$aIniSections[4],$iQoS)
	IniWrite($sFname,$sSectionName,$aIniSections[5],$iInterpolation)
	IniWrite($sFname,$sSectionName,$aIniSections[6],$iLayoutMode)
	IniWrite($sFname,$sSectionName,$aIniSections[7],$sPCIpAddr)
	IniWrite($sFname,$sSectionName,$aIniSections[9],$iLogLevel)
EndFunc

Func SendPacket()
	LogLine("Starting remoteplay on 3DS.",1)
	UpdateVars()
	$iRet = _NTRInitRemoteplay($sIpAddr, $iPriorityMode, $iPriorityFactor, $iImageQuality, $iQoS)
	If $iRet = -1 Then
		LogLine("Remoteplay init failed, could not connect.",1)
		MsgBox($MB_ICONERROR, "Connection error", "Could not connect to the (N)3DS.")
	Else
		LogLine("Remoteplay started.",1)
		MsgBox($MB_ICONINFORMATION,"Success!","Remoteplay successfully started!")
	EndIf
EndFunc

Func StartStream()
	UpdateVars()
	WriteConfig()
	GUIDelete($SnickerstreamGUI)
	$bStreaming=True
	StreamingLoop()
EndFunc

Func AboutMsg()
	MsgBox($MB_ICONINFORMATION,"About Snickerstream",$sGUITitle&"by RattletraPM"&@CRLF&@CRLF&"This software and its source code are provided free of charge under the GPL-3.0 License. See License.txt for the full license.")
EndFunc

Func ExitMain()
	GUIDelete($SnickerstreamGUI)
	Exit
EndFunc

Func ExitStreaming()
	LogLine("Quitting.",1)
	;Close the UDP socket and dispose of the GDI+ resources
	UDPCloseSocket($iSocket)
    _GDIPlus_GraphicsDispose($g_hGfxCtxt)
    _GDIPlus_GraphicsDispose($g_hGraphics)
    _GDIPlus_BitmapDispose($g_hBitmap)
    _GDIPlus_BitmapDispose($g_hBMP)
	_GDIPlus_BitmapDispose($g_hBMP2)
    _GDIPlus_Shutdown()
	UDPShutdown()
    GUIDelete($g_hGUI)
    Exit
EndFunc   ;==>_Exit

Func LogStart()
	If $iLogLevel>0 Then
		Local $hFile=FileOpen($sLogFname, $FO_OVERWRITE)

		FileWriteLine($hFile,"  ___      _    _              _")
		FileWriteLine($hFile," / __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __")
		FileWriteLine($hFile," \__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \")
		FileWriteLine($hFile," |___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|")
		FileWriteLine($hFile,_StringRepeat("-",82))
		Switch Random(0,6,1)
			Case 0
				FileWriteLine($hFile,"You've been in development hell for... nine months.")
			Case 1
				FileWriteLine($hFile,"*whispers* AL9H.")
			Case 2
				FileWriteLine($hFile,"You must have graduated from elementary school to use this tool.")
			Case 3
				FileWriteLine($hFile,"One more way to get copyright striked by Nintendo.")
			Case 4
				FileWriteLine($hFile,"What are you waiting for, Nintendo to make one?")
			Case 5
				FileWriteLine($hFile,"BREAKING NEWS: Florida man gets crazy, rewrites NTR streaming client.")
			Case 6
				FileWriteLine($hFile,"* The dog absorbs the stream.")
			Case 7
				FileWriteLine($hFile,"As smooth as FMVs on a Sega CD.")
			Case 8
				FileWriteLine($hFile,"[stability intensifies]")
			Case 9
				FileWriteLine($hFile,"Yep, it still doesn't have an icon.")
		EndSwitch
		FileWriteLine($hFile,_StringRepeat("-",82))
		FileWriteLine($hFile,"VERSION : "&$sVersion)
		FileWriteLine($hFile,"LOGLEVEL: "&$iLogLevel)
		FileWriteLine($hFile,_StringRepeat("-",82))
		LogLine("Logging started.",1)
		FileClose($hFile)
	EndIf
EndFunc

Func LogLine($sLogString,$iReqLogLevel)
	If $iLogLevel>=$iReqLogLevel Then
		Local $hFile=FileOpen($sLogFname, $FO_APPEND)

		FileWriteLine($hFile,"["&@HOUR&":"&@MIN&"] "&$sLogString)
		FileCLose($hFile)
	EndIf
EndFunc
