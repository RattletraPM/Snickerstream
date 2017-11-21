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
#include <Misc.au3>
#include <String.au3>
#include <ScreenCapture.au3>
#include "include\ntr.au3"
#include "include\WIC.au3"
#include "include\Direct2D.au3"
#include "include\GetGitCommit.au3"

;Globbals - Streaming GUI and Drawing
Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hBMP2, $g_hGraphics, $iFPS=0, $iInterpolation=0, $sVersion="git_"&_GetGitCommit("refs/remotes/origin/master")&" ", _
$sGUITitle="Snickerstream " & $sVersion, $aWinResize, $ix1BMP1=0, $ix2BMP1=0, $ix1BMP2=0, $ix2BMP2=0, $iy1BMP1=0, $iy2BMP1=0, $iy1BMP2=0, $iy2BMP2=0, _
$iLayoutmode=0, $bNoDisplayIPWarn=0, $bD2D=True

;Globals - Main GUI
Global $sIpAddr="0.0.0.0", $iPriorityMode=0, $iPriorityFactor=5, $iImageQuality=70, $iQoS=20

;Globals - Config
Global $sFname="settings.ini", $sSectionName="Snickerstream", $aIniSections[16] = ["IpAddr", "PriorityMode", "PriorityFactor", "ImageQuality", _
"QoS", "Interpolation", "Layoutmode", "PCIpAddr", "NoDisplayIPWarn", "Loglevel", "DontCheckSettings", "UseD2D", "GDIPWarn", "NFCLastAnswer", "WaitRemoteplayInit", "Framelock"], _
$sPCIpAddr=$sIpAddr, $iLogLevel=0, $sLogFname="log.txt"

;Globals - Misc
Global $hTimer=TimerInit(), $bStreaming=False

;Globals - GUI
Global $GUI_Rendering=0, $GUI_Interpolation=0 ;Those are here to prevent a "possibly used before declaration" warning (yes, the variables are declared before being used in a separate function but SciTE doesn't recognize it)

AutoItSetOption("GUIOnEventMode", 1)	;Use OnEvent mode - a script like this would be awful without it
AutoItSetOption("TCPTimeout",5000)

Global $oError = ObjEvent("AutoIt.Error", "_ErrFunc")
Func _ErrFunc()
	LogLine("COM Error, ScriptLine(" & $oError.ScriptLine & ") : Number 0x" & Hex($oError.Number, 8) & " - " & $oError.WinDescription & @CRLF,1)
EndFunc   ;==>_ErrFunc

CreateMainGUIandSettings() ;Create the GUI
ButtonStateSet($GUI_DISABLE)
LogStart()
LogLine("WARNING: The loglevel is now set to 3. This will produce GIANT logfiles.",3)
LogLine("You should set your loglevel to something else unless you're troubleshooting some issues!",3)
LogLine("CPU: "&GetCPU(),3)
LogLine("GPU: "&GetGPU(),3)
LogLine("OS: "&@OSVersion,3)

If $__g_hD2D1DLL==-1 Then
	MsgBox($MB_ICONERROR,"Direct2D init error","There was an error while initializing Direct2D." & @CRLF & @CRLF & "This error is most likely caused by using Snickerstream on an OS"& _
	" that doesn't support Direct2D (available on Windows Vista SP2 or later). You will still be able to use this tool, but you'll have to use GDI+ as its rendering library instead (no hardware"& _
	" acceleration and slower, check the readme for more info).")
	_GUICtrlComboBox_SetCurSel($GUI_Rendering,1)
	GUICtrlSetState($GUI_Rendering,$GUI_DISABLE)
	GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	$bD2D=False
EndIf
ButtonStateSet($GUI_ENABLE)

Do
	Sleep(100)
Until $bStreaming=True

Func StreamingLoop()
	LogLine("PC IP address: "&$sPCIpAddr,2)
	LogLine("3DS IP address: "&$sIpAddr,2)
	LogLine("Priority: "&$iPriorityMode,2)
	LogLine("Priority factor: "&$iPriorityFactor,2)
	LogLine("Image quaility: "&$iImageQuality,2)
	LogLine("QoS: "&$iQoS,2)
	LogLine("Interpolation mode: "&$iInterpolation,2)
	LogLine("Screen layout: "&$iLayoutmode,2)
	LogLine("Using Direct2D: "&$bD2D,2)
	LogLine("-NOTE- The IP addresses should be internal. If you set them to public DO NOT share this log online!",2)
	UDPStartup()	;Start up the UDP protocol
	Global $iSocket = UDPBind($sPCIpAddr, "8001")	;Listen to port 8001
    Local $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	;This section has a lot of variables that need to be removed because they aren't changed. Clean this up in the next version pl0x k thx.
	Local $iGUIWidthHeight=Default, $xGUIStyle=Default, $xGUIExStyle=Default
	Global $iWidth = 400, $iHeight = 480	;Settings for Vertical (default) view mode - GUI Width & Height
	Global $ix1BMP1=0, $ix2BMP1=400, $iy1BMP1=0, $iy2BMP1=-240	;Top screen
	Global $ix1BMP2=40, $ix2BMP2=360, $iy1BMP2=-240, $iy2BMP2=-480	;Bottom screen
	Switch $iLayoutmode	;View modes
		Case 1	;Vertical (inverted)
			Global $ix1BMP1=0, $ix2BMP1=400, $iy1BMP1=-240, $iy2BMP1=-480	;Top screen
			Global $ix1BMP2=40, $ix2BMP2=360, $iy1BMP2=0, $iy2BMP2=-240	;Bottom screen
		Case 2	;Horizontal
			Global $iWidth = 720, $iHeight = 240
			Global $ix1BMP2=400, $ix2BMP2=720, $iy1BMP2=0, $iy2BMP2=-240	;Bottom screen
		Case 3	;Horizontal (inverted)
			Global $iWidth = 720, $iHeight = 240
			Global $ix1BMP1=320, $ix2BMP1=720, $iy1BMP1=0, $iy2BMP1=-240	;Top screen
			Global $ix1BMP2=0, $ix2BMP2=320, $iy1BMP2=0, $iy2BMP2=-240	;Bottom screen
		Case 4	;Top only
			Global $iWidth = 400, $iHeight = 240
			Global $ix1BMP1=0, $ix2BMP1=400, $iy1BMP1=0, $iy2BMP1=-240	;Top screen
			CheckOptimal()
		Case 5	;Bottom only
			Global $iWidth = 320, $iHeight = 240
			Global $ix1BMP2=0, $ix2BMP2=320, $iy1BMP2=0, $iy2BMP2=-240	;Bottom screen
			CheckOptimal()
		Case 6	;Fullscreen (Top)
			Local $iGUIWidthHeight=0, $xGUIStyle=$WS_POPUP, $xGUIExStyle=$WS_EX_TOPMOST
			Global $iWidth = @DesktopWidth, $iHeight = @DesktopHeight
			Global $ix1BMP1=0, $ix2BMP1=@DesktopWidth, $iy1BMP1=0, $iy2BMP1=-@DesktopHeight	;Top screen
			CheckOptimal()
	EndSwitch

	$g_hGUI = GUICreate($sSectionName&" - Connecting...", $iWidth, $iHeight,$iGUIWidthHeight,$iGUIWidthHeight,$xGUIStyle,$xGUIExStyle) ;Create the GUI
	GUISetBkColor(0, $g_hGUI)

	;In order to correctly resize the window, we need to get the difference between the graphics object width/height and the actual
	;window width/height. This difference is created by the window's borders and title bar
	$aWinResize=WinGetPos($g_hGUI)
	Global $iWidthDiff=$aWinResize[2]-$iWidth
	Global $iHeightDiff=$aWinResize[3]-$iHeight

    GUISetState(@SW_SHOW)

    ;Create buffered graphics frame set for smoother gfx object movements
	If $bD2D==True Then	;Init Direct2D
		Global $oD2D_Factory = _D2D_Factory_Create()
		Global $tMatrix_Rotate = _D2D_Matrix3x2_Rotation(-90, 0, 0)
		Global $oD2D_HwndRenderTarget = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI, $iWidth, $iHeight)
	Else	;Init GDI+
		_GDIPlus_Startup()
		$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;Create a graphics object from a window handle
		If $iLayoutmode<>6 Then
			$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGraphics)
		Else
			$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics(400, 240, $g_hGraphics)
		EndIf
		$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)
	EndIf
	CheckIfStreaming($iSocket,$sIpAddr)

	Local $iFramelock=IniRead($sFname,$sSectionName,$aIniSections[15],0)

    While $bStreaming==True
		If WinActive($g_hGUI)==$g_hGUI Then CheckKeys()	;Check the keys that are pressed to do various functions
		Local $iFrameTimer=TimerInit()
		$aJpeg=_NTRRemoteplayReadJPEG($iSocket)
		If IsArray($aJpeg) Then
			$iFPS+=1
			If $bD2D==True Then
				$oBitmap=__D2D_LoadImageFromMemory($aJpeg[1])	;Create a D2D image from the image that's stored in memory
				$oD2D_HwndRenderTarget.BeginDraw()
				$oD2D_HwndRenderTarget.SetTransform($tMatrix_Rotate)
				If $aJpeg[0]==1 And $iLayoutMode<>5 Then
					;-240 because we rotate the image of -90 degrees and we've chosen 0,0 as the transformation's origin, so the image falls "on top" of the rendering area
					;Also, Width and Height are inverted because the render target is rotated
					$oD2D_HwndRenderTarget.DrawBitmap($oBitmap, _D2D1_RECT_F($iy1BMP1, $ix1BMP1, $iy2BMP1, $ix2BMP1), 1, Int(Not $iInterpolation), Null)
				ElseIf $aJpeg[0]==0 And $iLayoutMode<>4 And $iLayoutMode<>6 Then
					$oD2D_HwndRenderTarget.DrawBitmap($oBitmap, _D2D1_RECT_F($iy1BMP2, $ix1BMP2, $iy2BMP2, $ix2BMP2), 1, Int(Not $iInterpolation), Null)
				EndIf
				$oD2D_HwndRenderTarget.EndDraw(0, 0)
			Else
				DisplayScreenGDIPlus($aJpeg[0],$aJpeg[1])
				_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;Copy drawn bitmap to graphics handle (GUI)
				_GDIPlus_GraphicsSetInterpolationMode($g_hGraphics,$iInterpolation)	;We need to set the interpolation mode each frame in case the mode gets changed
			EndIf
			;Sleep a number of seconds depending on the set framelock and time spent while rendering the frame (won't sleep if time is <0ms)
			If $iFramelock>0 Then Sleep((900/$iFramelock)-TimerDiff($iFrameTimer))	;900ms instead of 1000ms in order to compensate AutoIt's Sleep imprecisions - check the function ref
		EndIf
		If TimerDiff($hTimer)>=1000 Then
			$hTimer=TimerInit()
			WinSetTitle($g_hGUI,"",$sSectionName&" - "&$iFPS&" FPS")
			LogLine("FPS:"&$iFPS,3)
			$iFPS=0
		EndIf
	WEnd
EndFunc   ;==>Example

Func DisplayScreenGDIPlus($iScreen, ByRef $bRawJpeg)	;TODO: Ignore top/bottom screens in top only/bottom only mode!
	$g_hBMP=_GDIPlus_BitmapCreateFromMemory($bRawJpeg)	;Create a GDI+ Bitmap from the image that's stored in memory
	_GDIPlus_ImageRotateFlip($g_hBMP,3)	;The original image needs to be rotated
	If $iScreen==1 And $iLayoutmode<>5 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $ix1BMP1, $iy1BMP1*-1) ;Draw the bitmap to the backbuffer
	ElseIf $iScreen=0 And $iLayoutmode<>4 And $iLayoutmode<>6 Then
		_GDIPlus_GraphicsDrawImage($g_hGfxCtxt, $g_hBMP, $ix1BMP2, $iy1BMP2*-1) ;draw bitmap to backbuffer
	EndIf
	_GDIPlus_BitmapDispose($g_hBMP)
EndFunc

Func __D2D_LoadImageFromMemory($dData)
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

	Local $oD2D_Bitmap = _D2D_RenderTarget_CreateBitmapFromWicBitmap($oD2D_HwndRenderTarget, $oWIC_FormatConverter)

	Return $oD2D_Bitmap
EndFunc

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
	;Ehh... I guess it's a bit more polished now?
	If _CheckPressedOnce("26")==True Then
		ScaleGUI(1.2,False)
	EndIf
	If _CheckPressedOnce("28")==True And $iHeight>=200 Then
		ScaleGUI(1.2,True)
	EndIf
	If _CheckPressedOnce("25")==True Then
		If $bD2D==True Then
			$iInterpolation=Int(Not $iInterpolation)
		Else
			If $iInterpolation>0 Then $iInterpolation-=1
		EndIf
		LogLine("Interpolation mode changed to "&$iInterpolation&".",1)
	EndIf
	If _CheckPressedOnce("27")==True Then
		If $bD2D==True Then
			$iInterpolation=Int(Not $iInterpolation)
		Else
			If $iInterpolation<7 Then $iInterpolation+=1
		EndIf
		LogLine("Interpolation mode changed to "&$iInterpolation&".",1)
	EndIf
	If _CheckPressedOnce("0D")==True Then
		LogLine("Returning to the connection window.",1)
		$bStreaming=False
		UDPCloseSocket($iSocket)
		UDPShutdown()
		CheckAndShutdownGDIp()
		GUIDelete($g_hGUI)
		CreateMainGUIandSettings()
	EndIf
	If _CheckPressedOnce("53")==True Then
		_ScreenCapture_CaptureWnd("screenshot"&@MDAY&@MON&@YEAR&@HOUR&@MIN&@SEC&@MSEC&".bmp",$g_hGUI)
	EndIf
	If _IsPressed("1B") Then ExitStreaming()
EndFunc

Func ScaleGUI($iMultiplier, $bDivision)
	If $iLayoutMode<>6 Then
		If $bDivision==False Then
			$iWidth=$iWidth*$iMultiplier	;GUI
			$iHeight=$iHeight*$iMultiplier
			$ix1BMP1=$ix1BMP1*$iMultiplier	;Top screen
			$ix2BMP1=$ix2BMP1*$iMultiplier
			$iy1BMP1=$iy1BMP1*$iMultiplier
			$iy2BMP1=$iy2BMP1*$iMultiplier
			$ix1BMP2=$ix1BMP2*$iMultiplier	;Bottom screen
			$ix2BMP2=$ix2BMP2*$iMultiplier
			$iy1BMP2=$iy1BMP2*$iMultiplier
			$iy2BMP2=$iy2BMP2*$iMultiplier
		Else
			$iWidth=$iWidth/$iMultiplier	;GUI
			$iHeight=$iHeight/$iMultiplier
			$ix1BMP1=$ix1BMP1/$iMultiplier	;Top screen
			$ix2BMP1=$ix2BMP1/$iMultiplier
			$iy1BMP1=$iy1BMP1/$iMultiplier
			$iy2BMP1=$iy2BMP1/$iMultiplier
			$ix1BMP2=$ix1BMP2/$iMultiplier	;Bottom screen
			$ix2BMP2=$ix2BMP2/$iMultiplier
			$iy1BMP2=$iy1BMP2/$iMultiplier
			$iy2BMP2=$iy2BMP2/$iMultiplier
		EndIf
		$aWinResize=WinGetPos($g_hGUI)
		WinMove($g_hGUI,"",Default,Default,$iWidth+$iWidthDiff,$iHeight+$iHeightDiff)
		If $bD2D==True Then
			$oD2D_HwndRenderTarget = _D2D_Factory_CreateHwndRenderTarget($oD2D_Factory, $g_hGUI, $iWidth, $iHeight)
		Else
			_GDIPlus_GraphicsDispose($g_hGraphics)
			$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
		EndIf
		LogLine("Window size increased to "&$iWidth&"x"&$iHeight&".",1)
	EndIf
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
		$bD2D=IniRead($sFname,$sSectionName,$aIniSections[11],$bD2D)
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
	#Region ### START Koda GUI section ### Form=\gui\snickerstreamgui.kxf
	Global $SnickerstreamGUI = GUICreate($sGUITitle, 459, 202, 192, 124)
	$Label1 = GUICtrlCreateLabel("IP", 24, 26, 14, 17, $SS_CENTERIMAGE)
	$Label2 = GUICtrlCreateLabel("Screen priority", 24, 52, 71, 17, $SS_CENTERIMAGE)
	$Label3 = GUICtrlCreateLabel("Priority factor", 24, 82, 65, 17, $SS_CENTERIMAGE)
	$Label4 = GUICtrlCreateLabel("Image quality", 24, 106, 66, 17, $SS_CENTERIMAGE)
	$Label5 = GUICtrlCreateLabel("QoS Value", 24, 130, 55, 17, $SS_CENTERIMAGE)
	Global $GUI_IpAddr = _GUICtrlIpAddress_Create($SnickerstreamGUI, 104, 24, 105, 17)
	_GUICtrlIpAddress_Set($GUI_IpAddr, "0.0.0.0")
	Global $GUI_PriorityMode = GUICtrlCreateCombo("", 104, 50, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Top screen|Bottom screen", "Top screen")
	Global $GUI_PriorityFactor = GUICtrlCreateInput("5", 104, 80, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_ImageQuality = GUICtrlCreateInput("90", 104, 104, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	Global $GUI_QoS = GUICtrlCreateInput("20", 104, 128, 105, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
	$Label6 = GUICtrlCreateLabel("Interpolation", 245, 56, 62, 17, $SS_CENTERIMAGE)
	Global $GUI_Interpolation = GUICtrlCreateCombo("", 321, 54, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Linear|Nearest neighbor", "Linear")
	$Label7 = GUICtrlCreateLabel("Screen layout", 245, 80, 69, 17, $SS_CENTERIMAGE)
	Global $GUI_Layoutmode = GUICtrlCreateCombo("", 321, 80, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Vertical|Vertical(inverted)|Horizontal|Horizontal(inverted)|Top screen only|Bottom screen only|Fullscreen(Top)", "Vertical")
	Global $GUI_ConnectBtn = GUICtrlCreateButton("Connect!", 232, 160, 217, 33)
	Global $GUI_NFCBtn = GUICtrlCreateButton("Send NFC patch", 344, 128, 105, 25)
	$Group1 = GUICtrlCreateGroup("Remoteplay settings", 8, 8, 217, 185)
	Global $GUI_Preset = GUICtrlCreateCombo("", 103, 160, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Best quality|Great quality|Good quality|Balanced|Good framerate|Great framerate|Best framerate", "Balanced")
	GUICtrlSetOnEvent(-1, "GUI_PresetChange")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Group2 = GUICtrlCreateGroup("Display settings", 232, 8, 217, 105)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	Global $GUI_AboutBtn = GUICtrlCreateButton("About", 232, 128, 105, 25)
	$Label8 = GUICtrlCreateLabel("Rendering", 245, 32, 53, 17, $SS_CENTERIMAGE)
	Global $GUI_Rendering = GUICtrlCreateCombo("", 322, 27, 113, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Direct2D (hw/sw)|GDI+ (sw)", "Direct2D (hw/sw)")
	GUICtrlSetOnEvent(-1, "GUI_RenderingChange")
	$Label9 = GUICtrlCreateLabel("Preset", 25, 162, 34, 17, $SS_CENTERIMAGE)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###

	;Set the limit for the inputs
	GUICtrlSetLimit($GUI_PriorityFactor,3)
	GUICtrlSetLimit($GUI_ImageQuality,3)
	GUICtrlSetLimit($GUI_QoS,3)

	;This is needed in case the config file was loaded so it'll be shown correctly
	_GUICtrlIpAddress_Set($GUI_IpAddr, $sIpAddr)
	_GUICtrlComboBox_SetCurSel($GUI_PriorityMode,$iPriorityMode)
	GUICtrlSetData($GUI_PriorityFactor,$iPriorityFactor)
	GUICtrlSetData($GUI_ImageQuality,$iImageQuality)
	GUICtrlSetData($GUI_QoS,$iQoS)
	If $bD2D==True And $iInterpolation>1 Then	;Failsafe in case we get an invalid interpolation mode for D2D
		$iInterpolation=0
	EndIf
	If $bD2D==True Then
		_GUICtrlComboBox_SetCurSel($GUI_Rendering,0)
	Else
		_GUICtrlComboBox_SetCurSel($GUI_Rendering,1)
		GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation,$iInterpolation)
	_GUICtrlComboBox_SetCurSel($GUI_Layoutmode,$iLayoutMode)

	GUISetOnEvent($GUI_EVENT_CLOSE, "ExitMain")
	GUICtrlSetOnEvent($GUI_AboutBtn , "AboutMsg")
	GUICtrlSetOnEvent($GUI_NFCBtn, "SendNFC")
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
	IniWrite($sFname,$sSectionName,$aIniSections[11],$bD2D)
	If IniRead($sFname,$sSectionName,$aIniSections[14],-1)<0 Then IniWrite($sFname,$sSectionName,$aIniSections[14],1000)
EndFunc

Func SendNFC()
	ButtonStateSet($GUI_DISABLE)
	If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer=IniRead($sFname,$sSectionName,$aIniSections[13],-1)
	If $iMsgBoxAnswer==-1 Then $iMsgBoxAnswer = MsgBox(67,"Choose 3DS firmware version","Yes -> Firmware >= 11.4"&@CRLF&"No -> Firmware <= 11.3"&@CRLF& _
	"Cancel -> Go back"&@CRLF&@CRLF&"Snickerstream will remember your answer so you won't see this message again.")
	Select
		Case $iMsgBoxAnswer = 6 ;Yes
			Local $iRet=_NTRSendNFCPatch($sIpAddr,"005b10")	;Offset must be in little-endian
			IniWrite($sFname,$sSectionName,$aIniSections[13],6)
			LogLine("Sending NFC Patch (>=11.4).",1)
		Case $iMsgBoxAnswer = 7 ;No
			Local $iRet=_NTRSendNFCPatch($sIpAddr,"e45a10")	;Same as above
			IniWrite($sFname,$sSectionName,$aIniSections[13],7)
			LogLine("Sending NFC Patch (<=11.3).",1)
	EndSelect
	If $iMsgBoxAnswer>=6 Then
		If $iRet = -1 Then
			LogLine("NFC patch failed, could not connect.",1)
			MsgBox($MB_ICONERROR, "Connection error", "Could not connect to the (N)3DS.")
		Else
			LogLine("NFC patch sent succesfully.",1)
			MsgBox($MB_ICONINFORMATION,"Success!","NFC patch sent succesfully!")
		EndIf
	EndIf
	ButtonStateSet($GUI_ENABLE)
EndFunc

Func StartStream()
	UpdateVars()
	WriteConfig()
	GUIDelete($SnickerstreamGUI)
	$bStreaming=True
	StreamingLoop()
EndFunc

Func ButtonStateSet($GUIState)
	GUICtrlSetState($GUI_AboutBtn, $GUIState)
	GUICtrlSetState($GUI_NFCBtn, $GUIState)
	GUICtrlSetState($GUI_ConnectBtn, $GUIState)
EndFunc

Func AboutMsg()
	ButtonStateSet($GUI_DISABLE)
	MsgBox($MB_ICONINFORMATION,"About Snickerstream",$sGUITitle&"by RattletraPM"&@CRLF&@CRLF&"This software and its source code are provided free of charge under the GPL-3.0"& _
	" License. See License.txt for the full license."&@CRLF&@CRLF&"Direct2D and WIC UDF made by trancexx & Eukalyptus.")
	ButtonStateSet($GUI_ENABLE)
EndFunc

Func ExitMain()
	GUIDelete($SnickerstreamGUI)
	If IsDeclared("oD2D_HwndRenderTarget")<>0 Then
		ExitStreaming()
	EndIf
	LogLine("Quitting.",1)
	Exit
EndFunc

Func CheckAndShutdownGDIp()
	If $bD2D==False Then
		_GDIPlus_GraphicsDispose($g_hGfxCtxt)
		_GDIPlus_GraphicsDispose($g_hGraphics)
		_GDIPlus_BitmapDispose($g_hBitmap)
		_GDIPlus_BitmapDispose($g_hBMP)
		_GDIPlus_BitmapDispose($g_hBMP2)
		_GDIPlus_Shutdown()
	EndIf
EndFunc

Func ExitStreaming()
	Global $bStreaming=False
	LogLine("Quitting.",1)
	;Close the UDP socket
	UDPCloseSocket($iSocket)
	UDPShutdown()
	CheckAndShutdownGDIp()
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
				FileWriteLine($hFile,"it hac, it bric, but most importantly, it S N I C C")
			Case 1
				FileWriteLine($hFile,"*whispers* AL9H.")
			Case 2
				FileWriteLine($hFile,"You must have graduated from elementary school to use this tool.")
			Case 3
				FileWriteLine($hFile,"One more way to get copyright striked by Nintendo.")
			Case 4
				FileWriteLine($hFile,"What are you waiting for, Nintendo to make one?")
			Case 5
				FileWriteLine($hFile,"Here's your christmas present! <3")
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

Func GetCPU()
	$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_Processor", "WQL", 0x10 + 0x20)
	If IsObj($colItems) then
	   For $objItem In $colItems
			$Output = $objItem.Name&"@"&$objItem.MaxClockSpeed&"MHz"
	   Next
	Endif

	Return $Output
EndFunc

Func GetGPU()
	$objWMIService = ObjGet("winmgmts:\\.\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_DisplayConfiguration", "WQL", 0x10 + 0x20)
	If IsObj($colItems) then
	   For $objItem In $colItems
			$Output = $objItem.DeviceName
	   Next
	Endif

	Return $Output
EndFunc

Func CheckIfStreaming($iUDPSocket,$sRemoteIP)
	Local $hTimerTimeout=TimerInit()
	Local $bRecieved=False
	Local $bChecked=False
	While $bRecieved==False
		$dRecv=UDPRecv($iUDPSocket,2000,1)
		If TimerDiff($hTimerTimeout)>=IniRead($sFname,$sSectionName,$aIniSections[14],1000) And $bChecked==False Then
			WinSetTitle($g_hGUI,"",$sSectionName&" - Starting remoteplay...")
			LogLine("Starting remoteplay on 3DS.",1)
			$iRet = _NTRInitRemoteplay($sRemoteIP, $iPriorityMode, $iPriorityFactor, $iImageQuality, $iQoS)
			If $iRet = -1 Then
				LogLine("Remoteplay init failed, could not connect.",1)
				MsgBox($MB_ICONERROR, "Connection error", "Could not start remoteplay on the (N)3DS.")
				$bStreaming=False
				$bRecieved=True	;This needs to be set to true or the script will resume from this function after creating the main GUI, making the program non responsive
				UDPCloseSocket($iSocket)
				UDPShutdown()
				CheckAndShutdownGDIp()
				GUIDelete($g_hGUI)
				CreateMainGUIandSettings()
			EndIf
			$bChecked=True
		EndIf
		If $dRecv<>"" Then
			$bRecieved=True
			LogLine("Recieving stream.",1)
		EndIf
	WEnd
EndFunc

Func GUI_PresetChange()
	SetPreset(_GUICtrlComboBox_GetCurSel($GUI_Preset))
EndFunc

Func SetPreset($iPresetNum)
	Switch $iPresetNum
		Case 0	;Best quality
			GUICtrlSetData($GUI_PriorityFactor,2)
			GUICtrlSetData($GUI_ImageQuality,90)
			GUICtrlSetData($GUI_QoS,10)
		Case 1
			GUICtrlSetData($GUI_PriorityFactor,5)
			GUICtrlSetData($GUI_ImageQuality,80)
			GUICtrlSetData($GUI_QoS,18)
		Case 2
			GUICtrlSetData($GUI_PriorityFactor,5)
			GUICtrlSetData($GUI_ImageQuality,75)
			GUICtrlSetData($GUI_QoS,18)
		Case 3
			GUICtrlSetData($GUI_PriorityFactor,5)
			GUICtrlSetData($GUI_ImageQuality,70)
			GUICtrlSetData($GUI_QoS,20)
		Case 4
			GUICtrlSetData($GUI_PriorityFactor,8)
			GUICtrlSetData($GUI_ImageQuality,60)
			GUICtrlSetData($GUI_QoS,26)
		Case 5
			GUICtrlSetData($GUI_PriorityFactor,8)
			GUICtrlSetData($GUI_ImageQuality,50)
			GUICtrlSetData($GUI_QoS,26)
		Case 6	;Best performance
			GUICtrlSetData($GUI_PriorityFactor,10)
			GUICtrlSetData($GUI_ImageQuality,40)
			GUICtrlSetData($GUI_QoS,34)
	EndSwitch
EndFunc

Func GUI_RenderingChange()
	If _GUICtrlComboBox_GetCurSel($GUI_Rendering)==0 Then
		$bD2D=True
		GUICtrlSetData($GUI_Interpolation, "|Linear|Nearest neighbor", "Linear")
	Else
		If IniRead($sFname,$sSectionName,$aIniSections[12],1)==1 Then
			MsgBox(48,"Warning!","GDI+ is NOT hardware accelerated. This means that you might get poor performance, stuttering and tearing on your computer while streaming."&@CRLF&@CRLF& _
			"Unless you REALLY know what you're doing, you should use Direct2D instead."&@CRLF&@CRLF&"Click OK to continue (this warning will not appear again).")
			IniWrite($sFname,$sSectionName,$aIniSections[12],0)
		EndIf
		$bD2D=False
		GUICtrlSetData($GUI_Interpolation, "|Default|Low quality|High quality|Bilinear|Bicubic|Nearest-neighbor|Bilinear (HQ)|Bicubic (HQ)", "Default")
	EndIf
	_GUICtrlComboBox_SetCurSel($GUI_Interpolation,0)
EndFunc
