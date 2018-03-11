#include-once

; #INDEX# =======================================================================================================================
; Title .........: 	NTR UDF for AutoIT v3 (UDF Version 0.7b)
; AutoIt Version : 	3.3.14.2
; Description ...: 	This UDF has been discontinued. Read more: https://github.com/RattletraPM/Snickerstream/tree/master/include
;
;					Snickerstream and all of its components are released under the GPLv2 License:
;					https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
; Author(s) .....: 	RattletraPM
; Dll ...........: 	None
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_NTRInitRemoteplay
;_NTRRemoteplayReadJPEG
;_NTRRemoteplayReadPacketHeader
;_NTRSendNFCPatch
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: 	_NTRInitRemoteplay
; Description ...: 	Connects to a (New) 3DS running NTR CFW and sends the remoteplay() command.
; Syntax.........: 	_NTRInitRemoteplay(sIp ,[$bPriorityMode = 0 [, $iPriorityFactor = 5 [, $iQuality = 90 [, $iQosValue = 20]]]])
; Parameters ....: 	$sIp   				- String containing the IP to the target (New) 3DS system
;					$bPriorityMode 		- (Default: 1) Sets the priority to either the top or bottom screen (1 = Top, 0 = Bottom)
;					$iPriorityFactor 	- (Default: 5) Sets the priority factor of the screen specified in $bPriorityMode
;					$iQuality			- (Default: 90) Sets the JPEG compression quality, range from 1 to 100.
;					$iQosValue			- (Default: 20) Sets the QoS value. If set to over 100, then the QoS feature is disabled.
; Return values .: 	Success     		- 1
;                  	Failure     		- Returns -1
; Author ........: 	RattletraPM
; Modified.......:	10/11/2017
; Remarks .......: 	You MUSTN'T specify the connection port, as NTR always expects a connection on port 8000.
;					It's highly recommended to set TCPTimeout to a value higher than default (Snickerstream uses 5000).
; Related .......: 	_NTRSendNFCPatch, TCPTimeout (Option)
; Link ..........:
; Example .......: 	See Snickerstream's source code
; ===============================================================================================================================
Func _NTRInitRemoteplay($sIp, $bPriorityMode = 1, $iPriorityFactor = 5, $iQuality = 90, $iQosValue = 20)
	If ($bPriorityMode>1 Or $bPriorityMode<0 Or IsInt($iPriorityFactor)=0 Or IsInt($iQuality)=0 Or IsInt($iQosValue)=0 ) Or $iPriorityFactor>255 Or $iQuality>100 Then
		SetError(-1001)
		Return -1
	EndIf

	;If this value is higher than 100 then NTR simply disables the QoS feature, so we just set it to an arbitrary value higher
	;than 100.
	If $iQosValue>100 Then $iQosValue=105

	;This is the TCP package that needs to be sent to the N3DS. Under other cirumstances we'd want to change other bytes but to
	;initialize remoteplay we only need to care about bytes 0x10, 0x11, 0x14 and 0x1A.
	;
	;Bytes 0x10 and 0x14 contain, respectively, the priority factor and JPEG quality variables. All we need to do is to convert
	;them from DEC to HEX et voilà, they work.
	;
	;Byte 0x11 is the priority mode byte. This is a weird one: internally, 1 is for top screen and 0 is for bottom screen. If
	;you've used NTRClient, howerer, you've probably noticed that the boolean is actually FLIPPED, so 0 is top screen and
	;1 is bottom screen. I don't know why cell9 thought this was a good idea so, as we're sending a RAW package here, I've
	;decided to NOT flip the boolean. This way, there won't be any confusion regarding what this value actually means, and
	;1 will always mean top screen and 0 bottom screen in this UDF and Snickerstream's source code.
	;
	;Finally, byte 0x1A contains the QoS value. I have no idea why, but NTR expects it to be double its intended value.
	Local Const $dBinaryPacket = Binary("0x78563412B80B00000000000085030000"&Hex($iPriorityFactor,2)&Hex($bPriorityMode,2)&"0000"&Hex($iQuality,2)&"0000000000"&Hex($iQosValue*2,2)&StringFormat("%0114d",0))
	Local Const $sPort = 8000

	TCPStartup()
	Local $iSocket = TCPConnect($sIp, $sPort)	;Connect to the (N)3DS with the given IP
	If @error Then
		LogLine("TCPConnect error, @error="&@error&".",3)
		Return -1
    Else
		TCPSend($iSocket, $dBinaryPacket)		;Send the packet
		If @error Then
			LogLine("TCPSend error, @error="&@error&".",3)
			Return -1
		EndIf
	EndIf
	TCPCloseSocket($iSocket)					;NTR expect us to disconnect
	Sleep(3000)									;Give NTR enough time to start remoteplay
	$iSocket = TCPConnect($sIp, $sPort)			;NTR expects us to reconnect before it starts streaming frames
	If @error Then
		LogLine("TCPConnect error while reconnecting, @error="&@error&".",3)
		Return -1
	EndIf
	TCPCloseSocket($iSocket)					;We'll disconnect right after reconnecting to save bandwidth
	TCPShutdown()
	Return 1
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: 	_NTRRemoteplayReadJPEG
; Description ...: 	Reads a JPEG file sent by NTR.
; Syntax.........: 	_NTRRemoteplayReadJPEG($sIp)
; Parameters ....: 	$iSocket			- 	Variable returned by UDPBind()
;					$iScreen			-	Only return frames shown by this screen
; Return values .: 	Success     		- 	Binary JPEG variable
;                  	Failure     		- 	Returns -1, sets @error to non-zero if an UDP error occurred
;					@error				- 	Windows API WSAStartup return value (see MSDN).
; Author ........: 	RattletraPM
; Modified.......:	10/11/2017
; Remarks .......: 	This function doesn't handle any UDP-related functions (except for UDPRecv, of course) to optimize performace.
;					This means that you have to call UDPStartup(), UDPShutdown() and, obivously, UDPBind() by yourself!
;					When calling UDPBind(), remember that the IP address to bind is probably @IPAddress1 and that NTR always
;					streams its JPEG files on port 8001.
;					The function is meant to be in a loop that constantly checks if the recieved image is valid.
; Related .......: 	_NTRInitRemoteplay, UDPStartup(), UDPShutdown(), UDPBind()
; Link ..........:
; Example .......: 	See Snickerstream's source code
; ===============================================================================================================================
Func _NTRRemoteplayReadJPEG($iSocket)
	Local $sFullJPEGBuf, $dRecv, $iCurId, $iCurScreen, $iExpectedPacket=0

	Local $aRetArr[2]
	$dRecv=UDPRecv($iSocket,1448,1)
	If @error Then
		LogLine("UDPRecv error, @error="&@error&".",3)
        Return -1
    Else
		$aHeader=_NTRRemoteplayReadPacketHeader(BinaryMid($dRecv,1,4))	;First, we need to read the packet's header
		;We return an error if the previous function failed, if the packet number is NOT zero, or if the packet's screen ID is different than $iScreen
		If IsArray($aHeader)==0 Or $aHeader[2]<>0 Then
			LogLine("Invalid or incomplete packet recieved, skipping. This is OK if you've just started Snickerstream.",2)
			Return -1
		EndIf
		$iCurId=$aHeader[0]
		$iCurScreen=$aHeader[1]
		Do	;Now we try to read and assemble the entire JPEG image! (As you might've guessed, it's split in multiple packets)
			;AutoIt doesn't support binary concatenation, we need to convert the packet to an HEX string (and we also need to remove the HEX notation aswell!)
			$sFullJPEGBuf&=StringTrimLeft($dRecv,10)
			If StringLeft(Hex($aHeader[1],2),1)==1 Then ExitLoop
			$iExpectedPacket+=1
			$dRecv=UDPRecv($iSocket,2000,1)
			$aHeader=_NTRRemoteplayReadPacketHeader($dRecv)
			;If $aHeader has returned an error, the packet's screen byte has changed or there is a mismatch between the expected
			;packet number and the actual packet number, it means that we've dropped some packets and we cannot assemble a valid
			;image. Return an error.
			If IsArray($aHeader)==0 Or $iExpectedPacket<>$aHeader[2] Or $iCurScreen<>StringRight(Hex($aHeader[1],2),1) Then
				LogLine("Some packets have been dropped! Skipping current frame. (Check your connection!)",2)
				Return -1
			EndIf
		Until $aHeader[0]<>$iCurId
	EndIf

	If StringRight($sFullJPEGBuf,4)<>"FFD9" Then ;If the JPEG doesn't end with the HEX bytes FFD9 it means that's incomplete
		LogLine("Current frame is not a valid JPEG image, skipping. (You might be dropping packets, check your connection!)",2)
		Return -1
	EndIf

	$aRetArr[0]=StringRight(Hex($aHeader[1],2),1)
	$aRetArr[1]=Binary("0x"&$sFullJPEGBuf)

	Return $aRetArr	;...And now we convert the newly assembled image back to binary. Success!
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: 	_NTRRemoteplayReadPacketHeader
; Description ...: 	Reads the header of a packet sent by NTR.
; Syntax.........: 	_NTRRemoteplayReadJPEG($dPacket)
; Parameters ....: 	$dPacket			- Binary packet whose header needs to be read
; Return values .: 	Success     		- An array containing 3 elements (Frame ID, IsTop, Packet Number)
;                  	Failure     		- Returns 0 and sets @error to non-zero
;					@error				- 1 $dPacket is not a binary type variable
;										- 2 Invalid packet ($dPacket contains less than 4 bytes)
; Author ........: 	RattletraPM
; Modified.......:	10/11/2017
; Remarks .......: 	$dPacket can either be an entire packet or the first four bytes (aka the header) of a packet.
; Related .......: 	_NTRRemoteplayReadJPEG
; Link ..........:
; Example .......: 	See Snickerstream's source code
; ===============================================================================================================================
Func _NTRRemoteplayReadPacketHeader($dPacket)
	Local $aRet[4]

	If IsBinary($dPacket)==0 Then	;If $dPacket isn't a binary type variable, abort
		SetError(1)
		Return 0
	EndIf
	If BinaryLen($dPacket)<4 Then	;If $dPacket contains less than four bytes, abort (a NTR package needs to have at least 4 bytes)
		SetError(2)
		Return 0
	EndIf

	;If you look closely at the next piece of code, you'll notice that we read every byte in the header except the 3rd one. In order
	;to understand why, you should consider the following:
	;A remoteplay packet sent by NTR looks like this
	;
	;== HEADER ==
	;0x00: Frame ID
	;0x01: First Nibble:if set to 1, it means that the packet is the last one in a JPEG stream.Second Nibble:Screen, 1=Top/0=Bottom
	;0x02: Image format, usually this is set to 2
	;0x03: Packet number in JPEG stream
	;
	;== BODY ==
	;0x04 to 0x0n: JPEG data
	;
	;Now, it would make sense to send information about the format that's being used to the viewer application, but we really don't
	;care if we use AutoIt - and that's because every format used by NTR should be supported by GDI+ out of the box. So, it's
	;better to just skip that byte instead of reading something that's never going to be used, right? ¯\_(ツ)_/¯
	For $i=0 To 2
		$aRet[$i] = Int(BinaryMid($dPacket,2^$i,1))
	Next

	LogLine("Packet recieved: frameID:"&$aRet[0]&",isTop:"&$aRet[1]&",packetNum:"&$aRet[2],3)

	Return $aRet
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: 	_NTRSendNFCPatch
; Author ........: 	RattletraPM
; ===============================================================================================================================
Func _NTRSendNFCPatch($sIp,$sAddr)

	Local Const $dBinaryPacket1 = Binary("0x78563412c05d0000010000000a0000001a000000"&$sAddr&"00020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000")
	Local Const $dBinaryPacket2 = Binary("0x7047")
	Local Const $sPort = 8000

	TCPStartup()
	Local $iSocket = TCPConnect($sIp, $sPort)	;Connect to the (N)3DS with the given IP
	If @error Then
		LogLine("TCPConnect error, @error="&@error&".",3)
		Return -1
    Else
		TCPSend($iSocket, $dBinaryPacket1)		;Send the package
		If @error Then
			LogLine("TCPSend error, @error="&@error&".",3)
			Return -1
		EndIf
		TCPSend($iSocket, $dBinaryPacket2)		;Send the package
		If @error Then
			LogLine("TCPSend error, @error="&@error&".",3)
			Return -1
		EndIf
	EndIf
	TCPCloseSocket($iSocket)					;NTR expect us to disconnect
	TCPShutdown()
	Return 1
EndFunc
