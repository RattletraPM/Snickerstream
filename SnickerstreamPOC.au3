#cs
  ___      _    _              _
 / __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __
 \__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \
 |___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|
 v0.6b PoC

By RattletraPM - licensed under GNU GPL V3.0
Written for AutoIt v3.3.14.2

TODO: Polish code, add features and other stuff.

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
#include "include\ntr.au3"

;Globbals - Streaming GUI and Drawing
Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hBMP2, $g_hGraphics, $iFPS=0, $iInterpolation=0, $sGUITitle="Snickerstream 0.6b (PoC) ", _
$aWinResize, $yBMP1=0, $yBMP2=240, $iLayoutmode=0

;Globals - Main GUI
Global $sIpAddr="0.0.0.0", $iPriorityMode=0, $iPriorityFactor=5, $iImageQuality=90, $iQoS=20

;Globals - Config
Global $sFname="settings.ini", $sSectionName="Snickerstream", $aIniSections[8] = ["IpAddr", "PriorityMode", "PriorityFactor", "ImageQuality", _
"QoS", "Interpolation", "Layoutmode", "PCIpAddr"], $sPCIpAddr=@IPAddress1

;Globals - Misc
Global $iExtraPriority=0, $hTimer=TimerInit(), $bStreaming=False

AutoItSetOption("GUIOnEventMode", 1)	;Use OnEvent mode - a script like this would be awful without it
AutoItSetOption("TCPTimeout",5000)

CreateMainGUIandSettings() ;Create the GUI
Do
	Sleep(100)
Until $bStreaming=True

Func StreamingLoop()
	UDPStartup()	;Start up the UDP protocol
	Global Const $iSocket = UDPBind($sPCIpAddr, "8001")	;Listen to port 8001

    _GDIPlus_Startup() ;initialize GDI+
    Local Const $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	Switch $iLayoutmode
		Case 0
			Global $iWidth = 400, $iHeight = 480	;Vertical view mode
			Local $iGUIWidthHeight=Default, $xGUIStyle=Default
		Case 1
			Global $iWidth = 400, $iHeight = 480	;TODO: Horizontal view mode
			Local $iGUIWidthHeight=Default, $xGUIStyle=Default
		Case 2
			Global $iWidth = 400, $iHeight = 480	;TODO: Top screen only view mode
			Local $iGUIWidthHeight=Default, $xGUIStyle=Default
	EndSwitch

	$g_hGUI = GUICreate($sGUITitle, $iWidth, $iHeight,$iGUIWidthHeight,$iGUIWidthHeight,$xGUIStyle) ;Create the GUI

	;In order to correctly resize the window, we need to get the difference between the graphics object width/height and the actual
	;window width/height. This difference is created by the window's borders and title bar
	$aWinResize=WinGetPos($g_hGUI)
	Global $iWidthDiff=$aWinResize[2]-$iWidth
	Global $iHeightDiff=$aWinResize[3]-$iHeight

    GUISetBkColor($iBgColor, $g_hGUI) ;Set GUI background color
    GUISetState(@SW_SHOW)

    ;Create buffered graphics frame set for smoother gfx object movements
    $g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;Create a graphics object from a window handle
    $g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGraphics)
    $g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)

    While 1
		_GDIPlus_BitmapDispose($g_hBMP)	;Dispose of the bitmap object for the prioritized screen. We need to do this or we'll get memory leaks!

		;TODO-START: Tidy up this region of code. Make a single function for uptading a screen to reduce code redundancy.
		Do
			$bJpeg=_NTRRemoteplayReadJPEG($iSocket,1)
		Until $bJpeg<>-1	;Loop until we get a good image for the top screen
		$iFPS+=1
		$g_hBMP=_GDIPlus_BitmapCreateFromMemory($bJpeg)	;Create a GDI+ Bitmap from the image that's stored in memory
		_GDIPlus_ImageRotateFlip($g_hBMP,3)	;The original image needs to be rotated
        _GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, 0, $yBMP1) ;Draw the bitmap to the backbuffer
		If $iExtraPriority>=5 Then	;If the bottomscreen frameskip counter has been reached, it's time to draw the other screen too
			$bJpeg2=_NTRRemoteplayReadJPEG($iSocket,0)
			If $bJpeg2<>-1 Then
				_GDIPlus_BitmapDispose($g_hBMP2)
				$g_hBMP2=_GDIPlus_BitmapCreateFromMemory($bJpeg2)
				_GDIPlus_ImageRotateFlip($g_hBMP2,3)
				_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP2, 40, $yBMP2) ;draw bitmap to backbuffer
				$iExtraPriority=0
				$iFPS+=1
			EndIf	;If we get a valid image, we do pretty much the same thing as the top screen
		EndIf
		;TODO-END

		$iExtraPriority+=1
		_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;Copy drawn bitmap to graphics handle (GUI)
		_GDIPlus_GraphicsSetInterpolationMode($g_hGraphics,$iInterpolation)	;Apparently, we need to set the interpolation mode each frame
		CheckKeys()	;Check the keys that are pressed to do various functions
	WEnd
EndFunc   ;==>Example

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
		$iWidth=$iWidth*2
		$iHeight=$iHeight*2
		$aWinResize=WinGetPos($g_hGUI)
		WinMove($g_hGUI,"",Default,Default,$iWidth+$iWidthDiff,$iHeight+$iHeightDiff)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
	EndIf
	If _CheckPressedOnce("28")==True Then
		$iWidth=$iWidth/2
		$iHeight=$iHeight/2
		$aWinResize=WinGetPos($g_hGUI)
		WinMove($g_hGUI,"",Default,Default,$iWidth+$iWidthDiff,$iHeight+$iHeightDiff)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
	EndIf
	If _CheckPressedOnce("25")==True Then
		If $iInterpolation>0 Then $iInterpolation-=1
	EndIf
	If _CheckPressedOnce("27")==True Then
		If $iInterpolation<7 Then $iInterpolation+=1
	EndIf
	If TimerDiff($hTimer)>=1000 Then
		$hTimer=TimerInit()
		WinSetTitle($g_hGUI,"",$sGUITitle&$iFPS&" FPS")
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
	Global $GUI_Interpolation = GUICtrlCreateCombo("", 322, 22, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	$Label7 = GUICtrlCreateLabel("Screen layout", 245, 48, 69, 17, $SS_CENTERIMAGE)
	Global $GUI_Layoutmode = GUICtrlCreateCombo("", 321, 48, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Vertical|Horizontal|Top screen only", "Vertical")
	Global $GUI_ConnectBtn = GUICtrlCreateButton("Connect!", 232, 120, 217, 33)
	Global $GUI_RemoteplayBtn = GUICtrlCreateButton("Start remoteplay", 344, 88, 105, 25)
	$Group1 = GUICtrlCreateGroup("Basic settings", 8, 8, 217, 145)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Adv. settings", 232, 8, 217, 73)
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
EndFunc

Func SendPacket()
	UpdateVars()
	$iRet = _NTRInitRemoteplay($sIpAddr, $iPriorityMode, $iPriorityFactor, $iImageQuality, $iQoS)
	If $iRet = -1 Then
		MsgBox($MB_ICONERROR, "Connection error", "Could not connect to the (N)3DS.")
	Else
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
	ConsoleWrite($sPCIpAddr)
	MsgBox($MB_ICONINFORMATION,"About Snickerstream",$sGUITitle&"by RattletraPM"&@CRLF&@CRLF&"This software and its source code are provided free of charge under the GPL-3.0 License. See License.txt for the full license.")
EndFunc

Func ExitMain()
	GUIDelete($SnickerstreamGUI)
	Exit
EndFunc

Func ExitStreaming()
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
