#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=res\snickerstream.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs
	___      _    _              _
	/ __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __
	\__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \
	|___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|

	By RattletraPM - licensed under GNU GPL V3.0
	Written for AutoIt v3.3.14.4

	TODO: You decide!

#ce

#include <AutoItConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GuiIPAddress.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <GuiComboBoxEx.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <String.au3>
#include <ScreenCapture.au3>
#include <WinAPIConv.au3>
#include <Crypt.au3>
#include "include\ntr.au3"
#include "include\WIC.au3"
#include "include\Direct2D.au3"
#include "include\GitAndGithub.au3"

;Globals - Streaming GUI and Drawing
Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hBMP2, $g_hGraphics, $iFPS = 0, $iInterpolation = 0, _
		$aWinResize, $ix1BMP1 = 0, $ix2BMP1 = 0, $ix1BMP2 = 0, $ix2BMP2 = 0, $iy1BMP1 = 0, $iy2BMP1 = 0, $iy1BMP2 = 0, $iy2BMP2 = 0, _
		$iLayoutmode = 0, $bNoDisplayIPWarn = 0, $bD2D = True, $iListenPort = 8001, $bFullscreenPopup = False
Global Const $sVersion = "v1.00 ", $sGUITitle = "Snickerstream " & $sVersion, $sIconPath=@TempDir&"\snickerstream.ico"

;Globals - Main and Advanced GUI
Global $sIpAddr = "0.0.0.0", $iPriorityMode = 0, $iPriorityFactor = 5, $iImageQuality = 70, $iQoS = 20, $AdvancedMenu = 0, $aHotkeys[8] = ["26","28","25","27","0D","53","20","1B"]

;Globals - Config
Global $sFname = @ScriptDir & "\settings.ini", $sPCIpAddr = $sIpAddr, $iLogLevel = 0
Global Const $sSectionName = "Snickerstream", $aIniSections[26] = ["IpAddr", "PriorityMode", "PriorityFactor", "ImageQuality", _
		"QoS", "Interpolation", "Layoutmode", "PCIpAddr", "NoDisplayIPWarn", "Loglevel", "DontCheckSettings", "UseD2D", "GDIPWarn", "NFCLastAnswer", _
		"WaitRemoteplayInit", "Framelimit", "ReturnAfterMsec", "DontCheckForUpdates", "CustomWidth", "CustomHeight", "ListenPort", "AdvWarning", "TopScalingFactor", _
		"BottomScalingFactor", "CenterScreens", "Hotkeys"], $sLogFname = "log.txt", $sSettingSeparator = "|"

;Globals - Misc Constants
Global Const $sSeparator = _StringRepeat("-", 33), $sGUI2 = "g_hGUI2"

;Globals - Misc
Global $hTimer = TimerInit(), $bStreaming = False

;Globals - GUI
Global $GUI_Rendering = 0, $GUI_Interpolation = 0 ;Those are here to prevent a "possibly used before declaration" warning (yes, the variables are declared before being used in a separate UDF but SciTE doesn't recognize it)

AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("GUIOnEventMode", 1) ;Use OnEvent mode - a script like this would be awful without it
AutoItSetOption("TCPTimeout", 5000)
AutoItSetOption("TrayAutoPause", 0)

FileInstall("snickerstream.ico",$sIconPath,1)

If $CmdLine[0] == 1 Then ;Custom settings.ini path
	$sFname = $CmdLine[1]
EndIf

;Globals - Custom presets INI
Global Static $sPresetFname = StringLeft($sFname, StringInStr($sFname, "\", 0, -1)) & "presets.ini", $sPresetSection = $sSectionName & "Presets"

;COM error handling
Global $oError = ObjEvent("AutoIt.Error", "_ErrFunc")
Func _ErrFunc()
	LogLine("COM Error, ScriptLine(" & $oError.ScriptLine & ") : Number 0x" & Hex($oError.Number, 8) & " - " & $oError.WinDescription & @CRLF, 1)
EndFunc   ;==>_ErrFunc

CreateMainGUIandSettings() ;Create the GUI
ButtonStateSet($GUI_DISABLE)
LogStart()
LogLine("WARNING: The loglevel is now set to 3. This will produce GIANT logfiles.", 3)
LogLine("You should set your loglevel to something else unless you're troubleshooting some issues!", 3)
LogLine("CPU: " & GetCPU(), 3)
LogLine("GPU: " & GetGPU(), 3)
LogLine("OS: " & @OSVersion, 3)

If (IsAdmin() == 1 And @Compiled == 1) And (StringLeft(@OSVersion, 6) <> "WIN_XP" And @OSVersion <> "WIN_2003") Then ;This feature is not supported in Windows XP/XPe/Server 2003
	LogLine("WARNING: Snickerstream was run as admin and will now allow itself in Windows Firewall.", 1)
	If FileExists(@SystemDir & "\netsh.exe") Then
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall delete rule name="Snickerstream"', Default, Default, @SW_HIDE)
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall add rule name="Snickerstream" dir=in action=allow program="' & @ScriptFullPath & '" enable=yes', Default, Default, @SW_HIDE)
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall add rule name="Snickerstream" dir=out action=allow program="' & @ScriptFullPath & '" enable=yes', Default, Default, @SW_HIDE)
		LogLine("Done. It's strongly recommended to run Snickerstream as a normal user from now on.", 1)
	Else
		LogLine("There was an error while adding an exception to Windows Firewall! Please add one manually from the control panel.", 1)
	EndIf
EndIf

CheckForUpdates()

If $__g_hD2D1DLL == -1 Then
	MsgBox($MB_ICONERROR, "Direct2D init error", "There was an error while initializing Direct2D." & @CRLF & @CRLF & "This error is most likely caused by using Snickerstream on an OS" & _
			" that doesn't support Direct2D (available on Windows Vista SP2 or later). You will still be able to use this tool, but you'll have to use GDI+ as its rendering library instead (no hardware" & _
			" acceleration and slower, check the readme for more info).")
	_GUICtrlComboBox_SetCurSel($GUI_Rendering, 1)
	GUICtrlSetState($GUI_Rendering, $GUI_DISABLE)
	GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	$bD2D = False
EndIf
ButtonStateSet($GUI_ENABLE)

Do
	Sleep(100)
Until $bStreaming = True

Func WinSetSize()
	If $ix2BMP1 >= $ix2BMP2 Then
		Global $iWidth = $ix2BMP1
	Else
		Global $iWidth = $ix2BMP2
	EndIf
	If $iy2BMP2 >= $iy2BMP1 Then
		Global $iHeight = Abs($iy2BMP1)
	Else
		Global $iHeight = Abs($iy2BMP2)
	EndIf
EndFunc   ;==>WinSetSize

Func CenterScreens()
	If $iLayoutmode == 0 Or $iLayoutmode == 1 Or (($iLayoutmode == 6 Or $iLayoutmode == 7 Or $iLayoutmode == 8 Or $iLayoutmode==9) And @DesktopWidth > @DesktopHeight) Then
		Local $iTopDiff = ($iWidth - $ix2BMP1) / 2
		Local $iBotDiff = ($iWidth - $ix2BMP2) / 2
		$ix1BMP1 += $iTopDiff
		$ix2BMP1 += $iTopDiff
		$ix1BMP2 += $iBotDiff
		$ix2BMP2 += $iBotDiff
	EndIf
	If $iLayoutmode == 2 Or $iLayoutmode == 3 Or (($iLayoutmode == 6 Or $iLayoutmode == 7 Or $iLayoutmode == 8 Or $iLayoutmode==9) And @DesktopWidth <= @DesktopHeight) Then
		Local $iTopDiff = ((-$iHeight) - $iy2BMP1) / 2
		Local $iBotDiff = ((-$iHeight) - $iy2BMP2) / 2
		$iy1BMP1 += $iTopDiff
		$iy2BMP1 += $iTopDiff
		$iy1BMP2 += $iBotDiff
		$iy2BMP2 += $iBotDiff
	EndIf
EndFunc   ;==>CenterScreens

Func ReadCustomHotkeys()
	Local $sReadHotkeys=IniRead($sFname, $sSectionName, $aIniSections[25], 0)

	If $sReadHotkeys<>0 Then
		$aNewHotkeys=StringSplit($sReadHotkeys, $sSettingSeparator)

		If UBound($aNewHotkeys)==9 Then
			_ArrayDelete($aNewHotkeys,0)
			$aHotkeys=$aNewHotkeys
		EndIf
	EndIf
EndFunc

Func StreamingLoop()

	;Read custom hotkeys
	ReadCustomHotkeys()

	Local $iTopScalingFactor = IniRead($sFname, $sSectionName, $aIniSections[22], 1)
	If $iLayoutmode == 8 Then ;For Fullscreen Top, non-stretched
		If @DesktopWidth > @DesktopHeight Then
			$iTopScalingFactor = @DesktopHeight / 240
		Else
			$iTopScalingFactor = @DesktopWidth / 240
		EndIf
	EndIf
	Local $iBotScalingFactor = IniRead($sFname, $sSectionName, $aIniSections[23], 1)
	If $iLayoutmode == 9 Then ;For Fullscreen Bottom, non-stretched
		If @DesktopWidth > @DesktopHeight Then
			$iBotScalingFactor = @DesktopHeight / 240
		Else
			$iBotScalingFactor = @DesktopWidth / 240
		EndIf
	EndIf

	If $bD2D == False Then ;_GDIPlus_GraphicsDrawImageRect() doesn't allow for resizing. I could use another func but it will just slow down streaming,
		$iTopScalingFactor = 1 ;and software mode is already slow as it is right now... so I simply decided to make individual screen scaling D2D only.
		$iBotScalingFactor = 1
	EndIf

	If $iTopScalingFactor < 0.3 Then $iTopScalingFactor = 1
	If $iBotScalingFactor < 0.3 Then $iBotScalingFactor = 1

	LogLine("PC IP address: " & $sPCIpAddr, 2)
	LogLine("3DS IP address: " & $sIpAddr, 2)
	LogLine("Priority: " & $iPriorityMode, 2)
	LogLine("Priority factor: " & $iPriorityFactor, 2)
	LogLine("Image quaility: " & $iImageQuality, 2)
	LogLine("QoS: " & $iQoS, 2)
	LogLine("Interpolation mode: " & $iInterpolation, 2)
	LogLine("Screen layout: " & $iLayoutmode, 2)
	LogLine("Using Direct2D: " & $bD2D, 2)
	LogLine("Listening port: " & $iListenPort, 2)
	LogLine("Top Screen scaling factor: " & $iTopScalingFactor, 2)
	LogLine("Bottom Screen scaling factor: " & $iBotScalingFactor, 2)
	LogLine("-NOTE- The IP addresses should be internal. If you set them to public DO NOT share this log online!", 2)
	UDPStartup() ;Start up the UDP protocol
	Global $iSocket = UDPBind($sPCIpAddr, $iListenPort) ;Listen to whatever port has been specified by the user (default=8001)
	Local $iBGColor = 0x303030 ;$iBGColor format RRGGBB

	;Settings for Vertical (default) view mode - GUI Width & Height
	Local $iGUIWidthHeight = Default, $xGUIStyle = Default, $xGUIExStyle = Default
	Global $ix1BMP1 = 0, $ix2BMP1 = 400 * $iTopScalingFactor, $iy1BMP1 = 0, $iy2BMP1 = -240 * $iTopScalingFactor ;Top screen
	Global $ix1BMP2 = 0, $ix2BMP2 = 320 * $iBotScalingFactor, $iy1BMP2 = $iy2BMP1, $iy2BMP2 = $iy2BMP1 + (-240 * $iBotScalingFactor) ;Bottom screen
	Switch $iLayoutmode ;View modes
		Case 1 ;Vertical (inverted)
			Global $ix1BMP2 = 0, $ix2BMP2 = 320 * $iBotScalingFactor, $iy1BMP2 = 0, $iy2BMP2 = -240 * $iBotScalingFactor ;Bottom screen
			Global $ix1BMP1 = 0, $ix2BMP1 = 400 * $iTopScalingFactor, $iy1BMP1 = $iy2BMP2, $iy2BMP1 = $iy1BMP1 + (-240 * $iTopScalingFactor) ;Top screen
		Case 2 ;Horizontal
			Global $ix1BMP2 = $ix2BMP1, $ix2BMP2 = $ix2BMP1 + (320 * $iBotScalingFactor), $iy1BMP2 = 0, $iy2BMP2 = -240 * $iBotScalingFactor ;Bottom screen
		Case 3 ;Horizontal (inverted)
			Global $ix1BMP1 = $ix2BMP2, $ix2BMP1 = $ix2BMP2 + (400 * $iTopScalingFactor), $iy1BMP1 = 0, $iy2BMP1 = -240 * $iTopScalingFactor ;Top screen
			Global $ix1BMP2 = 0, $ix2BMP2 = 320 * $iBotScalingFactor, $iy1BMP2 = 0, $iy2BMP2 = -240 * $iBotScalingFactor ;Bottom screen
		Case 4 ;Top only
			Global $iWidth = 400 * $iTopScalingFactor, $iHeight = 240 * $iTopScalingFactor
			Global $ix1BMP1 = 0, $ix2BMP1 = $iWidth, $iy1BMP1 = 0, $iy2BMP1 = -$iHeight ;Top screen
			CheckOptimal()
		Case 5 ;Bottom only
			Global $iWidth = 320 * $iBotScalingFactor, $iHeight = 240 * $iBotScalingFactor
			Global $ix1BMP2 = 0, $ix2BMP2 = $iWidth, $iy1BMP2 = 0, $iy2BMP2 = -$iHeight ;Bottom screen
			CheckOptimal()
		Case 6 ;Fullscreen Top (stretched)
			Local $iGUIWidthHeight = 0, $xGUIStyle = $WS_POPUP, $xGUIExStyle = $WS_EX_TOPMOST ;I'm sorry for the spaghetti code for modes 6-7-8-9, but AutoIt doesn't support
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight ;Or statements in switches, and a separate func won't do much better due to local variables and stuff...
			Global $ix1BMP1 = 0, $ix2BMP1 = $iWidth, $iy1BMP1 = 0, $iy2BMP1 = -$iHeight ;Top screen
			CheckOptimal()
		Case 7 ;Fullscreen Bot (stretched)
			Local $iGUIWidthHeight = 0, $xGUIStyle = $WS_POPUP, $xGUIExStyle = $WS_EX_TOPMOST
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight
			Global $ix1BMP2 = 0, $ix2BMP2 = $iWidth, $iy1BMP2 = 0, $iy2BMP2 = -$iHeight ;Bottom screen
			CheckOptimal()
		Case 8 ;Fullscreen Top (non-stretched)
			Local $iGUIWidthHeight = 0, $xGUIStyle = $WS_POPUP, $xGUIExStyle = $WS_EX_TOPMOST
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight
			Global $ix1BMP1 = 0, $ix2BMP1 = 400 * $iTopScalingFactor, $iy1BMP1 = 0, $iy2BMP1 = -240 * $iTopScalingFactor ;Top screen
			CheckOptimal()
		Case 9 ;Fullscreen Bot (non-stretched)
			Local $iGUIWidthHeight = 0, $xGUIStyle = $WS_POPUP, $xGUIExStyle = $WS_EX_TOPMOST
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight
			Global $ix1BMP2 = 0, $ix2BMP2 = 320 * $iBotScalingFactor, $iy1BMP2 = 0, $iy2BMP2 = -240 * $iBotScalingFactor ;Bottom screen
			CheckOptimal()
		Case 10 ;Separate windows
			Global $iWidth = 400 * $iTopScalingFactor, $iHeight = 240 * $iTopScalingFactor ;Window 1
			Global $ix1BMP1 = 0, $ix2BMP1 = $iWidth, $iy1BMP1 = 0, $iy2BMP1 = -$iHeight ;Top screen
			Global $iWidth2 = 320 * $iBotScalingFactor, $iHeight2 = 240 * $iBotScalingFactor ;Window 2
			Global $ix1BMP2 = 0, $ix2BMP2 = $iWidth2, $iy1BMP2 = 0, $iy2BMP2 = -$iHeight2 ;Bottom screen
	EndSwitch

	;Needed for pop-up secondary screen
	If $iLayoutmode>5 And $iLayoutMode<>10 Then
		Local $oJpegBuf=""	;Extra framebuffer for D2D fullscreen modes, needed for pop-up second screen
		If $iLayoutmode==6 Or $iLayoutmode==8 Then
			Global $ix1BMP2 = 0, $ix2BMP2 = 320*$iBotScalingFactor, $iy1BMP2 = -$iHeight, $iy2BMP2 = -$iHeight+(240*$iBotScalingFactor) ;Bottom screen
		Else
			Global $ix1BMP1 = 0, $ix2BMP1 = 400*$iTopScalingFactor, $iy1BMP1 = -$iHeight, $iy2BMP1 = -$iHeight+(240*$iTopScalingFactor) ;Top screen
		EndIf
	EndIf

	If $iLayoutmode < 4 Then WinSetSize()
	If IniRead($sFname, $sSectionName, $aIniSections[24], 1)==1 Then CenterScreens()

	Local Const $iCustomWidth = IniRead($sFname, $sSectionName, $aIniSections[18], 0)
	Local Const $iCustomHeight = IniRead($sFname, $sSectionName, $aIniSections[19], 0)

	If $iCustomWidth >= 150 Then $iWidth = $iCustomWidth
	If $iCustomHeight >= 200 Then $iHeight = $iCustomHeight

	Global $g_hGUI = GUICreate($sSectionName & " - Connecting...", $iWidth, $iHeight, $iGUIWidthHeight, $iGUIWidthHeight, $xGUIStyle, $xGUIExStyle) ;Create the GUI
	GUISetBkColor(0, $g_hGUI)

	;In order to correctly resize the window, we need to get the difference between the graphics object width/height and the actual
	;window width/height. This difference is created by the window's borders and title bar
	$aWinResize = WinGetPos($g_hGUI)
	Global $iWidthDiff = $aWinResize[2] - $iWidth
	Global $iHeightDiff = $aWinResize[3] - $iHeight

	GUISetState(@SW_SHOW, $g_hGUI)

	;Create buffered graphics frame set for smoother gfx object movements
	If $bD2D == True Then ;Init Direct2D
		Global $oD2D_Factory = _D2D_Factory_Create()
		Global $tMatrix_Rotate = _D2D_Matrix3x2_Rotation(-90, 0, 0)
		Global $oD2D_HwndRenderTarget = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI, $iWidth, $iHeight)
	Else ;Init GDI+
		_GDIPlus_Startup()
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;Create a graphics object from a window handle
		If $iLayoutmode < 6 Then
			$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGraphics)
		ElseIf $iLayoutmode == 6 Then
			$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics(400, 240, $g_hGraphics)
		ElseIf $iLayoutmode == 7 Then
			$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics(320, 240, $g_hGraphics)
		EndIf
		$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)
	EndIf
	CheckIfStreaming($sIpAddr)

	If $iLayoutmode == 10 And $bStreaming==True Then	;Create the secondary window if layout mode is separate windows
		Global $g_hGUI2 = GUICreate($sSectionName & " - Bottom scr.", $iWidth2, $iHeight2, $iGUIWidthHeight, $iGUIWidthHeight, $xGUIStyle, $xGUIExStyle) ;Create the GUI
		GUISetBkColor(0, $g_hGUI2)
		GUISetState(@SW_SHOW, $g_hGUI2)
		Global $oD2D_HwndRenderTarget2 = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI2, $iWidth2, $iHeight2)
	EndIf

	Local $iFramelock = IniRead($sFname, $sSectionName, $aIniSections[15], 0), $iReturnAfter = IniRead($sFname, $sSectionName, $aIniSections[16], 8000), $iFramelockedFPS = 0, _
			$iTimerWaitExit = TimerInit(), $sFPSString = " FPS", $sWinTitle = ""

	While $bStreaming == True
		Local $iFrameTimer = TimerInit()
		If WinActive($g_hGUI) == $g_hGUI Or (IsDeclared($sGUI2) And WinActive($g_hGUI2)==$g_hGUI2) Then CheckKeys() ;Check the keys that are pressed to do various functions
		$aJpeg = _NTRRemoteplayReadJPEG($iSocket)
		If IsArray($aJpeg) Then
			$iFPS += 1
			If $bD2D == True Then
				$oBitmap = __D2D_LoadImageFromMemory($aJpeg[1], $aJpeg[0]) ;Create a D2D image from the image that's stored in memory
				$oD2D_HwndRenderTarget.BeginDraw()
				$oD2D_HwndRenderTarget.SetTransform($tMatrix_Rotate)
				If $aJpeg[0] == 1 And $iLayoutmode <> 5 Then
					;-240 because we rotate the image of -90 degrees and we've chosen 0,0 as the transformation's origin, so the image falls "on top" of the rendering area
					;Also, Width and Height are inverted because the render target is rotated
					If $iLayoutmode<>7 And $iLayoutmode<>9 Then $oD2D_HwndRenderTarget.DrawBitmap($oBitmap, _D2D1_RECT_F($iy1BMP1, $ix1BMP1, $iy2BMP1, $ix2BMP1), 1, Int(Not $iInterpolation), Null)
					If ($iLayoutmode==7 Or $iLayoutmode==9) And $bFullscreenPopup==True Then $oJpegBuf=$oBitmap
				ElseIf $aJpeg[0] == 0 And ($iLayoutmode <> 4 And $iLayoutmode <> 10) Then
					If $iLayoutmode<>6 And $iLayoutmode<>8 Then $oD2D_HwndRenderTarget.DrawBitmap($oBitmap, _D2D1_RECT_F($iy1BMP2, $ix1BMP2, $iy2BMP2, $ix2BMP2), 1, Int(Not $iInterpolation), Null)
					If ($iLayoutmode==6 Or $iLayoutmode==8) And $bFullscreenPopup==True Then $oJpegBuf=$oBitmap
				EndIf

				If ($iLayoutmode==6 Or $iLayoutMode==8) And $bFullscreenPopup==True And IsObj($oJpegBuf) Then	;Draw the other screen if fullscreen popup is enabled
					$oD2D_HwndRenderTarget.DrawBitmap($oJpegBuf, _D2D1_RECT_F($iy1BMP2, $ix1BMP2, $iy2BMP2, $ix2BMP2), 1, Int(Not $iInterpolation), Null)
				ElseIf ($iLayoutmode==7 Or $iLayoutMode==9) And $bFullscreenPopup==True And IsObj($oJpegBuf) Then
					$oD2D_HwndRenderTarget.DrawBitmap($oJpegBuf, _D2D1_RECT_F($iy1BMP1, $ix1BMP1, $iy2BMP1, $ix2BMP1), 1, Int(Not $iInterpolation), Null)
				EndIf

				$oD2D_HwndRenderTarget.EndDraw(0, 0)
				If $aJpeg[0] == 0 And $iLayoutmode == 10 Then
					$oD2D_HwndRenderTarget2.BeginDraw()
					$oD2D_HwndRenderTarget2.SetTransform($tMatrix_Rotate)
					$oD2D_HwndRenderTarget2.DrawBitmap($oBitmap, _D2D1_RECT_F($iy1BMP2, $ix1BMP2, $iy2BMP2, $ix2BMP2), 1, Int(Not $iInterpolation), Null)
					$oD2D_HwndRenderTarget2.EndDraw(0, 0)
				EndIf
			Else
				DisplayScreenGDIPlus($aJpeg[0], $aJpeg[1])
				_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;Copy drawn bitmap to graphics handle (GUI)
				_GDIPlus_GraphicsSetInterpolationMode($g_hGraphics, $iInterpolation) ;We need to set the interpolation mode each frame in case the mode gets changed
			EndIf
			Local $iRemainingTime = TimerDiff($iFrameTimer) + ((1000 / $iFramelock) - TimerDiff($iFrameTimer))
			If $iFramelock > 0 And $aJpeg[0] == $iPriorityMode Then
				$iFramelockedFPS += 1
				While TimerDiff($iFrameTimer) <= $iRemainingTime ;Nothing (it doesn't use the Sleep function because it's limited to a minimum of 10ms, read the function ref)
				WEnd
			EndIf
			$iTimerWaitExit = TimerInit()
		EndIf
		If TimerDiff($hTimer) >= 1000 Then
			$hTimer = TimerInit()
			If $iFramelock = 0 Then
				$sWinTitle = $sSectionName & " - " & $iFPS & $sFPSString
			Else
				$sWinTitle = $sSectionName & " - " & $iFPS & $sFPSString & ", screen" & $iPriorityMode & " " & $iFramelockedFPS & $sFPSString
				$iFramelockedFPS = 0
			EndIf
			If $iListenPort <> 8001 Then $sWinTitle &= ", port " & $iListenPort
			WinSetTitle($g_hGUI, "", $sWinTitle)
			LogLine("FPS:" & $iFPS, 3)
			$iFPS = 0
		EndIf
		If $iReturnAfter > 0 And TimerDiff($iTimerWaitExit) >= $iReturnAfter Then
			LogLine("(N)3DS hasn't been sending frames for more than " & $iReturnAfter & "msecs, returning to the connection window.", 1)
			ReturnToConnectionWnd()
		EndIf
	WEnd
EndFunc   ;==>StreamingLoop

Func DisplayScreenGDIPlus($iScreen, ByRef $bRawJpeg)
	$g_hBMP = _GDIPlus_BitmapCreateFromMemory($bRawJpeg) ;Create a GDI+ Bitmap from the image that's stored in memory
	_GDIPlus_ImageRotateFlip($g_hBMP, 3) ;The original image needs to be rotated
	If $iScreen == 1 And $iLayoutmode <> 5 And $iLayoutmode <> 7 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $ix1BMP1, $iy1BMP1 * -1) ;Draw the bitmap to the backbuffer
	ElseIf $iScreen = 0 And $iLayoutmode <> 4 And $iLayoutmode <> 6 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $ix1BMP2, $iy1BMP2 * -1) ;draw bitmap to backbuffer
	EndIf
	_GDIPlus_BitmapDispose($g_hBMP)
EndFunc   ;==>DisplayScreenGDIPlus

Func __D2D_LoadImageFromMemory($dData, $iScreen)
	Local $oWIC_ImagingFactory = _WIC_ImagingFactory_Create()

	Local $tImage = DllStructCreate("byte Data[" & BinaryLen($dData) & "]")
	$tImage.Data = $dData

	Local $oWIC_Stream = _WIC_ImagingFactory_CreateStream($oWIC_ImagingFactory)
	$oWIC_Stream.InitializeFromMemory($tImage, DllStructGetSize($tImage))

	Local $oWIC_BitmapDecoder = _WIC_ImagingFactory_CreateDecoderFromStream($oWIC_ImagingFactory, $oWIC_Stream)
	If @error Then Exit MsgBox(0, "Error", _D2D_ErrorMessage(@error))

	Local $oWIC_Bitmap = _WIC_BitmapDecoder_GetFrame($oWIC_BitmapDecoder)
	Local $oWIC_FormatConverter = _WIC_ImagingFactory_CreateFormatConverter($oWIC_ImagingFactory)
	Local $tGUID_WICPixelFormat32bppPBGRA = _WinAPI_GUIDFromString($sGUID_WICPixelFormat32bppPBGRA)
	$oWIC_FormatConverter.Initialize($oWIC_Bitmap, $tGUID_WICPixelFormat32bppPBGRA, 0, 0, 0, 1)

	If $iLayoutmode <> 10 Or $iScreen == 1 Then
		Local $oD2D_Bitmap = _D2D_RenderTarget_CreateBitmapFromWicBitmap($oD2D_HwndRenderTarget, $oWIC_FormatConverter)
	ElseIf $iLayoutmode == 10 And $iScreen == 0 Then
		Local $oD2D_Bitmap = _D2D_RenderTarget_CreateBitmapFromWicBitmap($oD2D_HwndRenderTarget2, $oWIC_FormatConverter)
	EndIf

	Return $oD2D_Bitmap
EndFunc   ;==>__D2D_LoadImageFromMemory

Func CheckOptimal()
	Local $sMsg1 = "It looks like your remoteplay settings aren't optimal. You should change:" & @CRLF & @CRLF
	Local $sMsg2 = @CRLF & "then restart NTR CFW to achieve the best possible performance!" & @CRLF & @CRLF & _
			"Click OK to close this message or Cancel if you don't want to be warned about your settings ever again."
	Local $bNotOptimal = False

	If ($iLayoutmode == 4 Or $iLayoutmode == 6 Or $iLayoutmode == 8) And $iPriorityMode == 0 Then
		$sMsg1 = $sMsg1 & "* Priority mode to Top Screen" & @CRLF
		$bNotOptimal = True
	EndIf
	If ($iLayoutmode == 5 Or $iLayoutmode == 7 Or $iLayoutmode == 9) And $iPriorityMode == 1 Then
		$sMsg1 = $sMsg1 & "* Priority mode to Bottom Screen" & @CRLF
		$bNotOptimal = True
	EndIf
	If $iPriorityFactor > 0 Then
		$sMsg1 = $sMsg1 & "* Priority factor to 0" & @CRLF
		$bNotOptimal = True
	EndIf

	If $bNotOptimal = True And IniRead($sFname, $sSectionName, $aIniSections[10], 0) == 0 Then
		$iMsgBoxAnswer = MsgBox(49, "Warning!", $sMsg1 & $sMsg2)
		Select
			Case $iMsgBoxAnswer = 2 ;Cancel selected
				IniWrite($sFname, $sSectionName, $aIniSections[10], 1)
		EndSelect
	EndIf
EndFunc   ;==>CheckOptimal

Func _CheckPressedOnce($key)
	If Not IsDeclared($key & "IsPressed") Then
		Assign($key & "IsPressed", False, 2)
	EndIf

	If _IsPressed($key) And Eval($key & "IsPressed") == False Then
		Assign($key & "IsPressed", True, 4)
		Return True
	ElseIf _IsPressed($key) == False And Eval($key & "IsPressed") == True Then
		Assign($key & "IsPressed", False, 4)
		Return False
	EndIf
EndFunc   ;==>_CheckPressedOnce

Func ReturnToConnectionWnd()
	LogLine("Returning to the connection window.", 1)
	$bStreaming = False
	UDPCloseSocket($iSocket)
	UDPShutdown()
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	If $iLayoutmode == 10 Then GUIDelete($g_hGUI2)
	CreateMainGUIandSettings()
EndFunc   ;==>ReturnToConnectionWnd

Func CheckKeys()
	;Ehh... I guess it's a bit more polished now?
	If _CheckPressedOnce($aHotkeys[0]) == True Then
		ScaleGUI(1.2, False)
	EndIf
	If _CheckPressedOnce($aHotkeys[1]) == True And $iHeight >= 200 Then
		ScaleGUI(1.2, True)
	EndIf
	If _CheckPressedOnce($aHotkeys[2]) == True Then
		If $bD2D == True Then
			$iInterpolation = Int(Not $iInterpolation)
		Else
			If $iInterpolation > 0 Then $iInterpolation -= 1
		EndIf
		LogLine("Interpolation mode changed to " & $iInterpolation & ".", 1)
	EndIf
	If _CheckPressedOnce($aHotkeys[3]) == True Then
		If $bD2D == True Then
			$iInterpolation = Int(Not $iInterpolation)
		Else
			If $iInterpolation < 7 Then $iInterpolation += 1
		EndIf
		LogLine("Interpolation mode changed to " & $iInterpolation & ".", 1)
	EndIf
	If _CheckPressedOnce($aHotkeys[4]) == True Then
		ReturnToConnectionWnd()
	EndIf
	If _CheckPressedOnce($aHotkeys[5]) == True Then
		CaptureScreenshot($g_hGUI,1)
		If IsDeclared($sGUI2) Then CaptureScreenshot($g_hGUI2,0)
	EndIf
	If _CheckPressedOnce($aHotkeys[6]) == True Then $bFullscreenPopup = Not $bFullscreenPopup
	If _IsPressed($aHotkeys[7]) Then ExitStreaming()
EndFunc   ;==>CheckKeys

Func CaptureScreenshot($hGUI,$iGUI)
	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", 0)
	DllStructSetData($tPoint, "Y", 0)
	_WinAPI_ClientToScreen($hGUI, $tPoint)
	Local $iAbsoluteX = DllStructGetData($tPoint, "X")
	Local $iAbsoluteY = DllStructGetData($tPoint, "Y")
	If $iGUI==1 Then
		_ScreenCapture_Capture("screenshot" & @MDAY & @MON & @YEAR & @HOUR & @MIN & @SEC & @MSEC & $iGUI & ".bmp", $iAbsoluteX, $iAbsoluteY, ($iWidth + $iAbsoluteX) - 1, ($iHeight + $iAbsoluteY) - 1, False)
	Else
		_ScreenCapture_Capture("screenshot" & @MDAY & @MON & @YEAR & @HOUR & @MIN & @SEC & @MSEC & $iGUI & ".bmp", $iAbsoluteX, $iAbsoluteY, ($iWidth2 + $iAbsoluteX) - 1, ($iHeight2 + $iAbsoluteY) - 1, False)
	EndIf
EndFunc

Func ScaleGUI($iMultiplier, $bDivision)
	If $iLayoutmode < 6 Or $iLayoutmode==10 Then
		If $bDivision == False Then
			$iWidth = $iWidth * $iMultiplier ;GUI
			$iHeight = $iHeight * $iMultiplier
			If IsDeclared($sGUI2) Then
				$iWidth2 = $iWidth2 * $iMultiplier ;GUI
				$iHeight2 = $iHeight2 * $iMultiplier
			EndIf
			$ix1BMP1 = $ix1BMP1 * $iMultiplier ;Top screen
			$ix2BMP1 = $ix2BMP1 * $iMultiplier
			$iy1BMP1 = $iy1BMP1 * $iMultiplier
			$iy2BMP1 = $iy2BMP1 * $iMultiplier
			$ix1BMP2 = $ix1BMP2 * $iMultiplier ;Bottom screen
			$ix2BMP2 = $ix2BMP2 * $iMultiplier
			$iy1BMP2 = $iy1BMP2 * $iMultiplier
			$iy2BMP2 = $iy2BMP2 * $iMultiplier
		Else
			$iWidth = $iWidth / $iMultiplier ;GUI
			$iHeight = $iHeight / $iMultiplier
			If IsDeclared($sGUI2) Then
				$iWidth2 = $iWidth2 / $iMultiplier ;GUI
				$iHeight2 = $iHeight2 / $iMultiplier
			EndIf
			$ix1BMP1 = $ix1BMP1 / $iMultiplier ;Top screen
			$ix2BMP1 = $ix2BMP1 / $iMultiplier
			$iy1BMP1 = $iy1BMP1 / $iMultiplier
			$iy2BMP1 = $iy2BMP1 / $iMultiplier
			$ix1BMP2 = $ix1BMP2 / $iMultiplier ;Bottom screen
			$ix2BMP2 = $ix2BMP2 / $iMultiplier
			$iy1BMP2 = $iy1BMP2 / $iMultiplier
			$iy2BMP2 = $iy2BMP2 / $iMultiplier
		EndIf
		$aWinResize = WinGetPos($g_hGUI)
		WinMove($g_hGUI, "", Default, Default, $iWidth + $iWidthDiff, $iHeight + $iHeightDiff)
		If IsDeclared($sGUI2) Then
			$aWinResize2 = WinGetPos($g_hGUI2)
			WinMove($g_hGUI2, "", Default, Default, $iWidth2 + $iWidthDiff, $iHeight2 + $iHeightDiff)
		EndIf
		If $bD2D == True Then
			$oD2D_HwndRenderTarget = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI, $iWidth, $iHeight)
			If IsDeclared($sGUI2) Then  $oD2D_HwndRenderTarget2 = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI2, $iWidth2, $iHeight2)
		Else
			_GDIPlus_GraphicsDispose($g_hGraphics)
			$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
		EndIf
		LogLine("Window size increased to " & $iWidth & "x" & $iHeight & ".", 1)
	EndIf
EndFunc   ;==>ScaleGUI

Func CheckPCIP()
	If $bNoDisplayIPWarn == 0 And $sPCIpAddr <> "0.0.0.0" Then
		Local $iWarnButPressed = MsgBox($MB_ICONWARNING + $MB_YESNO, "Warning!", "You've set a specific IP address for your PC in the configuration file. This isn't needed in most cases and will pro" & _
				"bably result in a grey screen when trying to connect to your 3DS." & @CRLF & @CRLF & "Press Yes to revert this setting to the default value and listen to all IPs associated with your comput" & _
				"ers (recommended) or No to keep your custom setting and never display this warning anymore.")
		If $iWarnButPressed == $IDYES Then
			IniWrite($sFname, $sSectionName, $aIniSections[7], "0.0.0.0")
			$sPCIpAddr = "0.0.0.0"
		ElseIf $iWarnButPressed == $IDNO Then
			IniWrite($sFname, $sSectionName, $aIniSections[8], 1)
		EndIf
	EndIf
EndFunc

Func CreateMainGUIandSettings()
	;Check if the config file exists. If not, create one with the default config in it.
	If FileExists($sFname) Then
		$sIpAddr = IniRead($sFname, $sSectionName, $aIniSections[0], $sIpAddr)
		$iPriorityMode = IniRead($sFname, $sSectionName, $aIniSections[1], $iPriorityMode)
		$iPriorityFactor = IniRead($sFname, $sSectionName, $aIniSections[2], $iPriorityFactor)
		$iImageQuality = IniRead($sFname, $sSectionName, $aIniSections[3], $iImageQuality)
		$iQoS = IniRead($sFname, $sSectionName, $aIniSections[4], $iQoS)
		$iInterpolation = IniRead($sFname, $sSectionName, $aIniSections[5], $iInterpolation)
		$iLayoutmode = IniRead($sFname, $sSectionName, $aIniSections[6], $iLayoutmode)
		$sPCIpAddr = IniRead($sFname, $sSectionName, $aIniSections[7], @IPAddress1)
		$bNoDisplayIPWarn = IniRead($sFname, $sSectionName, $aIniSections[8], 0)
		$iLogLevel = IniRead($sFname, $sSectionName, $aIniSections[9], $iLogLevel)
		$bD2D = IniRead($sFname, $sSectionName, $aIniSections[11], $bD2D)
		$iListenPort = IniRead($sFname, $sSectionName, $aIniSections[20], $iListenPort)
		CheckPCIP()
	Else
		WriteConfig()
		;If we use WriteConfig for the first time, the written priority mode value will be wrong. We'll (over)write the right one with
		;this small piece of code.
		IniWrite($sFname, $sSectionName, $aIniSections[1], Int($iPriorityMode))
	EndIf

	;This region has been generated by KODA, then changed slightly manually
	#Region ### START Koda GUI section ### Form=\gui\snickerstreamgui.kxf
	Global $SnickerstreamGUI = GUICreate($sGUITitle, 459, 202)
	$Label1 = GUICtrlCreateLabel("IP", 24, 26, 14, 17, $SS_CENTERIMAGE)
	$Label2 = GUICtrlCreateLabel("Screen priority", 24, 52, 71, 17, $SS_CENTERIMAGE)
	$Label3 = GUICtrlCreateLabel("Priority factor", 24, 82, 65, 17, $SS_CENTERIMAGE)
	$Label4 = GUICtrlCreateLabel("Image quality", 24, 106, 66, 17, $SS_CENTERIMAGE)
	$Label5 = GUICtrlCreateLabel("QoS Value", 24, 130, 55, 17, $SS_CENTERIMAGE)
	Global $GUI_IpAddr = _GUICtrlIpAddress_Create($SnickerstreamGUI, 104, 24, 105, 17)
	_GUICtrlIpAddress_Set($GUI_IpAddr, "0.0.0.0")
	Global $GUI_PriorityMode = GUICtrlCreateCombo("", 104, 50, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Top screen|Bottom screen", "Top screen")
	Global $GUI_PriorityFactor = GUICtrlCreateInput("5", 104, 80, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	Global $GUI_ImageQuality = GUICtrlCreateInput("90", 104, 104, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	Global $GUI_QoS = GUICtrlCreateInput("20", 104, 128, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	$Label6 = GUICtrlCreateLabel("Interpolation", 245, 56, 62, 17, $SS_CENTERIMAGE)
	Global $GUI_Interpolation = GUICtrlCreateCombo("", 321, 54, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Linear|Nearest neighbor", "Linear")
	$Label7 = GUICtrlCreateLabel("Screen layout", 245, 80, 69, 17, $SS_CENTERIMAGE)
	Global $GUI_Layoutmode = GUICtrlCreateCombo("", 321, 80, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top,st.)|Fullscreen(Bot,st.)|Fullscreen(Top)|Fullscreen(Bot)|Separate windows", "Vertical")
	Global $GUI_ConnectBtn = GUICtrlCreateButton("Connect!", 232, 160, 217, 33)
	Global $GUI_NFCBtn = GUICtrlCreateButton("NFC patch", 384, 128, 65, 25)
	$Group1 = GUICtrlCreateGroup("Remoteplay settings", 8, 8, 217, 185)
	Global $GUI_Preset = GUICtrlCreateCombo("", 103, 160, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	LoadPresets()
	GUICtrlSetOnEvent(-1, "GUI_PresetChange")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Display settings", 232, 8, 217, 105)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $GUI_AboutBtn = GUICtrlCreateButton("About", 232, 128, 65, 25)
	$Label8 = GUICtrlCreateLabel("Rendering", 245, 32, 53, 17, $SS_CENTERIMAGE)
	Global $GUI_Rendering = GUICtrlCreateCombo("", 322, 27, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Direct2D (hw/sw)|GDI+ (sw)", "Direct2D (hw/sw)")
	GUICtrlSetOnEvent(-1, "GUI_RenderingChange")
	$Label9 = GUICtrlCreateLabel("Preset", 25, 162, 34, 17, $SS_CENTERIMAGE)
	Global $GUI_AdvButton = GUICtrlCreateButton("Advanced", 304, 128, 73, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	;Set the limit for the inputs
	GUICtrlSetLimit($GUI_PriorityFactor, 3)
	GUICtrlSetLimit($GUI_ImageQuality, 3)
	GUICtrlSetLimit($GUI_QoS, 3)

	;This is needed in case the config file was loaded so it'll be shown correctly
	_GUICtrlIpAddress_Set($GUI_IpAddr, $sIpAddr)
	_GUICtrlComboBox_SetCurSel($GUI_PriorityMode, $iPriorityMode)
	GUICtrlSetData($GUI_PriorityFactor, $iPriorityFactor)
	GUICtrlSetData($GUI_ImageQuality, $iImageQuality)
	GUICtrlSetData($GUI_QoS, $iQoS)
	If $bD2D == True And $iInterpolation > 1 Then ;Failsafe in case we get an invalid interpolation mode for D2D
		$iInterpolation = 0
	EndIf
	If $bD2D == True Then
		_GUICtrlComboBox_SetCurSel($GUI_Rendering, 0)
	Else
		_GUICtrlComboBox_SetCurSel($GUI_Rendering, 1)
		GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
		GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top,st.)|Fullscreen(Bot,st.)", "Vertical")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation, $iInterpolation)
	_GUICtrlComboBox_SetCurSel($GUI_Layoutmode, $iLayoutmode)

	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitMain", $SnickerstreamGUI)
	GUICtrlSetOnEvent($GUI_AboutBtn, "AboutScreen")
	GUICtrlSetOnEvent($GUI_NFCBtn, "SendNFC")
	GUICtrlSetOnEvent($GUI_ConnectBtn, "StartStream")
	GUICtrlSetOnEvent($GUI_AdvButton, "AdvMenu")
EndFunc   ;==>CreateMainGUIandSettings

Func UpdateVars()
	;We need to call this function when the user clicked on connect/saving presets to correctly update the variables
	$sIpAddr = _GUICtrlIpAddress_Get($GUI_IpAddr)
	$iPriorityMode = Int(Not _GUICtrlComboBox_GetCurSel($GUI_PriorityMode))
	$iPriorityFactor = Int(GUICtrlRead($GUI_PriorityFactor))
	$iImageQuality = Int(GUICtrlRead($GUI_ImageQuality))
	If $iImageQuality < 10 Then $iImageQuality = 10
	$iQoS = Int(GUICtrlRead($GUI_QoS))
	$iInterpolation = Int(_GUICtrlComboBox_GetCurSel($GUI_Interpolation))
	$iLayoutmode = Int(_GUICtrlComboBox_GetCurSel($GUI_Layoutmode))
EndFunc   ;==>UpdateVars

Func WriteConfig()
	IniWrite($sFname, $sSectionName, $aIniSections[0], $sIpAddr)
	IniWrite($sFname, $sSectionName, $aIniSections[1], Int(Not $iPriorityMode))
	IniWrite($sFname, $sSectionName, $aIniSections[2], $iPriorityFactor)
	IniWrite($sFname, $sSectionName, $aIniSections[3], $iImageQuality)
	IniWrite($sFname, $sSectionName, $aIniSections[4], $iQoS)
	IniWrite($sFname, $sSectionName, $aIniSections[5], $iInterpolation)
	IniWrite($sFname, $sSectionName, $aIniSections[6], $iLayoutmode)
	IniWrite($sFname, $sSectionName, $aIniSections[7], $sPCIpAddr)
	IniWrite($sFname, $sSectionName, $aIniSections[9], $iLogLevel)
	IniWrite($sFname, $sSectionName, $aIniSections[11], $bD2D)
	If IniRead($sFname, $sSectionName, $aIniSections[14], -1) < 0 Then IniWrite($sFname, $sSectionName, $aIniSections[14], 1000)
	IniWrite($sFname, $sSectionName, $aIniSections[20], $iListenPort)
	If IniRead($sFname, $sSectionName, $aIniSections[25], 0)==0 Then IniWrite($sFname, $sSectionName, $aIniSections[25], $aHotkeys[0]&$sSettingSeparator&$aHotkeys[1]& _
	$sSettingSeparator&$aHotkeys[2]&$sSettingSeparator&$aHotkeys[3]&$sSettingSeparator&$aHotkeys[4]&$sSettingSeparator&$aHotkeys[5]&$sSettingSeparator&$aHotkeys[6]& _
	$sSettingSeparator& $aHotkeys[7])
EndFunc   ;==>WriteConfig

Func SendNFC()
	ButtonStateSet($GUI_DISABLE)
	If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer = IniRead($sFname, $sSectionName, $aIniSections[13], -1)
	If $iMsgBoxAnswer == -1 Then $iMsgBoxAnswer = MsgBox(67, "Choose 3DS firmware version", "Yes -> Firmware >= 11.4" & @CRLF & "No -> Firmware <= 11.3" & @CRLF & _
			"Cancel -> Go back" & @CRLF & @CRLF & "Snickerstream will remember your answer so you won't see this message again.")
	Select
		Case $iMsgBoxAnswer = 6 ;Yes
			Local $iRet = _NTRSendNFCPatch($sIpAddr, "005b10") ;Offset must be in little-endian
			IniWrite($sFname, $sSectionName, $aIniSections[13], 6)
			LogLine("Sending NFC Patch (>=11.4).", 1)
		Case $iMsgBoxAnswer = 7 ;No
			Local $iRet = _NTRSendNFCPatch($sIpAddr, "e45a10") ;Same as above
			IniWrite($sFname, $sSectionName, $aIniSections[13], 7)
			LogLine("Sending NFC Patch (<=11.3).", 1)
	EndSelect
	If $iMsgBoxAnswer >= 6 Then
		If $iRet = -1 Then
			LogLine("NFC patch failed, could not connect.", 1)
			MsgBox($MB_ICONERROR, "Connection error", "Could not connect to the (N)3DS.")
		Else
			LogLine("NFC patch sent succesfully.", 1)
			MsgBox($MB_ICONINFORMATION, "Success!", "NFC patch sent succesfully!")
		EndIf
	EndIf
	ButtonStateSet($GUI_ENABLE)
EndFunc   ;==>SendNFC

Func StartStream()
	UpdateVars()
	WriteConfig()
	If $AdvancedMenu <> 0 Then ExitAdvanced()
	GUIDelete($SnickerstreamGUI)
	$bStreaming = True
	StreamingLoop()
EndFunc   ;==>StartStream

Func ButtonStateSet($GUIState)
	GUICtrlSetState($GUI_AboutBtn, $GUIState)
	GUICtrlSetState($GUI_NFCBtn, $GUIState)
	GUICtrlSetState($GUI_ConnectBtn, $GUIState)
	GUICtrlSetState($GUI_AdvButton, $GUIState)
EndFunc   ;==>ButtonStateSet

Func ExitMain()
	GUIDelete($SnickerstreamGUI)
	If IsDeclared("oD2D_HwndRenderTarget") <> 0 Then
		ExitStreaming()
	EndIf
	LogLine("Quitting.", 1)
	FileDelete($sIconPath)
	Exit
EndFunc   ;==>ExitMain

Func CheckAndShutdownGDIp()
	If $bD2D == False Then
		_GDIPlus_GraphicsDispose($g_hGfxCtxt)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		_GDIPlus_BitmapDispose($g_hBitmap)
		_GDIPlus_BitmapDispose($g_hBMP)
		_GDIPlus_BitmapDispose($g_hBMP2)
		_GDIPlus_Shutdown()
	EndIf
EndFunc   ;==>CheckAndShutdownGDIp

Func ExitStreaming()
	Global $bStreaming = False
	LogLine("Quitting.", 1)
	;Close the UDP socket
	UDPCloseSocket($iSocket)
	UDPShutdown()
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>ExitStreaming

Func LogStart()
	If $iLogLevel > 0 Then
		Local $hFile = FileOpen($sLogFname, $FO_OVERWRITE)

		FileWriteLine($hFile, "  ___      _    _              _")
		FileWriteLine($hFile, " / __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __")
		FileWriteLine($hFile, " \__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \")
		FileWriteLine($hFile, " |___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|")
		FileWriteLine($hFile, _StringRepeat("-", 82))
		Switch Random(0, 10, 1)
			Case 0
				FileWriteLine($hFile, "it hac, it bric, but most importantly, it S N I C C")
			Case 1
				FileWriteLine($hFile, "*whispers* AL9H.")
			Case 2
				FileWriteLine($hFile, "You must have graduated from elementary school to use this tool.")
			Case 3
				FileWriteLine($hFile, "One more way to get copyright striked by Nintendo.")
			Case 4
				FileWriteLine($hFile, "What are you waiting for, Nintendo to make one?")
			Case 5
				FileWriteLine($hFile, "Here's your christmas present! <3")
			Case 6
				FileWriteLine($hFile, "* The dog absorbs the stream.")
			Case 7
				FileWriteLine($hFile, "As smooth as FMVs on a Sega CD.")
			Case 8
				FileWriteLine($hFile, "[stability intensifies]")
			Case 9
				FileWriteLine($hFile, "Now with 500% more icons!")
			Case 10
				FileWriteLine($hFile, "For the glory of framekind.")
		EndSwitch
		FileWriteLine($hFile, _StringRepeat("-", 82))
		FileWriteLine($hFile, "VERSION : " & $sVersion)
		FileWriteLine($hFile, "LOGLEVEL: " & $iLogLevel)
		FileWriteLine($hFile, _StringRepeat("-", 82))
		LogLine("Logging started.", 1)
		FileClose($hFile)
	EndIf
EndFunc   ;==>LogStart

Func LogLine($sLogString, $iReqLogLevel)
	If $iLogLevel >= $iReqLogLevel Then
		Local $hFile = FileOpen($sLogFname, $FO_APPEND)

		FileWriteLine($hFile, "[" & @HOUR & ":" & @MIN & "] " & $sLogString)
		FileClose($hFile)
	EndIf
EndFunc   ;==>LogLine

Func GetCPU()
	Local $objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
	Local $colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_Processor", "WQL", 0x10 + 0x20)
	Local $Output = "(Not found)"
	If IsObj($colItems) Then
		For $objItem In $colItems
			$Output = $objItem.Name & "@" & $objItem.MaxClockSpeed & "MHz"
		Next
	EndIf

	Return $Output
EndFunc   ;==>GetCPU

Func GetGPU()
	$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_DisplayConfiguration", "WQL", 0x10 + 0x20)
	If IsObj($colItems) Then
		For $objItem In $colItems
			$Output = $objItem.DeviceName
		Next
	EndIf

	Return $Output
EndFunc   ;==>GetGPU

Func ExitOnStreamFail()
	$bStreaming = False
	$bRecieved = True
	UDPCloseSocket($iSocket)
	UDPShutdown()
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	CreateMainGUIandSettings()
EndFunc

Func CheckIfStreaming($sRemoteIP)
	Local $hTimerTimeout = TimerInit()
	Local $bRecieved = False
	Local $bChecked = False
	Local Const $iTimeout = IniRead($sFname, $sSectionName, $aIniSections[14], 1000)
	Local Const $sConnectionError = "Connection error"
	While $bRecieved == False
		$dRecv = UDPRecv($iSocket, 2000, 1)
		If TimerDiff($hTimerTimeout) >= $iTimeout And $bChecked == False Then
			WinSetTitle($g_hGUI, "", $sSectionName & " - Starting remoteplay...")
			LogLine("Starting remoteplay on 3DS.", 1)
			$iRet = _NTRInitRemoteplay($sRemoteIP, $iPriorityMode, $iPriorityFactor, $iImageQuality, $iQoS)
			$hTimerTimeout = TimerInit()	;The console is confirmed to be online, reset the timer for later use
			If $iRet = -1 Then
				LogLine("Remoteplay init failed, could not connect.", 1)
				MsgBox($MB_ICONERROR, $sConnectionError, "Could not start remoteplay on the (N)3DS.")
				ExitOnStreamFail()
				Return -1
			EndIf
			$bChecked = True
		EndIf
		If $dRecv <> "" Then
			$bRecieved = True
			LogLine("Receiving stream.", 1)
		ElseIf $dRecv=="" And TimerDiff($hTimerTimeout)>=$iTimeout And $iRet<>-1 Then
			MsgBox($MB_ICONERROR, $sConnectionError, "Could not receive the stream from your console."&@CRLF&@CRLF&"This usually happens if a firewall is blocking Snickerstream"& _
			" or if the streaming port is set incorrectly. Try to allow Snickerstream in your firewall, running it as admin and double check the streaming port in the advanced" & _
			" menu (it should be 8001 if you didn't patch NTR).")
			ExitOnStreamFail()
			Return -1
		EndIf
	WEnd
EndFunc   ;==>CheckIfStreaming

Func GUI_PresetChange()
	PresetSwitch(_GUICtrlComboBox_GetCurSel($GUI_Preset)) ;I need this one line function due to AutoIt's OnEvent mode
EndFunc   ;==>GUI_PresetChange

Func PresetSwitch($iPresetNum)
	Switch $iPresetNum
		Case 0 ;Best quality
			SetPreset(1, 2, 90, 10)
		Case 1
			SetPreset(1, 5, 80, 18)
		Case 2
			SetPreset(1, 5, 75, 18)
		Case 3
			SetPreset(1, 5, 70, 20)
		Case 4
			SetPreset(1, 8, 60, 26)
		Case 5
			SetPreset(1, 8, 50, 26)
		Case 6 ;Best performance
			SetPreset(1, 10, 40, 34)
		Case 8
			AddPreset()
		Case 9
			DeletePreset()
		Case Else
			If $iPresetNum <> 7 And $iPresetNum <> 10 Then
				Local $sReturn = ""
				_GUICtrlComboBoxEx_GetItemText($GUI_Preset, $iPresetNum, $sReturn)
				Local $aReadSplit = StringSplit(IniRead($sPresetFname, $sPresetSection, $sReturn, "ERROR"), $sSettingSeparator)
				If IsArray($aReadSplit) And $aReadSplit[0] == 4 Then
					SetPreset($aReadSplit[1], $aReadSplit[2], $aReadSplit[3], $aReadSplit[4])
				Else
					MsgBox(16, "Error!", "Custom preset is corrupt!")
				EndIf
			Else
				_GUICtrlComboBox_SetCurSel($GUI_Preset, 3)
			EndIf
	EndSwitch
EndFunc   ;==>PresetSwitch

Func SetPreset($iPriorityModeP, $iPriorityFactorP, $iImageQualityP, $iQoSP)
	_GUICtrlComboBox_SetCurSel($GUI_PriorityMode, Not Int($iPriorityModeP))
	GUICtrlSetData($GUI_PriorityFactor, $iPriorityFactorP)
	GUICtrlSetData($GUI_ImageQuality, $iImageQualityP)
	GUICtrlSetData($GUI_QoS, $iQoSP)
EndFunc   ;==>SetPreset

Func GUI_RenderingChange()
	If _GUICtrlComboBox_GetCurSel($GUI_Rendering) == 0 Then
		$bD2D = True
		GUICtrlSetData($GUI_Interpolation, "|Linear|Nearest neighbor", "Linear")
		GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top,st.)|Fullscreen(Bot,st.)|Fullscreen(Top)|Fullscreen(Bot)|Separate windows", "Vertical")
	Else
		If IniRead($sFname, $sSectionName, $aIniSections[12], 1) == 1 Then
			MsgBox(48, "Warning!", "GDI+ is NOT hardware accelerated. This means that you might get poor performance, stuttering and tearing on your computer while streaming." & @CRLF & @CRLF & _
					"Unless you REALLY know what you're doing, you should use Direct2D instead." & @CRLF & @CRLF & "Click OK to continue (this warning will not appear again).")
			IniWrite($sFname, $sSectionName, $aIniSections[12], 0)
		EndIf
		$bD2D = False
		GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
		GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top,st.)|Fullscreen(Bot,st.)", "Vertical")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation, 0)
EndFunc   ;==>GUI_RenderingChange

Func ReturnDecNumber($sNum)
	Return Number(StringRegExpReplace($sNum, "[^\d\.]", ""))
EndFunc   ;==>ReturnDecNumber

Func CheckForUpdates()
	If StringLeft($sVersion, 3) <> "git" And IniRead($sFname, $sSectionName, $aIniSections[17], 0) == 0 Then
		Local $sLatestFullVer = _GetGithubLatestReleaseTag("RattletraPM", "Snickerstream")
		Local $sLatestVer = ReturnDecNumber($sLatestFullVer)

		If @error <> -1 And $sLatestVer > ReturnDecNumber($sVersion) Then
			If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
			$iMsgBoxAnswer = MsgBox(67, "New stable version available!", "A new stable version of Snickerstream is now available for download!" & @CRLF & @CRLF & _
					"Current version: " & $sVersion & @CRLF & "Latest version: " & $sLatestFullVer & @CRLF & @CRLF & "Do you want to visit Snickerstream's GitHub Releases page?" & @CRLF & @CRLF & _
					"(Clicking on Cancel will disable Snickerstream's auto update feature by never checking for newer versions ever again)")
			Select
				Case $iMsgBoxAnswer = 6 ;Yes
					ShellExecute("https://github.com/RattletraPM/Snickerstream/releases")
				Case $iMsgBoxAnswer = 2 ;Cancel
					IniWrite($sFname, $sSectionName, $aIniSections[17], 1)
			EndSelect
		EndIf
	EndIf
EndFunc   ;==>CheckForUpdates

Func AdvMenu()
	If IniRead($sFname, $sSectionName, $aIniSections[21], 0) == 0 Then
		MsgBox(48, "Warning!", "These settings are called advanced for a reason: if you don't know what you're doing you could degrade your streaming performance or make you unable to stream at all until you reset your settings/reinstall NTR!" & _
				@CRLF & @CRLF & "Proceed at your own risk!")
		IniWrite($sFname, $sSectionName, $aIniSections[21], 1)
	EndIf
	Global $AdvancedMenu = GUICreate("Advanced settings", 415, 185)
	$LabelA1 = GUICtrlCreateLabel("Listening port:", 8, 10, 70, 17, $SS_CENTERIMAGE)
	Global $GUI_PortInput = GUICtrlCreateInput($iListenPort, 88, 8, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_PatchBtn = GUICtrlCreateButton("Patch NTR", 136, 6, 67, 25)
	Global $GUI_ApplyBtn = GUICtrlCreateButton("Apply", 206, 145, 195, 35)
	$LabelA3 = GUICtrlCreateLabel("Loglevel:", 8, 42, 47, 17, $SS_CENTERIMAGE)
	Global $LoglevelInput = GUICtrlCreateInput($iLogLevel, 128, 40, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA4 = GUICtrlCreateLabel("PC IP Address:", 208, 10, 75, 17, $SS_CENTERIMAGE)
	Global $IPAddressInput = _GUICtrlIpAddress_Create($AdvancedMenu, 304, 8, 101, 17)
	_GUICtrlIpAddress_Set($IPAddressInput, $sPCIpAddr)
	$LabelA5 = GUICtrlCreateLabel("Frame limit:", 8, 66, 56, 17, $SS_CENTERIMAGE)
	Global $FrameLimitInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[15], 0), 128, 64, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA6 = GUICtrlCreateLabel("Wait for remoteplay (msec):", 208, 42, 132, 17, $SS_CENTERIMAGE)
	Global $WaitForRemoteplayInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[14], 1000), 360, 40, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA7 = GUICtrlCreateLabel("Return after shutdown (msec):", 208, 66, 146, 17, $SS_CENTERIMAGE)
	Global $ReturnAfterMsecInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[16], 8000), 360, 64, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA8 = GUICtrlCreateLabel("Top scaling factor:", 8, 90, 92, 17, $SS_CENTERIMAGE)
	Global $TopScalingInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[22], 1), 128, 88, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA9 = GUICtrlCreateLabel("Bottom scaling factor:", 8, 114, 106, 17, $SS_CENTERIMAGE)
	Global $BotScalingInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[23], 1), 128, 112, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA10 = GUICtrlCreateLabel("Custom width (DPI Fix):", 8, 138, 113, 17, $SS_CENTERIMAGE)
	Global $CustomWidthInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[18], 0), 128, 136, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA11 = GUICtrlCreateLabel("Custom height (DPI Fix):", 8, 162, 117, 17, $SS_CENTERIMAGE)
	Global $CustomHeightInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[19], 0), 128, 160, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$LabelA12 = GUICtrlCreateLabel("Check for updates on startup:", 208, 90, 144, 17, $SS_CENTERIMAGE)
	Global $CheckUpdatesCheckbox = GUICtrlCreateCheckbox("", 360, 88, 17, 17)
	If IniRead($sFname, $sSectionName, $aIniSections[17], 0)==0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	$LabelA13 = GUICtrlCreateLabel("Center the screens:", 208, 114, 96, 17, $SS_CENTERIMAGE)
	Global $CenterScreensCheckbox = GUICtrlCreateCheckbox("", 360, 112, 17, 17)
	If IniRead($sFname, $sSectionName, $aIniSections[24], 1)==1 Then GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetOnEvent($GUI_PatchBtn, "PatchNTR")
	GUICtrlSetOnEvent($GUI_ApplyBtn, "ApplyAdvSettings")
	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitAdvanced")
	GUISetState(@SW_SHOW)
EndFunc   ;==>AdvMenu

Func AboutMsg()
	ButtonStateSet($GUI_DISABLE)
	MsgBox($MB_ICONINFORMATION, "About Snickerstream", $sGUITitle & "by RattletraPM" & @CRLF & @CRLF & "This software and its source code are provided free of charge under the GPL-3.0" & _
			" License. See License.txt for the full license." & @CRLF & @CRLF & "Direct2D and WIC UDF made by trancexx & Eukalyptus." & @CRLF & "Icon by Trinsid.")
	ButtonStateSet($GUI_ENABLE)
EndFunc   ;==>AboutMsg

Func AboutScreen()
	Global $AboutScreen = GUICreate("About", 310, 245)
	;GUICtrlCreateIcon($sIconPath, 20, 40, 64, 64)
	GUICtrlCreateIcon($sIconPath, -1, 20, 20)
	GUICtrlCreateLabel($sSectionName, 67, 17, 500, 33)
	GUICtrlSetFont(-1, 27, 780, 0, "MS Sans Serif")
	GUICtrlCreateLabel($sVersion, 67, 50, 40, 20)
	$Edit1 = GUICtrlCreateEdit("", 20, 70, 270, 160, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
	GUICtrlSetData(-1, "Made by RattletraPM"&@CRLF&@CRLF&"This software and its source code are provided free of charge under the GPL-3.0 License.  See License.txt for the full license."& _
	@CRLF&"Credits:"&@CRLF&"**Direct2D and WFC UDFs** trancexx and Eukalyptus."&@CRLF&"**Beta testers** ElderCub, TehJ3sse, Eldurislol, Silly Chip"&@CRLF&"**Feature suggestions** ElderCub, "& _
	"Real96, DaWoblefet"&@CRLF&"**Icon** Trinsid."&@CRLF&@CRLF&"If I forgot anyone please tell me!"&@CRLF&@CRLF&"Also, if you want to support Snickerstream's development, you can donate using PayPal "& _
	"at lucapm@live.it - donations aren't necessary, but are very appreciated!")
	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitAbout")
	GUISetState(@SW_SHOW)
EndFunc

Func PatchNTR()
	ButtonStateSet($GUI_DISABLE)
	Local $iPort = GUICtrlRead($GUI_PortInput)
	Local Const $sOldWorkingDir=@WorkingDir

	If $iPort > 0 And $iPort <= 65535 Then
		If _NTRCheckPortBug($iPort) == False Then
			Local $sNTRPath = FileOpenDialog("Select NTR binary", @WorkingDir, "Binary file (*.bin)", 0, "ntr.bin")
			Local $hNTRRead = FileOpen($sNTRPath, 16)
			Local $dNTRHash = _Crypt_HashData(FileRead($hNTRRead, 150007), $CALG_MD5) ;After that point, NTR's regular binary and the one downloaded by BootNTRSelector differ in some areas

			FileClose($hNTRRead)
			If FileExists($sNTRPath) And @error == 0 Then
				If $dNTRHash == "0xD707E3BFB90C512DCED1225223BE830F" Then
					Local $iMsgBoxAnswer = MsgBox(36, "Are you sure?", "You're about to patch your NTR binary file to send frames on UDP port " & $iPort & "." & @CRLF & "Are you sure?")

					If $iMsgBoxAnswer = 6 Then
						If $iPort > 0 And $iPort <= 65535 Then
							Local $iNTRRet=_NTRPatchPort($sNTRPath, $iPort)
							If $iNTRRet==1 Then
								If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
								$iMsgBoxAnswer = MsgBox(36,"Change port?","Do you also want to change Snickerstream's listening port to the one you just patched in NTR?" & @CRLF & @CRLF & "(If unsure, click Yes)")
								If $iMsgBoxAnswer = 6 Then ;Yes
									IniWrite($sFname, $sSectionName, $aIniSections[20], $iPort)
									GUICtrlSetData($GUI_PortInput,$iPort)
									MsgBox(64,"OK!","All done!")
								EndIf
							EndIf
						Else
							MsgBox(16, "Error", "The port number must be between 1 and 65535.") ;All these nested If statements make me want to cry
						EndIf
					EndIf
				Else
					MsgBox(16, "Invalid or unsupported NTR binary", "The NTR binary you've selected is either invalid or unsupported!" & @CRLF & _
							@CRLF & "Keep in mind that only NTR 3.6 (N3DS) is supported at the moment. Please download NTR 3.6 either from BootNTRSelector or the official GitHub repo and try again.")
				EndIf
			EndIf
		EndIf
	Else
		MsgBox(16, "Error", "The port number must be between 1 and 65535.")
	EndIf
	FileChangeDir($sOldWorkingDir)	;FileOpenDialog will change the current working directory, which can break some stuff
	ButtonStateSet($GUI_ENABLE)
EndFunc   ;==>PatchNTR

Func ApplyAdvError($sMsg)
	MsgBox(16, "Error", $sMsg)
	Return True
EndFunc

Func ApplyAdvSettings()
	ButtonStateSet($GUI_DISABLE)
	GUICtrlSetState($GUI_ApplyBtn, $GUI_DISABLE)

	Local $iPort = GUICtrlRead($GUI_PortInput)
	Local $bError = False
	Local $iLogLevelRead = GUICtrlRead($LoglevelInput)
	Local $TopScalingRead = GUICtrlRead($TopScalingInput)
	Local $BotScalingRead = GUICtrlRead($BotScalingInput)
	Local $CustomWidthRead = GUICtrlRead($CustomWidthInput)
	Local $CustomHeightRead = GUICtrlRead($CustomHeightInput)

	If $iPort < 0 Or $iPort > 65535 Then
		$bError=ApplyAdvError("The port number must be between 1 and 65535.")
	EndIf
	If _NTRCheckPortBug($iPort) == True Then
		$bError=True
	EndIf
	If $iLogLevelRead > 3 Then
		$bError=ApplyAdvError("Loglevel must be between 0 and 3.")
	EndIf
	If $TopScalingRead < 0.3 Or $BotScalingRead < 0.3 Then
		$bError=ApplyAdvError("Top and bottom scaling factor must be higher than 0.3.")
	EndIf
	If $CustomWidthRead>0 And $CustomWidthRead < 150 Then
		$bError=ApplyAdvError("Custom width must be 0 (disabled) or higher than 149.")
	EndIf
	If $CustomHeightRead>0 And $CustomHeightRead < 200 Then
		$bError=ApplyAdvError("Custom width must be 0 (disabled) or higher than 199.")
	EndIf
	If $bError=False Then
		IniWrite($sFname, $sSectionName, $aIniSections[20], $iPort)	;Port
		$iListenPort = $iPort
		$sPCIpAddr=_GUICtrlIpAddress_Get($IPAddressInput)
		IniWrite($sFname, $sSectionName, $aIniSections[7], $sPCIpAddr)	;PC IP Address
		CheckPCIP()
		IniWrite($sFname, $sSectionName, $aIniSections[9], $iLogLevelRead)	;Loglevel
		$iLogLevel=$iLogLevelRead
		IniWrite($sFname, $sSectionName, $aIniSections[15], GUICtrlRead($FrameLimitInput))	;Framelimit
		IniWrite($sFname, $sSectionName, $aIniSections[14], GUICtrlRead($WaitForRemoteplayInput))	;WaitRemoteplayInit
		IniWrite($sFname, $sSectionName, $aIniSections[16], GUICtrlRead($ReturnAfterMsecInput))	;ReturnAfterMsec
		IniWrite($sFname, $sSectionName, $aIniSections[22], $TopScalingRead)	;TopScaling
		IniWrite($sFname, $sSectionName, $aIniSections[23], $BotScalingRead)	;BotScaling
		IniWrite($sFname, $sSectionName, $aIniSections[18], $CustomWidthRead)	;CustomWidth
		IniWrite($sFname, $sSectionName, $aIniSections[19], $CustomHeightRead)	;CustomHeight
		If GUICtrlRead($CheckUpdatesCheckbox)==$GUI_CHECKED Then	;Check for updates
			IniWrite($sFname, $sSectionName, $aIniSections[17], 0)
		Else
			IniWrite($sFname, $sSectionName, $aIniSections[17], 1)
		EndIf
		If GUICtrlRead($CenterScreensCheckbox)==$GUI_CHECKED Then	;Center Screens
			IniWrite($sFname, $sSectionName, $aIniSections[24], 1)
		Else
			IniWrite($sFname, $sSectionName, $aIniSections[24], 0)
		EndIf
		MsgBox(64, "Done", "Settings applied succesfully!")
	EndIf

	GUICtrlSetState($GUI_ApplyBtn, $GUI_ENABLE)
	ButtonStateSet($GUI_ENABLE)
EndFunc   ;==>ApplyAdvSettings

Func ExitAdvanced()
	GUIDelete($AdvancedMenu)
EndFunc   ;==>ExitAdvanced

Func ExitAbout()
	GUIDelete($AboutScreen)
EndFunc   ;==>ExitAdvanced

Func AddPreset()
	UpdateVars()
	Local Const $sAnswer = InputBox("Name your custom preset", "This option will create a new custom preset from your current remoteplay settings." & @CRLF & @CRLF & _
			"Click OK to save it or click Cancel to go back.", "My custom preset")

	If $sAnswer <> "" Then
		Local Const $sAlreadyExists = IniRead($sPresetFname, $sPresetSection, $sAnswer, "T")
		If $sAlreadyExists <> "T" Then
			Local $iMsgBoxAnswer = MsgBox(52, "Warning", "There already exists a custom preset called " & $sAnswer & "." & @CRLF & @CRLF & "Do you want to overwrite it?")
			If $iMsgBoxAnswer <> 6 Then Return -1
		EndIf
		IniWrite($sPresetFname, $sPresetSection, $sAnswer, $iPriorityMode & $sSettingSeparator & $iPriorityFactor & $sSettingSeparator & $iImageQuality & $sSettingSeparator & $iQoS)
		LoadPresets()
		MsgBox(64, "Success!", "Custom preset added succesfully!")
	EndIf
EndFunc   ;==>AddPreset

Func DeletePreset()
	Local Const $sAnswer = InputBox("Delete a custom preset", "This option will delete an existing custom preset." & @CRLF & @CRLF & _
			"Type the preset you want to delete and click OK to continue or click Cancel to go back.", "My custom preset")

	If $sAnswer <> "" Then
		Local Const $sAlreadyExists = IniRead($sPresetFname, $sPresetSection, $sAnswer, "T")
		If $sAlreadyExists <> "T" Then
			IniDelete($sPresetFname, $sPresetSection, $sAnswer)
			LoadPresets()
			MsgBox(64, "Success!", "Custom preset deleted succesfully!")
		Else
			MsgBox(48, "Warning", "The specified present does not exist!")
		EndIf
	EndIf
EndFunc   ;==>DeletePreset

Func LoadPresets()
	Local Const $sDefaultSelection = "Balanced"
	Local $sPresetList = "Best quality|Great quality|Good quality|" & $sDefaultSelection & "|Good framerate|Great framerate|Best framerate|" & $sSeparator & "|Add custom preset|Delete custom preset|" & $sSeparator & "|"

	GUICtrlSetData($GUI_Preset, "", "") ;Clear the preset list first
	If FileExists($sPresetFname) Then
		Local Const $aReadSection = IniReadSection($sPresetFname, $sPresetSection)

		If IsArray($aReadSection) Then
			For $i = 1 To $aReadSection[0][0]
				$sPresetList &= $aReadSection[$i][0] & "|"
			Next
		EndIf
	EndIf
	GUICtrlSetData($GUI_Preset, $sPresetList, $sDefaultSelection)
EndFunc   ;==>LoadPresets
