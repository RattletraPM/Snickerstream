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
#include "include\HzMod.au3"
#include "include\WIC.au3"
#include "include\Direct2D.au3"
#include "include\Direct2D_1.au3"
#include "include\GitAndGithub.au3"

Opt("MustDeclareVars",1)

;Globals - Streaming GUI and Drawing
Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hBMP2, $g_hGraphics, $iFPS = 0, $iInterpolation = 0, _
		$aWinResize, $aWinResize2, $ix1BMP1 = 0, $ix2BMP1 = 0, $ix1BMP2 = 0, $ix2BMP2 = 0, $iy1BMP1 = 0, $iy2BMP1 = 0, $iy1BMP2 = 0, $iy2BMP2 = 0, _
		$iLayoutmode = 0, $bNoDisplayIPWarn = 0, $bD2D = True, $iListenPort = 8001, $bFullscreenPopup = False
Global Const $sVersion = "v1.10", $sGUITitle = "Snickerstream-ES // JustSofter x Robichani6-1 " & $sVersion, $sIconPath=@TempDir&"\snickerstream.ico"

;Globals - Main and Advanced GUI
Global $sIpAddr = "0.0.0.0", $iPriorityMode = 0, $iPriorityFactor = 5, $iImageQuality = 70, $iQoS = 20, $AdvancedMenu = 0, $aHotkeys[10] = ["26","28","25","27","0D","53","20","1B","51","45"]

;Globals - Config
Global $sFname = @ScriptDir & "\settings.ini", $sPCIpAddr = $sIpAddr, $iLogLevel = 0, $bUseNTR = True, $iLogConsole = 0
Global Const $sSectionName = "Snickerstream", $aIniSections[31] = ["IpAddr", "PriorityMode", "PriorityFactor", "ImageQuality", _
		"QoS", "Interpolation", "Layoutmode", "PCIpAddr", "NoDisplayIPWarn", "Loglevel", "DontCheckSettings", "UseD2D", "GDIPWarn", "NFCLastAnswer", _
		"WaitRemoteplayInit", "Framelimit", "ReturnAfterMsec", "DontCheckForUpdates", "CustomWidth", "CustomHeight", "ListenPort", "AdvWarning", "TopScalingFactor", _
		"BottomScalingFactor", "CenterScreens", "Hotkeys", "UseNTR", "LogConsole", "CustomWidth2", "CustomHeight2", "EnableHzMNFCPatch"], _
		$sLogFname = "log.txt", $sSettingSeparator = "|"
Global Const $iD2D1InterpModes[6] = [$D2D1_INTERPOLATION_MODE_NEAREST_NEIGHBOR, $D2D1_INTERPOLATION_MODE_LINEAR, $D2D1_INTERPOLATION_MODE_CUBIC, _
$D2D1_INTERPOLATION_MODE_MULTI_SAMPLE_LINEAR, $D2D1_INTERPOLATION_MODE_ANISOTROPIC, $D2D1_INTERPOLATION_MODE_HIGH_QUALITY_CUBIC]
Global Const $sD2D1InterpModeNames[6] = ["Nearest Neighbor", "Linear", "Cubic", "Multi Sample Linear", "Anisotropic", "High Quality Cubic"]

;Globals - Misc Constants
Global Const $sSeparator = _StringRepeat("-", 33), $sGUI2 = "g_hGUI2", $iW3DSTop = 400, $iW3DSBot = 320, $iH3DS = 240

;Globals - Misc
Global $hTimer = TimerInit(), $bStreaming = False, $bEnableHzMNFCPatch = False

;Globals - GUI
Global $GUI_Rendering = 0, $GUI_Interpolation = 0 ;Those are here to prevent a "possibly used before declaration" warning (yes, the variables are declared before being used in a separate UDF but SciTE doesn't recognize it)

AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("GUIOnEventMode", 1) ;Use OnEvent mode - a script like this would be awful without it
AutoItSetOption("TCPTimeout", 5000)
AutoItSetOption("TrayAutoPause", 0)
FileInstall("res\snickerstream.ico",$sIconPath,1)

If $CmdLine[0] == 1 Then	;Custom settings.ini path
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
LogLine("AVISO: El nivel del log es 3. Esto logeará todo, cosa que puede intervenir en el rendimiento.", 3)
LogLine("Puedes cambiar el nivel de logeo si te produce algún problema", 3)
LogLine("SO: " & @OSVersion, 3)

If (IsAdmin() == 1 And @Compiled == 1) And (StringLeft(@OSVersion, 6) <> "WIN_XP" And @OSVersion <> "WIN_2003") Then ;This feature is not supported in Windows XP/XPe/Server 2003
	LogLine("AVISO: Snickerstream-ES ha sido ejecutado con permisos de administrador.", 1)
	If FileExists(@SystemDir & "\netsh.exe") Then
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall delete rule name="Snickerstream"', Default, Default, @SW_HIDE)
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall add rule name="Snickerstream" dir=in action=allow program="' & @ScriptFullPath & '" enable=yes', Default, Default, @SW_HIDE)
		ShellExecute(@SystemDir & '\netsh', 'advfirewall firewall add rule name="Snickerstream" dir=out action=allow program="' & @ScriptFullPath & '" enable=yes', Default, Default, @SW_HIDE)
		LogLine("Hecho. Se recomienda ejecutar Snickerstream-ES a partir de adelante si permisos de administrador", 1)
	Else
		LogLine("¡Hubo un error al agregar una excepción al Firewall de Windows! Agregue uno manualmente desde el panel de control.", 1)
	EndIf
EndIf

CheckForUpdates()

If $__g_hD2D1DLL == -1 Then
	MsgBox($MB_ICONERROR, "Error al inicializar Direct2D r", "Hubo un error al inicializar Direct2D." & @CRLF & @CRLF & "Lo más probable es que este error se deba al uso de Snickerstream en un sistema operativo" & _
			" que no es compatible con Direct2D (disponible en Windows Vista SP2 o posterior). Todavía podrá usar esta herramienta, pero tendrá que usar GDI+ como su biblioteca de renderizado en su lugar (sin aceleración de" & _
			" hardware será mas lento, consulte el archivo Léame para obtener más información).")
	_GUICtrlComboBox_SetCurSel($GUI_Rendering, 1)
	GUICtrlSetState($GUI_Rendering, $GUI_DISABLE)
	GUICtrlSetData($GUI_Interpolation, "|Por defecto|Baja calidad|Alta calidad|Bilineal|Bicubico|Más cercano|Bilineal (HQ)|Bicubico (HQ)", "Por defecto")
	$bD2D = False
EndIf
ButtonStateSet($GUI_ENABLE)
If $bUseNTR == False Then SettingsStateSet($GUI_DISABLE)

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
		Local $aNewHotkeys=StringSplit($sReadHotkeys, $sSettingSeparator)

		If UBound($aNewHotkeys)==11 Then
			_ArrayDelete($aNewHotkeys,0)
			$aHotkeys=$aNewHotkeys
		Else
			IniWrite($sFname, $sSectionName, $aIniSections[25], _ArrayToString($aHotkeys,$sSettingSeparator))
		EndIf
	EndIf
EndFunc

Func StreamingLoop()
	If $bUseNTR==False Then $iLayoutmode = 4+(2*$iLayoutmode)

	ReadCustomHotkeys()

	Global $iTopScalingFactor = IniRead($sFname, $sSectionName, $aIniSections[22], 1)
	If $iLayoutmode == 6 Or $iLayoutmode == 8 Then ;For Fullscreen Top, non-stretched
		If @DesktopWidth > @DesktopHeight Then
			$iTopScalingFactor = @DesktopHeight / 240
		Else
			$iTopScalingFactor = @DesktopWidth / 240
		EndIf
	EndIf
	Global $iBotScalingFactor = IniRead($sFname, $sSectionName, $aIniSections[23], 1)
	If $iLayoutmode == 7 Or $iLayoutmode == 9 Then ;For Fullscreen Bottom, non-stretched
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

	Local $iFramelock = IniRead($sFname, $sSectionName, $aIniSections[15], 0), $iReturnAfter = IniRead($sFname, $sSectionName, $aIniSections[16], 8000), $iFramelockedFPS = 0, _
	$iTimerWaitExit = TimerInit(), $sFPSString = " FPS", $sWinTitle = ""

	LogLine("Dirección IP del PC: " & $sPCIpAddr, 2)
	LogLine("Dirección IP de la consola: " & $sIpAddr, 2)
	LogLine("Prioridad: " & $iPriorityMode, 2)
	LogLine("Factor de prioridad: " & $iPriorityFactor, 2)
	LogLine("Calidad de imagen: " & $iImageQuality, 2)
	LogLine("QoS: " & $iQoS, 2)
	LogLine("Modo de interpolación: " & $iInterpolation, 2)
	LogLine("Posición de las pantallas: " & $iLayoutmode, 2)
	LogLine("Usando Direct2D: " & $bD2D, 2)
	LogLine("Usando NTR: " & $bUseNTR, 2)
	If $iFramelock <> 0 Then LogLine("Límite de cuadros: " & $iFramelock, 2)
	If $bUseNTR==True Then LogLine("Puerto oyente: " & $iListenPort, 2)
	LogLine("Factor de escalado de pantalla superior: " & $iTopScalingFactor, 2)
	LogLine("Factor de escalado de pantalla inferior: " & $iBotScalingFactor, 2)
	LogLine("-NOTA- Las direcciones IP deben de ser internas. Si las pones públicas, asegúrate de NO subir este log al público!", 2)
	If $bUseNTR==True Then
		UDPStartup() ;Start up the UDP protocol
		Global $iSocket = UDPBind($sPCIpAddr, $iListenPort) ;Listen to whatever port has been specified by the user (default=8001)
	Else
		TCPStartup()
		Global $iSocket = TCPConnect($sIpAddr,6464)
		Local $dReadahead = -1
	EndIf
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
	If $iLayoutmode>5 And $iLayoutmode<>10 Then
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

	If $iLayoutmode == 10 Then
		Local Const $iCustomWidth2 = IniRead($sFname, $sSectionName, $aIniSections[28], 0)
		Local Const $iCustomHeight2 = IniRead($sFname, $sSectionName, $aIniSections[29], 0)
		If $iCustomWidth2 >= 150 Then $iWidth2 = $iCustomWidth2
		If $iCustomHeight2 >= 200 Then $iHeight2 = $iCustomHeight2
	EndIf

	Global $g_hGUI = GUICreate($sSectionName & " - Conectando...", $iWidth, $iHeight, $iGUIWidthHeight, $iGUIWidthHeight, $xGUIStyle, $xGUIExStyle) ;Create the GUI
	GUISetBkColor(0, $g_hGUI)

	;In order to correctly resize the window, we need to get the difference between the graphics object width/height and the actual
	;window width/height. This difference is created by the window's borders and title bar
	$aWinResize = WinGetPos($g_hGUI)
	Global $iWidthDiff = $aWinResize[2] - $iWidth
	Global $iHeightDiff = $aWinResize[3] - $iHeight

	GUISetState(@SW_SHOW, $g_hGUI)

	If $bD2D == True Then ;Init Direct2D
		Global $oD2D_Factory = _D2D_Factory1_Create()
		Global $tMatrix_Rotate = _D2D_Matrix3x2_Rotation(-90, 0, 0)
		Global $oD2D_DeviceContext, $oD2D_SwapChain
		_D2D_CreateHWNDContext($oD2D_Factory, $g_hGUI, $oD2D_DeviceContext, $oD2D_SwapChain)
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

	If $bUseNTR==True Then
		CheckIfStreaming($sIpAddr)
	Else
		_HzModInit($iSocket, $iImageQuality, $iQoS)
	EndIf

	If $iLayoutmode == 10 And $bStreaming==True Then	;Create the secondary window if layout mode is separate windows
		Global $g_hGUI2 = GUICreate($sSectionName & " - Pantalla inf.", $iWidth2, $iHeight2, $iGUIWidthHeight, $iGUIWidthHeight, $xGUIStyle, $xGUIExStyle) ;Create the GUI
		GUISetBkColor(0, $g_hGUI2)
		GUISetState(@SW_SHOW, $g_hGUI2)
		Global $oD2D_DeviceContext2, $oD2D_SwapChain2
		_D2D_CreateHWNDContext($oD2D_Factory, $g_hGUI2, $oD2D_DeviceContext2, $oD2D_SwapChain2)
	EndIf

	Local $tMatrix_Rotate = _D2D_Matrix3x2_Rotation(-90, 120, 120)
	If $iTopScalingFactor <> 1 Then $iy1BMP1=$iy1BMP1-$iH3DS*($iTopScalingFactor-1)	;Scaling functions do not take into account the image's rotation
	If $iBotScalingFactor <> 1 Then $iy1BMP2=$iy1BMP2-$iH3DS*($iBotScalingFactor-1)

	Local $iImgNum = 0, $iSubImgNum = 0, $oTemp, $aSubImages[10], $oBitmap

	While $bStreaming == True
		Local $iFrameTimer = TimerInit()
		If WinActive($g_hGUI) == $g_hGUI Or (IsDeclared($sGUI2) And WinActive($g_hGUI2)==$g_hGUI2) Then CheckKeys() ;Check the keys that are pressed to do various functions
		If $bUseNTR==True Then
			Local $aJpeg = _NTRRemoteplayReadJPEG($iSocket)
		Else
			Local $aJpeg = _HzModReadImage($iSocket,$dReadahead)
		EndIf
		If IsArray($aJpeg) Then
			If $bUseNTR==False Then $dReadahead=$aJpeg[2]
			$iFPS += 1
			If $bD2D == True Then
				If $iSubImgNum == 0 Or $iSubImgNum == $iImgNum Then $oBitmap = __D2D_LoadImageFromMemory($aJpeg[1], $aJpeg[0], $bUseNTR) ;Create a D2D image from the image that's stored in memory
				If $aJpeg[0] == 1 And ($oBitmap[1] <> $iW3DSTop Or $iImgNum = 0) Then	;HzMod streaming is only supported for the top screen now. I'll have to change this later
					$iImgNum = ($iW3DSTop/$oBitmap[1])-1
					ReDim $aSubImages[$iImgNum]
				EndIf
				If $iSubImgNum == $iImgNum Then	;If ALL "sub-frames" have been received and backbuffered it's time to rock!
					$oD2D_DeviceContext.BeginDraw()
					$oD2D_DeviceContext.SetTransform($tMatrix_Rotate)
					If $aJpeg[0] == 1 And $iLayoutmode <> 5 Then
						;-240 because we rotate the image of -90 degrees and we've chosen 0,0 as the transformation's origin, so the image falls "on top" of the rendering area
						;Also, Width and Height are inverted because the render target is rotated
						If $iLayoutmode<>7 And $iLayoutmode<>9 Then
							If $oBitmap[1]<400 Then
								For $i = 0 To $iImgNum-1
									$oTemp = __D2D_LoadImageFromMemory($aSubImages[$i], $aJpeg[0], $bUseNTR)	;Parse them...
									$oD2D_DeviceContext.DrawImage($oTemp[0], _D2D1_POINT_2F($iy1BMP1, $ix1BMP1+($oBitmap[1]*$i)*$iTopScalingFactor), _D2D1_RECT_F(0, 0, $iy2BMP1*-1, $oBitmap[1]*$iTopScalingFactor), $iInterpolation, Null)	;...Then copy them to the front buffer and wait until EndDraw!
								Next
								$oD2D_DeviceContext.DrawImage($oBitmap[0], _D2D1_POINT_2F($iy1BMP1, $ix1BMP1+($oBitmap[1]*$iImgNum)*$iTopScalingFactor), _D2D1_RECT_F(0, 0, $iy2BMP1*-1, $oBitmap[1]*$iTopScalingFactor), $iInterpolation, Null)
							Else
								$oD2D_DeviceContext.DrawImage($oBitmap[0], _D2D1_POINT_2F($iy1BMP1, $ix1BMP1), _D2D1_RECT_F(0, 0, $iy2BMP1*-1, $ix2BMP1), $iInterpolation, Null)
							EndIf
						EndIf
							If ($iLayoutmode==7 Or $iLayoutmode==9) And $bFullscreenPopup==True Then $oJpegBuf=$oBitmap[0]
					ElseIf $aJpeg[0] == 0 And ($iLayoutmode <> 4 And $iLayoutmode <> 10) Then
						If $iLayoutmode<>6 And $iLayoutmode<>8 Then $oD2D_DeviceContext.DrawImage($oBitmap[0], _D2D1_POINT_2F($iy1BMP2, $ix1BMP2), _D2D1_RECT_F(0, 0, $iy2BMP2*-1, $ix2BMP2), $iInterpolation, Null)
						If ($iLayoutmode==6 Or $iLayoutmode==8) And $bFullscreenPopup==True Then $oJpegBuf=$oBitmap[0]
					EndIf

					If ($iLayoutmode==6 Or $iLayoutmode==8) And $bFullscreenPopup==True And IsObj($oJpegBuf) Then	;Draw the other screen if fullscreen popup is enabled
						$oD2D_DeviceContext.DrawImage($oJpegBuf, _D2D1_POINT_2F($iy1BMP2+($iH3DS*$iBotScalingFactor), $ix1BMP2), _D2D1_RECT_F(0, 0, ($iy2BMP2*-1)+($iH3DS*$iBotScalingFactor), $ix2BMP2), $iInterpolation, Null)
					ElseIf ($iLayoutmode==7 Or $iLayoutmode==9) And $bFullscreenPopup==True And IsObj($oJpegBuf) Then
						$oD2D_DeviceContext.DrawImage($oJpegBuf, _D2D1_POINT_2F($iy1BMP1+($iH3DS*$iTopScalingFactor), $ix1BMP1), _D2D1_RECT_F(0, 0, ($iy2BMP1*-1)+($iH3DS*$iTopScalingFactor), $ix2BMP1), $iInterpolation, Null)
					EndIf

					$oD2D_DeviceContext.EndDraw(0, 0)
					$oD2D_SwapChain.Present(1, 0)
					If $aJpeg[0] == 0 And $iLayoutmode == 10 Then
						$oD2D_DeviceContext2.BeginDraw()
						$oD2D_DeviceContext2.SetTransform($tMatrix_Rotate)
						$oD2D_DeviceContext2.DrawImage($oBitmap[0], _D2D1_POINT_2F($iy1BMP2, $ix1BMP2), _D2D1_RECT_F(0, 0, $iy2BMP2*-1, $ix2BMP2), $iInterpolation, Null)
						$oD2D_DeviceContext2.EndDraw(0, 0)
						$oD2D_SwapChain2.Present(1, 0)
					EndIf
					$iSubImgNum = 0
				Else
					$aSubImages[$iSubImgNum] = $aJpeg[1]	;If more than one "subframe" is detected, backbuffer it
					$iSubImgNum += 1
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
			If $iImgNum<>0 Then $iFPS = Round($iFPS/$iImgNum)
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
			LogLine("La consola no ha estado enviando cuadros desde hace " & $iReturnAfter & "milisegundos, volviendo a la pantalla de conexión", 1)
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

Func __D2D_ScaleImageFactor($oScaleEffect, $oImage, $iScreen)
	If $iScreen==1 Then
		Local $iHorizScale=$iTopScalingFactor, $iVertScale=$iTopScalingFactor
		If $iLayoutmode == 6 Then
			$iVertScale=@DesktopWidth/$iW3DSTop
			$iTopScalingFactor=$iVertScale
			$iHorizScale=@DesktopHeight/$iH3DS
		EndIf
	Else
		Local $iHorizScale=$iBotScalingFactor, $iVertScale=$iBotScalingFactor
		If $iLayoutmode == 7 Then
			$iVertScale=@DesktopWidth/$iW3DSBot
			$iHorizScale=@DesktopHeight/$iH3DS
		EndIf
	EndIf
	_D2D_Effect_SetInput($oScaleEffect, $oImage)
	_D2D_Properties_SetValue($oScaleEffect, $D2D1_SCALE_PROP_CENTER_POINT, $D2D1_PROPERTY_TYPE_VECTOR2, _D2D1_VECTOR_2F(0, 0))
	_D2D_Properties_SetValue($oScaleEffect, $D2D1_SCALE_PROP_INTERPOLATION_MODE, $D2D1_PROPERTY_TYPE_ENUM, _D2D1_UINT($D2D1_SCALE_INTERPOLATION_MODE_NEAREST_NEIGHBOR))
	_D2D_Properties_SetValue($oScaleEffect, $D2D1_SCALE_PROP_SCALE, $D2D1_PROPERTY_TYPE_VECTOR2, _D2D1_VECTOR_2F($iHorizScale, $iVertScale))
	Return _D2D_Effect_GetOutput($oScaleEffect)
EndFunc

Func __D2D_LoadImageFromMemory($dData, $iScreen, $bSwapRB)
	Local $aRet[2]
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
	Local $iImgW, $iImgH
	$oWIC_FormatConverter.GetSize($iImgW, $iImgH)
	$aRet[1] = $iImgH

	If $iLayoutmode <> 10 Or $iScreen == 1 Then
		Local $oD2D_ColorMatrixEffect = _D2D_DeviceContext_CreateEffect($oD2D_DeviceContext, $sIID_D2D1ColorMatrix)
		Local $oD2D_ScaleEffect = _D2D_DeviceContext_CreateEffect($oD2D_DeviceContext, $sIID_D2D1Scale)
		Local $oD2D_Bitmap = _D2D_RenderTarget_CreateBitmapFromWicBitmap($oD2D_DeviceContext, $oWIC_FormatConverter)
	ElseIf $iLayoutmode == 10 And $iScreen == 0 Then
		Local $oD2D_ColorMatrixEffect = _D2D_DeviceContext_CreateEffect($oD2D_DeviceContext2, $sIID_D2D1ColorMatrix)
		Local $oD2D_ScaleEffect = _D2D_DeviceContext_CreateEffect($oD2D_DeviceContext2, $sIID_D2D1Scale)
		Local $oD2D_Bitmap = _D2D_RenderTarget_CreateBitmapFromWicBitmap($oD2D_DeviceContext2, $oWIC_FormatConverter)
	EndIf
	_D2D_Effect_SetInput($oD2D_ColorMatrixEffect, $oD2D_Bitmap)
	If $bSwapRB == False Then _D2D_Properties_SetValue($oD2D_ColorMatrixEffect, $D2D1_COLORMATRIX_PROP_COLOR_MATRIX, $D2D1_PROPERTY_TYPE_MATRIX_5X4, $structSwapRBMatrix)

	If $iTopScalingFactor<>1 Or $iBotScalingFactor<>1 Then
		$aRet[0] = __D2D_ScaleImageFactor($oD2D_ScaleEffect, _D2D_Effect_GetOutput($oD2D_ColorMatrixEffect), $iScreen)
	Else
		$aRet[0] = _D2D_Effect_GetOutput($oD2D_ColorMatrixEffect)
	EndIf

	Return $aRet
EndFunc   ;==>__D2D_LoadImageFromMemory

Func CheckOptimal()
	If $bUseNTR==True Then
		Local $sMsg1 = "Veo que tus configuraciones no son optimas. Deberías de cambiar:" & @CRLF & @CRLF
		Local $sMsg2 = @CRLF & "¡Y reinicia NTR CFW para tener un mejor rendimiento!" & @CRLF & @CRLF & _
				"Clickea en OK para cerrar este mensaje y Cancelar si no quieres ver este mensaje de nuevo."
		Local $bNotOptimal = False

		If ($iLayoutmode == 4 Or $iLayoutmode == 6 Or $iLayoutmode == 8) And $iPriorityMode == 0 Then
			$sMsg1 = $sMsg1 & "* Modo de prioridad: Pantalla Superior" & @CRLF
			$bNotOptimal = True
		EndIf
		If ($iLayoutmode == 5 Or $iLayoutmode == 7 Or $iLayoutmode == 9) And $iPriorityMode == 1 Then
			$sMsg1 = $sMsg1 & "* Modo de prioridad: Pantalla Inferior" & @CRLF
			$bNotOptimal = True
		EndIf
		If $iPriorityFactor > 0 Then
			$sMsg1 = $sMsg1 & "* La prioridad está en '0" & @CRLF
			$bNotOptimal = True
		EndIf

		If $bNotOptimal = True And IniRead($sFname, $sSectionName, $aIniSections[10], 0) == 0 Then
			Local $iMsgBoxAnswer = MsgBox(49, "¡Aviso!", $sMsg1 & $sMsg2)
			Select
				Case $iMsgBoxAnswer = 2 ;Cancel selected
					IniWrite($sFname, $sSectionName, $aIniSections[10], 1)
			EndSelect
		EndIf
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
	LogLine("Regresando a la ventana de conexión.", 1)
	$bStreaming = False
	If $bUseNTR==True Then
		UDPCloseSocket($iSocket)
		UDPShutdown()
	Else
		TCPCloseSocket($iSocket)
		TCPShutdown()
	EndIf
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	If $iLayoutmode == 10 Then GUIDelete($g_hGUI2)
	CreateMainGUIandSettings()

EndFunc   ;==>ReturnToConnectionWnd

Func CheckKeys()	;Alright, this is as polished as it's going to get.
	If _CheckPressedOnce($aHotkeys[0]) == True Then ScaleGUI(1.2, False)
	If _CheckPressedOnce($aHotkeys[1]) == True And $iHeight >= 200 Then ScaleGUI(1.2, True)
	If _CheckPressedOnce($aHotkeys[2]) == True Then
		If $iInterpolation > 0 Then $iInterpolation -= 1
		If $bD2D == True Then
			LogLine("La interpolación ha cambiado a " & $sD2D1InterpModeNames[$iInterpolation] & ".", 1)
		Else
			LogLine("La interpolación ha cambiado a " & $iInterpolation & ".", 1)
		EndIf
	EndIf
	If _CheckPressedOnce($aHotkeys[3]) == True Then
		If $bD2D == True Then
			If $iInterpolation < 5 Then $iInterpolation += 1
			LogLine("La interpolación ha cambiado a " & $sD2D1InterpModeNames[$iInterpolation] & ".", 1)
		Else
			If $iInterpolation < 7 Then $iInterpolation += 1
			LogLine("La interpolación ha cambiado a " & $iInterpolation & ".", 1)
		EndIf
	EndIf
	If _CheckPressedOnce($aHotkeys[4]) == True Then ReturnToConnectionWnd()
	If _CheckPressedOnce($aHotkeys[5]) == True Then
		CaptureScreenshot($g_hGUI,1)
		If IsDeclared($sGUI2) Then CaptureScreenshot($g_hGUI2,0)
	EndIf
	If _CheckPressedOnce($aHotkeys[6]) == True Then $bFullscreenPopup = Not $bFullscreenPopup
	If $bUseNTR == False Then
		If _CheckPressedOnce($aHotkeys[8]) == True And $iImageQuality<=99 Then
			$iImageQuality+=1
			_HzModChangeQuality($iSocket, $iImageQuality)
		EndIf
		If _CheckPressedOnce($aHotkeys[9]) == True And $iImageQuality>1 Then
			$iImageQuality-=1
			_HzModChangeQuality($iSocket, $iImageQuality)
		EndIf
	EndIf
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
			$iWidth = $iWidth * $iMultiplier
			$iHeight = $iHeight * $iMultiplier
			If IsDeclared($sGUI2) Then
				$iWidth2 = $iWidth2 * $iMultiplier
				$iHeight2 = $iHeight2 * $iMultiplier
			EndIf
		Else
			$iWidth = $iWidth / $iMultiplier
			$iHeight = $iHeight / $iMultiplier
			If IsDeclared($sGUI2) Then
				$iWidth2 = $iWidth2 / $iMultiplier
				$iHeight2 = $iHeight2 / $iMultiplier
			EndIf
		EndIf
		$aWinResize = WinGetPos($g_hGUI)
		WinMove($g_hGUI, "", Default, Default, $iWidth + $iWidthDiff, $iHeight + $iHeightDiff)
		If IsDeclared($sGUI2) Then
			$aWinResize2 = WinGetPos($g_hGUI2)
			WinMove($g_hGUI2, "", Default, Default, $iWidth2 + $iWidthDiff, $iHeight2 + $iHeightDiff)
		EndIf
		If $bD2D == False Then
			_GDIPlus_GraphicsDispose($g_hGraphics)
			$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
		EndIf
		LogLine("El tamaño de la ventana ha aumentado a  " & $iWidth & "x" & $iHeight & ".", 1)
	EndIf
EndFunc   ;==>ScaleGUI

Func CheckPCIP()
	If $bNoDisplayIPWarn == 0 And $sPCIpAddr <> "0.0.0.0" Then
		Local $iWarnButPressed = MsgBox($MB_ICONWARNING + $MB_YESNO, "¡Aviso!", "Configuró una dirección IP específica para su PC en el archivo de configuración. Esto no es necesario en la mayoría de los casos y pero" & _
				" puede dar como resultado una pantalla gris al intentar conectarse a su 3DS." & @CRLF & @CRLF & "Presione Sí para revertir esta configuración al valor predeterminado y escuche todas las IP asociadas con su computadora" & _
				" (recomendado) o No para mantener su configuración personalizada y nunca más mostrar esta advertencia.")
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
		$bUseNTR = IniRead($sFname, $sSectionName, $aIniSections[26], $bUseNTR)
		$iLogConsole = IniRead($sFname, $sSectionName, $aIniSections[27], $iLogConsole)
		$bEnableHzMNFCPatch = IniRead($sFname, $sSectionName, $aIniSections[30], $bEnableHzMNFCPatch)
		CheckPCIP()
	Else
		WriteConfig()
		;If we use WriteConfig for the first time, the written priority mode value will be wrong. We'll (over)write the right one with
		;this small piece of code.
		IniWrite($sFname, $sSectionName, $aIniSections[1], Int($iPriorityMode))
	EndIf

	;This region has been generated by KODA, then changed slightly manually
	#Region ### Koda GUI ha empezado ### Form=\gui\snickerstreamgui.kxf
	Global $SnickerstreamGUI = GUICreate($sGUITitle, 459, 202)
	Local $Label1 = GUICtrlCreateLabel("IP", 15, 26, 14, 17, $SS_CENTERIMAGE)
	Local $Label2 = GUICtrlCreateLabel("Prioridad", 15, 52, 81, 17, $SS_CENTERIMAGE)
	Local $Label3 = GUICtrlCreateLabel("Factor de prioridad", 15, 82, 95, 17, $SS_CENTERIMAGE)
	Local $Label4 = GUICtrlCreateLabel("Calidad de imagen", 15, 106, 87, 17, $SS_CENTERIMAGE)
	Global $Label5 = GUICtrlCreateLabel("Valor de QoS", 15, 130, 85, 17, $SS_CENTERIMAGE)
	Global $GUI_IpAddr = _GUICtrlIpAddress_Create($SnickerstreamGUI, 104, 24, 105, 17)
	_GUICtrlIpAddress_Set($GUI_IpAddr, "0.0.0.0")
	Global $GUI_PriorityMode = GUICtrlCreateCombo("", 104, 50, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Pantalla superior|Pantalla inferior", "Pantalla superior")
	Global $GUI_PriorityFactor = GUICtrlCreateInput("5", 104, 80, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	Global $GUI_ImageQuality = GUICtrlCreateInput("90", 104, 104, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	Global $GUI_QoS = GUICtrlCreateInput("20", 104, 128, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	Local $Label6 = GUICtrlCreateLabel("Interpolación", 243, 56, 62, 17, $SS_CENTERIMAGE)
	Global $GUI_Interpolation = GUICtrlCreateCombo("", 321, 54, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, _ArrayToString($sD2D1InterpModeNames), $sD2D1InterpModeNames[0])
	Local $Label7 = GUICtrlCreateLabel("Posición", 243, 80, 69, 17, $SS_CENTERIMAGE)
	Global $GUI_Layoutmode = GUICtrlCreateCombo("", 321, 80, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	If $bUseNTR == True Then
		GUICtrlSetData(-1, "Vertical|Vertical(invertido)|Horizontal|Horizontal(invertido)|Solo pantalla superior|Solo pantalla inferior|Fullscreen(Superior, st.)|Pantalla completa(Inferior, st.)|Pantalla completa(Superior)|Pantalla completa(Inferior)|Ventanas separadas", "Vertical")
	Else
		GUICtrlSetData(-1, "Solo pantalla superior|Pantalla completa(Superior, st.)|Pantalla completa(Top)", "Solo pantalla superior")
	EndIf
	Global $GUI_ConnectBtn = GUICtrlCreateButton("¡Conectar!", 232, 160, 217, 33)
	Global $GUI_NFCBtn = GUICtrlCreateButton("Parche NFC", 384, 128, 65, 25)
	Local $Group1 = GUICtrlCreateGroup("Configuración del stream", 8, 8, 217, 185)
	Global $GUI_Preset = GUICtrlCreateCombo("", 103, 160, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	LoadPresets()
	GUICtrlSetOnEvent(-1, "GUI_PresetChange")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Local $Group2 = GUICtrlCreateGroup("Otras opciones", 232, 8, 217, 105)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $GUI_AboutBtn = GUICtrlCreateButton("Sobre", 232, 128, 65, 25)
	Local $Label8 = GUICtrlCreateLabel("Tipo de Stream", 243, 32, 75, 17, $SS_CENTERIMAGE)
	Global $GUI_Streaming = GUICtrlCreateCombo("", 322, 27, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "NTR CFW|HzMod", "NTR CFW")
	If $bUseNTR == False Then _GUICtrlComboBox_SetCurSel($GUI_Streaming, 1)
	GUICtrlSetOnEvent(-1, "GUI_StreamingAppChange")
	Local $Label9 = GUICtrlCreateLabel("Configuración", 15, 162, 87, 17, $SS_CENTERIMAGE)
	Global $GUI_AdvButton = GUICtrlCreateButton("Avanzado", 304, 128, 73, 25)
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
	If $bD2D == True And $iInterpolation > 6 Then ;Failsafe in case we get an invalid interpolation mode for D2D
		$iInterpolation = 0
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation, $iInterpolation)
	_GUICtrlComboBox_SetCurSel($GUI_Layoutmode, $iLayoutmode)

	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitMain", $SnickerstreamGUI)
	GUICtrlSetOnEvent($GUI_AboutBtn, "AboutScreen")
	GUICtrlSetOnEvent($GUI_NFCBtn, "SendNFC")
	GUICtrlSetOnEvent($GUI_ConnectBtn, "StartStream")
	GUICtrlSetOnEvent($GUI_AdvButton, "AdvMenu")

	If $bUseNTR == False Then SettingsStateSet($GUI_DISABLE)
EndFunc   ;==>CreateMainGUIandSettings

Func UpdateVars()
	;We need to call this function when the user clicked on connect/saving presets to correctly update the variables
	$sIpAddr = _GUICtrlIpAddress_Get($GUI_IpAddr)
	$iPriorityMode = Int(Not _GUICtrlComboBox_GetCurSel($GUI_PriorityMode))
	$iPriorityFactor = Int(GUICtrlRead($GUI_PriorityFactor))
	$iImageQuality = Int(GUICtrlRead($GUI_ImageQuality))
	If $iImageQuality < 10 And $bUseNTR == True Then $iImageQuality = 10
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
	IniWrite($sFname, $sSectionName, $aIniSections[26], $bUseNTR)
	IniWrite($sFname, $sSectionName, $aIniSections[27], $iLogConsole)
	If IniRead($sFname, $sSectionName, $aIniSections[14], -1) < 0 Then IniWrite($sFname, $sSectionName, $aIniSections[14], 1000)
	IniWrite($sFname, $sSectionName, $aIniSections[20], $iListenPort)
	If IniRead($sFname, $sSectionName, $aIniSections[25], 0)==0 Then IniWrite($sFname, $sSectionName, $aIniSections[25], _ArrayToString($aHotkeys,$sSettingSeparator))
EndFunc   ;==>WriteConfig

Func SendNFC()
	ButtonStateSet($GUI_DISABLE)
	If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer = IniRead($sFname, $sSectionName, $aIniSections[13], -1)
	If $iMsgBoxAnswer == -1 Then $iMsgBoxAnswer = MsgBox(67, "Escoge la verisón de firmware de 3DS", "Sí -> Firmware >= 11.4" & @CRLF & "No -> Firmware <= 11.3" & @CRLF & _
			"Cancelar -> Ir atrás" & @CRLF & @CRLF & "Snickerstream-ES te preguntará hasta que no respondas a esta pregunta.")
	Select
		Case $iMsgBoxAnswer = 6 ;Yes
			If $bUseNTR == True Then
				Local $iRet = _NTRSendNFCPatch($sIpAddr, "005b10") ;Offset must be in little-endian
			Else
				Local $iRet = _HzModSendNFCPatch($sIpAddr, "005b10")
			EndIf
			IniWrite($sFname, $sSectionName, $aIniSections[13], 6)
			LogLine("Enviando Parche NFC (>=11.4).", 1)
		Case $iMsgBoxAnswer = 7 ;No
			If $bUseNTR == True Then
				Local $iRet = _NTRSendNFCPatch($sIpAddr, "e45a10") ;Same as above
			Else
				Local $iRet = _HzModSendNFCPatch($sIpAddr, "e45a10")
			EndIf
			IniWrite($sFname, $sSectionName, $aIniSections[13], 7)
			LogLine("Enviando Parche NFC (<=11.3).", 1)
	EndSelect
	If $iMsgBoxAnswer >= 6 Then
		If $iRet = -1 Then
			LogLine("Error enviado el parche NFC, no se ha podido conectar.", 1)
			MsgBox($MB_ICONERROR, "Error conexión", "No se ha podido conectar a la (N)3DS.")
		Else
			LogLine("Parche NFC enviado satisfactoriamente.", 1)
			MsgBox($MB_ICONINFORMATION, "¡Éxito!", "Parche NFC enviado satisfactoriamente")
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
	If IsDeclared("oD2D_DeviceContext") <> 0 Then
		ExitStreaming()
	EndIf
	LogLine("Saliendo.", 1)
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
	LogLine("Saliendo.", 1)
	;Close the UDP socket
	If $bUseNTR==True Then
		UDPCloseSocket($iSocket)
		UDPShutdown()
	Else
		TCPCloseSocket($iSocket)
		TCPShutdown()
	EndIf
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>ExitStreaming

Func LogStart()
	Global $hConsole = -1

	If $iLogLevel > 0 Then
		If $iLogConsole == 0 Or $iLogConsole == 2 Then
			Local $hFile = FileOpen($sLogFname, $FO_OVERWRITE)

			FileWriteLine($hFile, "  ___      _    _              _")
			FileWriteLine($hFile, " / __|_ _ (_)__| |_____ _ _ __| |_ _ _ ___ __ _ _ __")
			FileWriteLine($hFile, " \__ \ ' \| / _| / / -_) '_(_-<  _| '_/ -_) _` | '  \")
			FileWriteLine($hFile, " |___/_||_|_\__|_\_\___|_| /__/\__|_| \___\__,_|_|_|_|")
			FileWriteLine($hFile, _StringRepeat("-", 113))
			If $iLogLevel <= 3 Then
				Switch Random(0, 11, 1)
					Case 0
						FileWriteLine($hFile, "it hac, it bric, pero lo más importante, it S N I C C")
					Case 1
						FileWriteLine($hFile, "*fantasmas* AL9H.")
					Case 2
						FileWriteLine($hFile, "Solo código de espagueti en las rocas. *risita*")
					Case 3
						FileWriteLine($hFile, "Una forma más de que Nintendo elimine los derechos de autor.")
					Case 4
						FileWriteLine($hFile, "¿A qué esperas, Nintendo para hacer uno?")
					Case 5
						FileWriteLine($hFile, "¡Aquí está tu regalo de Navidad! <3")
					Case 6
						FileWriteLine($hFile, "* El perro absorbe el chorro.")
					Case 7
						FileWriteLine($hFile, "Tan suave como los FMV en un CD de Sega.")
					Case 8
						FileWriteLine($hFile, "[la estabilidad se intensifica]")
					Case 9
						FileWriteLine($hFile, "¡Ahora con un 500 % más de iconos!")
					Case 10
						FileWriteLine($hFile, "Para la gloria de framekind.")
					Case 11
						FileWriteLine($hFile, "Si el nivel de registro 3 es tan bueno, ¿por qué no hay un nivel de registro 4?")
				EndSwitch
			Else
				If $iLogLevel == 4 Then
					FileWriteLine($hFile, "Estaba bromeando sobre el nivel de registro 4, ya sabes.")
				Else
					FileWriteLine($hFile, "Eso es todo. Ya no somos amigos hasta que vuelvas a establecer el nivel de registro en algo válido >_>")
				EndIf
			EndIf
			FileWriteLine($hFile, _StringRepeat("-", 113))
			FileWriteLine($hFile, "VERSION : " & $sVersion)
			FileWriteLine($hFile, "LOGLEVEL: " & $iLogLevel)
			FileWriteLine($hFile, _StringRepeat("-", 113))
			FileClose($hFile)
		EndIf
		If $iLogConsole > 0 Then ConsoleInit()
		LogLine("Inicio de sesión.", 1)
	EndIf
EndFunc   ;==>LogStart

Func LogLine($sLogString, $iReqLogLevel)
	If $iLogLevel >= $iReqLogLevel Then
		If $iLogConsole > 0 Then ConsoleLogLine($sLogString)
		If $iLogConsole == 0 Or $iLogConsole == 2 Then
			Local $hFile = FileOpen($sLogFname, $FO_APPEND)

			FileWriteLine($hFile, "[" & @HOUR & ":" & @MIN & "] " & $sLogString)
			FileClose($hFile)
		EndIf
	EndIf
EndFunc   ;==>LogLine

Func ConsoleInit()
	Global $hK32dll = DllOpen("kernel32.dll")
	$hConsole = -1
	DllCall($hK32dll, "bool", "AllocConsole")
	DllCall($hK32dll, "bool", "AttachConsole", "dword", -1)
	If @Compiled Then
		Local $aRet = DllCall($hK32dll, "handle", "GetStdHandle", "dword", -11)
		If IsArray($aRet) Then
			$hConsole = $aRet[0]
		EndIf
	Else
		ConsoleLogLine("El script no está compilado o no se pudo abrir la ventana de la consola. Redirigir la salida de la consola al registro de SciTE.")
	EndIf
EndFunc

Func ConsoleLogLine($sText)
	If $hConsole<>-1 And $hConsole<>0 Then
		DllCall($hK32dll, "bool", "WriteConsoleA", "handle", $hConsole, "str", $sText&@CRLF, "dword", StringLen($sText)+2, "dword*", 0, "ptr", 0)
	Else
		ConsoleWrite($sText&@CRLF)
	EndIf
EndFunc

Func CheckIfStreaming($sRemoteIP)
	Local $hTimerTimeout = TimerInit()
	Global $bRecieved = False
	Local $bChecked = False
	Local Const $iTimeout = IniRead($sFname, $sSectionName, $aIniSections[14], 1000)
	Local Const $sConnectionError = "Error de conexión"
	While $bRecieved == False
		Local $dRecv = UDPRecv($iSocket, 2000, 1)
		If TimerDiff($hTimerTimeout) >= $iTimeout And $bChecked == False Then
			WinSetTitle($g_hGUI, "", $sSectionName & " - Empezando capturadora...")
			LogLine("Empezando capturadora de 3DS.", 1)
			Local $iRet = _NTRInitRemoteplay($sRemoteIP, $iPriorityMode, $iPriorityFactor, $iImageQuality, $iQoS)
			$hTimerTimeout = TimerInit()	;The console is confirmed to be online, reset the timer for later use
			If $iRet = -1 Then
				LogLine("No se pude conectar la capturadora.", 1)
				MsgBox($MB_ICONERROR, $sConnectionError, "Fallo al iniciar la capturadora de (N)3DS.")
				ExitOnStreamFail()
				Return -1
			EndIf
			$bChecked = True
		EndIf
		If $dRecv <> "" Then
			$bRecieved = True
			LogLine("Recibiendo stream.", 1)
		ElseIf $dRecv=="" And TimerDiff($hTimerTimeout)>=$iTimeout And $iRet<>-1 Then
			MsgBox($MB_ICONERROR, $sConnectionError, "No se pudo recibir la transmisión desde su consola."&@CRLF&@CRLF&"Esto suele suceder si un firewall está bloqueando Snickerstream-ES"& _
			" o si el puerto de transmisión está configurado incorrectamente. Intente permitir Snickerstream en su firewall, ejecútelo como administrador y verifique dos veces el puerto de transmisión en el menú avanzado" & _
			" (debería ser 8001 si no parcheó NTR).")
			ExitOnStreamFail()
			Return -1
		EndIf
	WEnd
EndFunc   ;==>CheckIfStreaming

Func ExitOnStreamFail()
	$bStreaming = False
	$bRecieved = True
	If $bUseNTR==True Then
		UDPCloseSocket($iSocket)
		UDPShutdown()
	Else
		TCPCloseSocket($iSocket)
		TCPShutdown()
	EndIf
	CheckAndShutdownGDIp()
	GUIDelete($g_hGUI)
	CreateMainGUIandSettings()
EndFunc

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
					MsgBox(16, "¡Error!", "¡El ajuste preestablecido personalizado está corrupto!")
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
	If $bUseNTR == True Then GUICtrlSetData($GUI_QoS, $iQoSP)
EndFunc   ;==>SetPreset

Func GUI_RenderingChange()
	If _GUICtrlComboBox_GetCurSel($GUI_Rendering) == 0 Then
		$bD2D = True
		GUICtrlSetData($GUI_Interpolation, $sSettingSeparator&_ArrayToString($sD2D1InterpModeNames), $sD2D1InterpModeNames[0])
		If _GUICtrlComboBox_GetCurSel($GUI_Streaming) == 0 Then
			GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(invertido)|Horizontal|Horizontal(invertido)|Solo pantalla superior|Solo pantalla inferior|Pantalla completa(Sup.,st.)|Pantalla completa(Inf.,st.)|Pantalla completa(Sup.)|Pantalla completa(Inf.)|Ventanas separadas", "Vertical")
		Else
			GUICtrlSetData($GUI_Layoutmode, "|Solo pantalla superior|Pantalla completa(Sup.,st.)|Pantalla completa(Sup.)", "Solo pantalla superior")
		EndIf
	Else
		If IniRead($sFname, $sSectionName, $aIniSections[12], 1) == 1 Then
			MsgBox(48, "¡Aviso!", "El renderizador GDI+ ha quedado obsoleto. Todavía puede usarlo, pero no hay una razón real para usarlo sobre Direct2D, ya que el último es mejor literalmente en todas las formas posibles." & @CRLF & @CRLF & _
					"A menos que REALMENTE sepa lo que está haciendo, debe usar el renderizador Direct2D en su lugar." & @CRLF & @CRLF & "Haga clic en Aceptar para continuar (esta advertencia no volverá a aparecer).")
			IniWrite($sFname, $sSectionName, $aIniSections[12], 0)
		EndIf
		$bD2D = False
		GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
		GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(invertido)|Horizontal|Horizontal(invertido)|Solo pantalla superior|Solo pantalla inferior|Fullscreen(Top,st.)|Fullscreen(Bot,st.)", "Vertical")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation, 0)
	IniWrite($sFname, $sSectionName, $aIniSections[11], $bD2D)
EndFunc   ;==>GUI_RenderingChange

Func SettingsStateSet($GUIState)
	GUICtrlSetState($GUI_PriorityMode, $GUIState)
	If $GUIState == $GUI_DISABLE Then
		GUICtrlSetData($Label5, "Limite los ciclos de CPU")
		GUICtrlSetData($GUI_QoS, 0)
	Else
		GUICtrlSetData($Label5, "Valor de la calidad del servicio")
		GUICtrlSetData($GUI_QoS, 20)
	EndIf
	GUICtrlSetState($GUI_PriorityFactor, $GUIState)
	If $bUseNTR==False And $bEnableHzMNFCPatch==False Then
		GUICtrlSetState($GUI_NFCBtn, $GUI_DISABLE)
	Else
		GUICtrlSetState($GUI_NFCBtn, $GUI_ENABLE)
	EndIf
EndFunc   ;==>ButtonStateSet

Func GUI_StreamingAppChange()
	If $bD2D == True Then
		If _GUICtrlComboBox_GetCurSel($GUI_Streaming) == 0 Then
			$bUseNTR = True
			GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(invertido)|Horizontal|Horizontal(invertido)|Solo pantalla superior|Solo pantalla inferior|Fullscreen(Top,st.)|Fullscreen(Bot,st.)", "Vertical")
			SettingsStateSet($GUI_ENABLE)
		Else
			$bUseNTR = False
			GUICtrlSetData($GUI_Layoutmode, "|Solo pantalla superior|Pantalla completa(Sup.,st.)|Pantalla completa(Sup.)", "Solo pantalla superior")
			SettingsStateSet($GUI_DISABLE)
		EndIf
	Else
		$bUseNTR = True
		MsgBox(16, "Error", "El renderizador GDI+ no es compatible con HzMod.")
		_GUICtrlComboBox_SetCurSel($GUI_Streaming,0)
	EndIf
EndFunc

Func ReturnDecNumber($sNum)
	Return Number(StringRegExpReplace($sNum, "[^\d\.]", ""))
EndFunc   ;==>ReturnDecNumber

Func CheckForUpdates()
	If StringLeft($sVersion, 3) <> "git" And IniRead($sFname, $sSectionName, $aIniSections[17], 0) == 0 Then
		Local $sLatestFullVer = _GetGithubLatestReleaseTag("RattletraPM", "Snickerstream")
		Local $sLatestVer = ReturnDecNumber($sLatestFullVer)

		If @error <> -1 And $sLatestVer > ReturnDecNumber($sVersion) Then
			If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
			$iMsgBoxAnswer = MsgBox(67, "¡Nueva versión estable disponible!", "¡Ya está disponible para descargar una nueva versión estable de Snickerstream!" & @CRLF & @CRLF & _
					"Versión actual: " & $sVersion & @CRLF & "Ultima versión: " & $sLatestFullVer & @CRLF & @CRLF & "¿Quiere visitar la página de lanzamientos de GitHub de Snickerstream?" & @CRLF & @CRLF & _
					"(Al hacer clic en Cancelar, se desactivará la función de actualización automática de Snickerstream al no buscar versiones más nuevas nunca más)")
			Select
				Case $iMsgBoxAnswer = 6 ;Yes
					ShellExecute("https://github.com/JustSofter/Snickerstream-ES/releases")
				Case $iMsgBoxAnswer = 2 ;Cancel
					IniWrite($sFname, $sSectionName, $aIniSections[17], 1)
			EndSelect
		EndIf
	EndIf
EndFunc   ;==>CheckForUpdates

Func AdvMenu()
	If IniRead($sFname, $sSectionName, $aIniSections[21], 0) == 0 Then
		MsgBox(48, "¡Aviso!", "Esta configuración se llama avanzada por una razón: si no sabe lo que está haciendo, podría degradar su rendimiento de transmisión o hacer que no pueda transmitir en absoluto hasta que restablezca su configuración/reinstale NTR." & _
				@CRLF & @CRLF & "¡Proceda bajo su propio riesgo!")
		IniWrite($sFname, $sSectionName, $aIniSections[21], 1)
	EndIf
	Global $AdvancedMenu = GUICreate("Opciones avanzadas.", 415, 265)
	Local $LabelA1 = GUICtrlCreateLabel("Puerto:", 8, 10, 70, 17, $SS_CENTERIMAGE)
	Global $GUI_PortInput = GUICtrlCreateInput($iListenPort, 75, 8, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_PatchBtn = GUICtrlCreateButton("Parchear NTR", 115, 6, 85, 25)
	Global $GUI_ApplyBtn = GUICtrlCreateButton("Aplicar", 206, 222, 195, 35)
	Local $LabelA3 = GUICtrlCreateLabel("Loglevel:", 8, 42, 47, 17, $SS_CENTERIMAGE)
	Global $LoglevelInput = GUICtrlCreateInput($iLogLevel, 128, 40, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA4 = GUICtrlCreateLabel("IP de la PC:", 208, 10, 75, 17, $SS_CENTERIMAGE)
	Global $IPAddressInput = _GUICtrlIpAddress_Create($AdvancedMenu, 304, 8, 101, 17)
	_GUICtrlIpAddress_Set($IPAddressInput, $sPCIpAddr)
	Local $LabelA5 = GUICtrlCreateLabel("Límite de cuadros:", 8, 66, 100, 17, $SS_CENTERIMAGE)
	Global $FrameLimitInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[15], 0), 128, 64, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA6 = GUICtrlCreateLabel("Esperar por remoteplay:", 8, 234, 132, 17, $SS_CENTERIMAGE)
	Global $WaitForRemoteplayInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[14], 1000), 128, 234, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA7 = GUICtrlCreateLabel("Retornar después de apagado:", 208, 90, 165, 17, $SS_CENTERIMAGE)
	Global $ReturnAfterMsecInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[16], 8000), 360, 88, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA8 = GUICtrlCreateLabel("Escala de pantalla sup.:", 8, 90, 120, 17, $SS_CENTERIMAGE)
	Global $TopScalingInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[22], 1), 128, 88, 41, 21, $GUI_SS_DEFAULT_INPUT)
	Local $LabelA9 = GUICtrlCreateLabel("Escala de pantalla inf.:", 8, 114, 120, 17, $SS_CENTERIMAGE)
	Global $BotScalingInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[23], 1), 128, 112, 41, 21, $GUI_SS_DEFAULT_INPUT)
	Local $LabelA10 = GUICtrlCreateLabel("Ancho personalizado:", 8, 138, 113, 17, $SS_CENTERIMAGE)
	Global $CustomWidthInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[18], 0), 128, 136, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA11 = GUICtrlCreateLabel("Alto personalizado:", 8, 162, 117, 17, $SS_CENTERIMAGE)
	Global $CustomHeightInput = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[19], 0), 128, 160, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA12 = GUICtrlCreateLabel("Comprobar actualizaciones:", 208, 114, 144, 17, $SS_CENTERIMAGE)
	Global $CheckUpdatesCheckbox = GUICtrlCreateCheckbox("", 360, 112, 17, 17)
	If IniRead($sFname, $sSectionName, $aIniSections[17], 0)==0 Then GUICtrlSetState(-1, $GUI_CHECKED)
	Local $LabelA13 = GUICtrlCreateLabel("Centrar:", 208, 138, 96, 17, $SS_CENTERIMAGE)
	Global $CenterScreensCheckbox = GUICtrlCreateCheckbox("", 360, 136, 17, 17)
	If IniRead($sFname, $sSectionName, $aIniSections[24], 1)==1 Then GUICtrlSetState(-1, $GUI_CHECKED)

	Local $LabelA14 = GUICtrlCreateLabel("Renderizador:", 208, 66, 120, 17, $SS_CENTERIMAGE)
	Global $GUI_Rendering = GUICtrlCreateCombo("", 288, 64, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Direct2D (hw/sw)|GDI+ (sw)", "Direct2D (hw/sw)")
	Local $LabelA15 = GUICtrlCreateLabel("Ancho personalizado #2:", 8, 186, 120, 17, $SS_CENTERIMAGE)
	Global $CustomWidth2Input = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[28], 0), 128, 186, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA16 = GUICtrlCreateLabel("Alto personalizado #2:", 8, 210, 120, 17, $SS_CENTERIMAGE)
	Global $CustomHeight2Input = GUICtrlCreateInput(IniRead($sFname, $sSectionName, $aIniSections[29], 0), 128, 210, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Local $LabelA17 = GUICtrlCreateLabel("Log output:", 208, 42, 60, 17, $SS_CENTERIMAGE)
	Global $GUI_LogConsole = GUICtrlCreateCombo("", 288, 40, 113, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Archivo|Consola|Ambos","Archivo")
	Global $GUI_RemapHotkeysBtn = GUICtrlCreateButton("Remapear teclas", 206, 190, 85, 25)
	Global $LabelA18 = GUICtrlCreateLabel("", 300, 195, 130, 17, $SS_CENTERIMAGE)
	Local $LabelA19 = GUICtrlCreateLabel("Activar parche NFC de HzMod:", 208, 160, 160, 15, $SS_CENTERIMAGE)
	Global $EnableHzMNFCCheckbox = GUICtrlCreateCheckbox("", 360, 160, 17, 17)
	If IniRead($sFname, $sSectionName, $aIniSections[30], 1)==True Then GUICtrlSetState(-1, $GUI_CHECKED)

	GUICtrlSetOnEvent($GUI_PatchBtn, "PatchNTR")
	GUICtrlSetOnEvent($GUI_ApplyBtn, "ApplyAdvSettings")
	GUICtrlSetOnEvent($GUI_RemapHotkeysBtn, "RemapHotkeys")
	GUICtrlSetOnEvent($EnableHzMNFCCheckbox, "HzModNFCWarn")
	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitAdvanced")
	If $bD2D == True Then
		_GUICtrlComboBox_SetCurSel($GUI_Rendering, 0)
	Else
		_GUICtrlComboBox_SetCurSel($GUI_Rendering, 1)
		GUICtrlSetData($GUI_Interpolation, "|Por defecto|Baja calidad|Alta calidad|Bilineal|Bicubico|Más cercano|Bilineal (HQ)|Bicubico (HQ)", "Por defecto")
		GUICtrlSetData($GUI_Layoutmode, "|Vertical|Vertical(invertido)|Horizontal|Horizontal(invertido)|Solo pantalla superior|Solo pantalla inferior|Fullscreen(Top,st.)|Fullscreen(Bot,st.)", "Vertical")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_LogConsole, $iLogConsole)
	GUISetState(@SW_SHOW)
EndFunc   ;==>AdvMenu

Func HzModNFCWarn()
	If GUICtrlRead($EnableHzMNFCCheckbox)==$GUI_CHECKED Then
		MsgBox(48,"¡'Aviso'!","En la versión lanzada actualmente (9 de febrero de 2018), la aplicación de parches NFC está rota en HzMod debido a un error en su función DMA_IN. Es por eso que el botón Enviar parche NFC está deshabilitado de forma predeterminada al seleccionarlo como su aplicación de transmisión." & _
		@CRLF & @CRLF & "Esta opción está aquí para permitirle usar el parche en caso de que se publique una versión actualizada con ese error solucionado. Enviarlo a una versión con el error bloqueará HzMod mientras tu juego intenta cargar NFC. No se producirán daños permanentes en su 3DS, pero tendrá que apagarlo para volver a transmitir." & _
		@CRLF & @CRLF & "¡Debes dejar esta opción desactivada a menos que sepas lo que estás haciendo!")
	EndIf
EndFunc

Func WaitForKey($hDll, $sText, $bSeparator, $sCurHotkeys)
	Local $dDetectedKey

	GUICtrlSetData($LabelA18, $sText)

	While $dDetectedKey==""
		Sleep(50)
		For $i = 7 To 254
			If _IsPressed(Hex($i), $hDll) Then
				$dDetectedKey = Hex($i, 2)
			EndIf
			Do
			Until _IsPressed($dDetectedKey, $hDll) == False
			If StringInStr($sCurHotkeys,$dDetectedKey)<>0 Then	;Check if key has already been assigned
				$dDetectedKey=""
				DllCall ("user32.dll", "int", "MessageBeep", "int", 0x00000010)	;Error sound
			EndIf
		Next
	WEnd

	If $bSeparator==True Then
		Return $dDetectedKey&$sSettingSeparator
	Else
		Return $dDetectedKey
	EndIf
EndFunc

Func RemapHotkeys()
	Local $hDll = DllOpen("user32.dll"), $sHotkeysStr
	GUICtrlSetState($GUI_RemapHotkeysBtn, $GUI_DISABLE)
	GUICtrlSetData($GUI_RemapHotkeysBtn, "Presiona una tecla:")
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "SCALE UP", True, $sHotkeysStr)	;Holy spaghetti code, batman!
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "SCALE DOWN", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "PREV. INTERP.", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "NEXT INTERP.", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "RETURN WINDOW", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "SCREENSHOT", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "SCREEN POPUP", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "CLOSE", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "HZM QUALITY-", True, $sHotkeysStr)
	$sHotkeysStr=$sHotkeysStr&WaitForKey($hDll, "HZM QUALITY+", False, $sHotkeysStr)
	GUICtrlSetData($GUI_RemapHotkeysBtn, "Remapear teclas")
	GUICtrlSetData($LabelA18, "")
	IniWrite($sFname, $sSectionName, $aIniSections[25], $sHotkeysStr)
	GUICtrlSetState($GUI_RemapHotkeysBtn, $GUI_ENABLE)
	DllClose($hDll)
	MsgBox(64,"¡Éxito!","¡Teclas remapeadas guardadas satisfactoriamente!")
EndFunc

Func AboutScreen()
	Global $AboutScreen = GUICreate("About", 310, 245)
	GUICtrlCreateIcon($sIconPath, -1, 20, 20)
	GUICtrlCreateLabel($sSectionName, 67, 17, 500, 33)
	GUICtrlSetFont(-1, 27, 780, 0, "MS Sans Serif")
	GUICtrlCreateLabel($sVersion, 67, 50, 40, 20)
	Local $Edit1 = GUICtrlCreateEdit("", 20, 70, 270, 160, BitOR($ES_READONLY,$ES_WANTRETURN,$WS_VSCROLL))
	GUICtrlSetData(-1, "Original por RalletraPM"&@CRLF&@CRLF&"Este programa y su código fuente están respaldados por la licencia de GPL 3.0.  Mire license.txt para leer la licencia completa."& _
	@CRLF&@CRLF&"Créditos:"&@CRLF&"**Desarrollador de HzMod y ayuda general** Sono"&@CRLF&"**Direct2D y WIC UDFs** trancexx and Eukalyptus."&@CRLF&"**Beta testers** ElderCub, TehJ3sse, Eldurislol, Silly Chip."&@CRLF&"**Sugerencias de funciones** ElderCub, "& _
	"Real96, DaWoblefet"&@CRLF&"**Íconos** Trinsid."&@CRLF&"**Donadores** Rokkuman."&@CRLF&@CRLF&"Si me olvidé de mencionar a alguien, díganme!"&@CRLF&@CRLF&"Además, si quieres apoyar el desarrollo de Snickerstream, puedes donar por medio de PayPal "& _
	"en lucapm@live.it - las donaciones no son necesarias, pero se aprecia mucho!")
	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitAbout")
	GUISetState(@SW_SHOW)
EndFunc

Func PatchNTR()
	ButtonStateSet($GUI_DISABLE)
	Local $iPort = GUICtrlRead($GUI_PortInput)
	Local Const $sOldWorkingDir=@WorkingDir

	If $iPort > 0 And $iPort <= 65535 Then
		If _NTRCheckPortBug($iPort) == False Then
			Local $sNTRPath = FileOpenDialog("Selecciona un binario de NTR", @WorkingDir, "Archivo binario (*.bin)", 0, "ntr.bin")
			Local $hNTRRead = FileOpen($sNTRPath, 16)
			Local $dNTRHash = _Crypt_HashData(FileRead($hNTRRead, 150007), $CALG_MD5) ;After that point, NTR's regular binary and the one downloaded by BootNTRSelector differ in some areas

			FileClose($hNTRRead)
			If FileExists($sNTRPath) And @error == 0 Then
				If $dNTRHash == "0xD707E3BFB90C512DCED1225223BE830F" Then
					Local $iMsgBoxAnswer = MsgBox(36, "¿Estás seguro?", "Estás por parchear tu binario de NTR para enviar cuadros por el puerto UDP " & $iPort & "." & @CRLF & "¿Estás seguro?")

					If $iMsgBoxAnswer = 6 Then
						If $iPort > 0 And $iPort <= 65535 Then
							Local $iNTRRet=_NTRPatchPort($sNTRPath, $iPort)
							If $iNTRRet==1 Then
								If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
								$iMsgBoxAnswer = MsgBox(36,"¿Cambiar puerto?","¿También quieres cambiar el puerto de Snickerstream al mismo del binario parcheado de NTR?" & @CRLF & @CRLF & "(Si no estás seguro, selecciona Sí.)")
								If $iMsgBoxAnswer = 6 Then ;Yes
									IniWrite($sFname, $sSectionName, $aIniSections[20], $iPort)
									GUICtrlSetData($GUI_PortInput,$iPort)
									MsgBox(64,"¡OK!","¡Todo hecho!")
								EndIf
							EndIf
						Else
							MsgBox(16, "Error", "El número del puerto debe de estar entre 1 y 65535.") ;All these nested If statements make me want to cry
						EndIf
					EndIf
				Else
					MsgBox(16, "Binario no válido y/o no soportado", "El binario que seleccionaste de NTR no es válido y/o tampoco es soportado." & @CRLF & _
							@CRLF & "Ten en cuenta que solo NTR(3.6) es soportado. Intenta descargar el binario de NTRBootSelector o el repositorio de GitHub.")
				EndIf
			EndIf
		EndIf
	Else
		MsgBox(16, "Error", "El número del puerto debe de estar entre 1 y 65535.")
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

	Local $iPort = GUICtrlRead($GUI_PortInput), $bError = False, $iLogLevelRead = GUICtrlRead($LoglevelInput), $TopScalingRead = GUICtrlRead($TopScalingInput), _
	$BotScalingRead = GUICtrlRead($BotScalingInput), $CustomWidthRead = GUICtrlRead($CustomWidthInput), $CustomHeightRead = GUICtrlRead($CustomHeightInput), _
	$CustomWidth2Read = GUICtrlRead($CustomWidth2Input), $CustomHeight2Read = GUICtrlRead($CustomHeight2Input), $iLogConsoleRead = _GUICtrlComboBox_GetCurSel($GUI_LogConsole)

	If $iPort < 0 Or $iPort > 65535 Then $bError=ApplyAdvError("El número del puerto debe de estar entre 1 y 65535.")
	If _NTRCheckPortBug($iPort) == True Then $bError=True
	If $iLogLevelRead > 3 Then $bError=ApplyAdvError("El nivel de log debe de estar entre 1 y 3.")
	If $TopScalingRead < 0.3 Or $BotScalingRead < 0.3 Then $bError=ApplyAdvError("La escala superior e inferior deben de ser más que 0.3.")
	If ($CustomWidthRead>0 And $CustomWidthRead < 150) Or ($CustomWidth2Read>0 And $CustomWidth2Read < 150) Then $bError=ApplyAdvError("Custom width & custom width 2 must be both either 0 (disabled) or higher than 149.")
	If ($CustomHeightRead>0 And $CustomHeightRead < 200) Or ($CustomHeight2Read>0 And $CustomHeight2Read < 200) Then $bError=ApplyAdvError("Custom height & custom height 2 must be both either 0 (disabled) or higher than 199.")
	If _GUICtrlComboBox_GetCurSel($GUI_Streaming) == 1 And _GUICtrlComboBox_GetCurSel($GUI_Rendering) == 1 Then $bError=ApplyAdvError("The GDI+ renderer doesn't support HzMod."&@CRLF&"Please change your renderer to Direct2D or your streaming app to NTR.")
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
		IniWrite($sFname, $sSectionName, $aIniSections[28], $CustomWidth2Read)	;CustomWidth2
		IniWrite($sFname, $sSectionName, $aIniSections[29], $CustomHeight2Read)	;CustomHeight2
		If $iLogConsole <> $iLogConsoleRead Then
			MsgBox(64, "Info", "Cambios al output de logs tendrán efecto después de reiniciar Snickerstream-ES.")
			IniWrite($sFname, $sSectionName, $aIniSections[27], $iLogConsoleRead)	;LogConsole
		EndIf
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
		If GUICtrlRead($EnableHzMNFCCheckbox)==$GUI_CHECKED Then	;Center Screens
			IniWrite($sFname, $sSectionName, $aIniSections[30], True)
			$bEnableHzMNFCPatch=True
		Else
			IniWrite($sFname, $sSectionName, $aIniSections[30], False)
			$bEnableHzMNFCPatch=False
		EndIf
		GUI_RenderingChange()	;Change renderer
		MsgBox(64, "Hecho", "¡Configuraciones aplicadas satisfactoriamente!")
	EndIf

	GUICtrlSetState($GUI_ApplyBtn, $GUI_ENABLE)
	ButtonStateSet($GUI_ENABLE)
	If $bUseNTR==False And $bEnableHzMNFCPatch==True Then
		GUICtrlSetState($GUI_NFCBtn, $GUI_ENABLE)
	ElseIf $bUseNTR==False And $bEnableHzMNFCPatch==False Then
		GUICtrlSetState($GUI_NFCBtn, $GUI_DISABLE)
	EndIf
EndFunc   ;==>ApplyAdvSettings

Func ExitAdvanced()
	GUIDelete($AdvancedMenu)
EndFunc   ;==>ExitAdvanced

Func ExitAbout()
	GUIDelete($AboutScreen)
EndFunc   ;==>ExitAdvanced

Func AddPreset()
	UpdateVars()
	Local Const $sAnswer = InputBox("Nombra tu preset", "Esta opción creará un preset para las opciones del stream." & @CRLF & @CRLF & _
			"Clickea OK para guardar o Cancelar para volver.", "Mi preset personalizado")

	If $sAnswer <> "" Then
		Local Const $sAlreadyExists = IniRead($sPresetFname, $sPresetSection, $sAnswer, "T")
		If $sAlreadyExists <> "T" Then
			Local $iMsgBoxAnswer = MsgBox(52, "Advertencia", "Ya existe un preset llamado " & $sAnswer & "." & @CRLF & @CRLF & "¿Quieres sobreescribirlo?")
			If $iMsgBoxAnswer <> 6 Then Return -1
		EndIf
		IniWrite($sPresetFname, $sPresetSection, $sAnswer, $iPriorityMode & $sSettingSeparator & $iPriorityFactor & $sSettingSeparator & $iImageQuality & $sSettingSeparator & $iQoS)
		LoadPresets()
		MsgBox(64, "¡Éxito!", "¡Preset agregado satisfactoriamente!")
	EndIf
EndFunc   ;==>AddPreset

Func DeletePreset()
	Local Const $sAnswer = InputBox("Elimina un preset", "Esta opción eliminará un preset personalizado." & @CRLF & @CRLF & _
			"Escribe el nombre del preset que quieras eliminar y clickea OK para eliminarlo o Cancelar para volver.", "Mi preset personalizado")

	If $sAnswer <> "" Then
		Local Const $sAlreadyExists = IniRead($sPresetFname, $sPresetSection, $sAnswer, "T")
		If $sAlreadyExists <> "T" Then
			IniDelete($sPresetFname, $sPresetSection, $sAnswer)
			LoadPresets()
			MsgBox(64, "¡Éxito!", "¡Preset eliminado satisfactoriamente!")
		Else
			MsgBox(48, "Advertencia", "¡El preset especificado no fue encontrado!")
		EndIf
	EndIf
EndFunc   ;==>DeletePreset

Func LoadPresets()
	Local Const $sDefaultSelection = "Balanceado"
	Local $sPresetList = "Mejor calidad|Gran calidad|Buena calidad|" & $sDefaultSelection & "|Buen rendimiento|Gran rendimiento|Mejor rendimiento|" & $sSeparator & "|Agregar preset|Eliminar preset|" & $sSeparator & $sSettingSeparator

	GUICtrlSetData($GUI_Preset, "", "") ;Clear the preset list first
	If FileExists($sPresetFname) Then
		Local Const $aReadSection = IniReadSection($sPresetFname, $sPresetSection)

		If IsArray($aReadSection) Then
			For $i = 1 To $aReadSection[0][0]
				$sPresetList &= $aReadSection[$i][0] & $sSettingSeparator
			Next
		EndIf
	EndIf
	GUICtrlSetData($GUI_Preset, $sPresetList, $sDefaultSelection)
EndFunc   ;==>LoadPresets
