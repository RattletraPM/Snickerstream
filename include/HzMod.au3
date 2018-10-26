#include <FileConstants.au3>
#include-once

; #INDEX# =======================================================================================================================
; Title .........: 	HzMod UDF for AutoIT v3 (UDF Version 0.3b)
; AutoIt Version : 	3.7.3
; Description ...: 	This UDF is meant to be used by Snickerstream. It might need editing in order to be used by other scripts.
;
;					Snickerstream and all of its components are released under the GPLv2 License:
;					https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
; Author(s) .....: 	RattletraPM
; Dll ...........: 	None
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_HzModInit
; ===============================================================================================================================

Global $bStreaming=False	;It's here to prevent an "undeclared variable" warning, sometimes SciTE derps out with this stuff when global variables are declared in another file

Global Const $tagD2D1_MATRIX_5X4_F = "struct; float M1[4]; float M2[4]; float M3[4]; float M4[4]; float M5[4]; endstruct;"

Func _D2D1_MATRIX_5X4_F($fM11 = 1, $fM12 = 0, $fM13 = 0, $fM14 = 0, $fM21 = 0, $fM22 = 1, $fM23 = 0, $fM24 = 0, $fM31 = 0, $fM32 = 0, $fM33 = 1, $fM34 = 0, $fM41 = 0, $fM42 = 0, $fM43 = 0, $fM44 = 1, $fM51 = 0, $fM52 = 0, $fM53 = 0, $fM54 = 1)
	Local $tStruct = DllStructCreate($tagD2D1_MATRIX_5X4_F)
	$tStruct.M1(1) = $fM11
	$tStruct.M1(2) = $fM12
	$tStruct.M1(3) = $fM13
	$tStruct.M1(4) = $fM14

	$tStruct.M2(1) = $fM21
	$tStruct.M2(2) = $fM22
	$tStruct.M2(3) = $fM23
	$tStruct.M2(4) = $fM24

	$tStruct.M3(1) = $fM31
	$tStruct.M3(2) = $fM32
	$tStruct.M3(3) = $fM33
	$tStruct.M3(4) = $fM34

	$tStruct.M4(1) = $fM41
	$tStruct.M4(2) = $fM42
	$tStruct.M4(3) = $fM43
	$tStruct.M4(4) = $fM44

	$tStruct.M5(1) = $fM51
	$tStruct.M5(2) = $fM52
	$tStruct.M5(3) = $fM53
	$tStruct.M5(4) = $fM54

	Return $tStruct
EndFunc   ;==>_D2D1_MATRIX_5X4_F

Global $structSwapRBMatrix = _D2D1_MATRIX_5X4_F(0, 0, 1, 0,   0, 1, 0, 0,   1, 0, 0, 0,   0, 0, 0, 1,   0, 0, 0, 0)

Func _HzModChangeQuality($iSocket, $iQuality)
	If $iQuality < 1 Then $iQuality = 1
	If $iQuality > 100 Then $iQuality = 100
	Local Const $dQualityPacket = Binary("0x7E05000003000000")+BinaryMid(Binary($iQuality),1,1)

	TCPSend($iSocket, $dQualityPacket)	;Send JPEG Quality
	LogLine("Setting quality to "&$iQuality, 2)
	LogLine("TCPSend "&$dQualityPacket, 3)
EndFunc

Func _HzModInit($iSocket, $iQuality, $iCPULimit)
	If $iCPULimit>255 Then $iCPULimit = 255
	Local Const $dStreamStartPacket = Binary("0x7E0500000000000001"), $dLimitCPUPacket = Binary("0x7E050000FF000000")+BinaryMid(Binary($iCPULimit),1,1)
	Local $dTempRcv = ""

	LogLine("Initializing HzMod", 1)
	If $iCPULimit>0 Then
		TCPSend($iSocket, $dLimitCPUPacket)
		LogLine("Setting CPU cycle cap to "&$iCPULimit, 2)
		LogLine("TCPSend "&$dLimitCPUPacket, 2)
	EndIf
	_HzModChangeQuality($iSocket, $iQuality)
	TCPSend($iSocket, $dStreamStartPacket)	;Start streaming
	LogLine("TCPSend "&$dStreamStartPacket, 2)
	Do
		$dTempRcv = TCPRecv($iSocket,50,1)
	Until $dTempRcv<>""
	LogLine("Receiving stream.", 1)
EndFunc

Func __HzLoadImageSizeLE($dBin)
	Local $dBinSize=BinaryMid($dBin, 4, 1)+BinaryMid($dBin, 3, 1)+BinaryMid($dBin, 2, 1)

	Return Dec(Hex($dBinSize))	;Yup, that's what I have to do to read a little endian data type and convert it to big endian (dec)...
EndFunc

Func _HzModReadImage($iSocket, $dReadahead = -1)
	Local Const $iMaxBytes = 1360, $sJpegPacket = "0x04", $sTargaPacket = "0x03"
	Local $aRetArr[3], $iIndex = 1, $iImageSize, $iNumBytesRead
	$aRetArr[0] = 1	;Set the screen to top - bottom screen streaming not supported yet
	If $dReadahead == -1 Then
		Local $dRecv = TCPRecv($iSocket,$iMaxBytes,1)
	Else
		Local $dRecv = $dReadahead
	EndIf
	If BinaryLen($dRecv) == 0 Then Return -1
	Do
		Local $dType = BinaryMid($dRecv, 1, 1)
		If $dType == "0x02" Or $dType == "0xFF" Then
			LogLine("Ignoring packet with ID "&$dType, 2)
			$iIndex = Dec(Hex(BinaryMid($dRecv,2,1)))+5	;Ignore the mode packet
			$dType = BinaryMid($dRecv, $iIndex, 1)
			$dRecv = BinaryMid($dRecv, $iIndex)
			If BinaryLen($dRecv)==0 Then Return -1	;0 byte debug packets do exist! (as well as other "oddities" which get taken here)
		EndIf
	Until $dType == $sJpegPacket Or $dType == $sTargaPacket
	$iImageSize = __HzLoadImageSizeLE($dRecv)
	$aRetArr[1] = BinaryMid($dRecv,13)	;Put the part of the image found in the debug packet inside the array
	$iNumBytesRead += BinaryLen($aRetArr[1])
	$dRecv = TCPRecv($iSocket,$iMaxBytes,1)
	LogLine("$dRecv: "&$dRecv, 3)
	Switch $dType
		Case $sJpegPacket
			While $iNumBytesRead<$iImageSize
				$iNumBytesRead += BinaryLen($dRecv)
				$aRetArr[1] += $dRecv
				$dRecv = TCPRecv($iSocket,$iMaxBytes,1)
				If $bStreaming == False Then Return -1
				LogLine("$dRecv: "&$dRecv, 3)
			WEnd
			$aRetArr[2] = BinaryMid($aRetArr[1],$iImageSize-7) + $dRecv

		Case $sTargaPacket
			LogLine("TARGA Image detected", 1)
			MsgBox(16,"Oops!","Snickerstream currently does not support TARGA streams. Choose another game and reconnect.")
			Exit 1
		Case Else
			LogLine("Unknown packet received with ID "&$dType, 1)
	EndSwitch
	If BinaryLen($aRetArr[2]) == 0 Then $aRetArr[2] = -1
	If BinaryMid($aRetArr[1],1,2) <> "0xFFD8" Or BinaryMid($aRetArr[1],$iImageSize-9,2) <> "0xFFD9" Then Return -1	;Sanity check

	Return $aRetArr
EndFunc

Func _HzModSendNFCPatch($sIp, $sAddr)
	Local $iMsgBoxAnswer = MsgBox(68,"3DS model?","Click Yes if you're using a New 2/3DS, otherwise click No."), $iSocket = TCPConnect($sIp,6464)
	Select
		Case $iMsgBoxAnswer = 6 ;n3DS
			Local $dBinaryPacketPatch = Binary("0x810A00001A000000"&$sAddr&"007047")
		Case $iMsgBoxAnswer = 7 ;o3DS
			Local $dBinaryPacketPatch = Binary("0x810A000019000000"&$sAddr&"007047")
	EndSelect

	If @error Then
		LogLine("TCPConnect error, @error="&@error&".",3)
		Return -1
    Else
		LogLine("Sending NFC patch", 1)
		TCPSend($iSocket, $dBinaryPacketPatch)
		If @error Then
			LogLine("TCPSend error, @error="&@error&".",3)
			Return -1
		EndIf
	EndIf
	TCPCloseSocket($iSocket)
	TCPShutdown()
	Return 0
EndFunc