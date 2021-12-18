; ============================================================================================================================
; File		: SemVer.au3 (2021.12.16)
; Version	: 1.0.0
; Purpose	: Tools for handling semantic version numbers
; Author	: Aaron Salyer <aaron_salyer@yahoo.com>
; Website	: http://sctscomputing.com/
; ============================================================================================================================

; ============================================================================================================================
; Public Functions:
;   SemVer_Compare($sCurrentVersion, $sTargetVersion, $bStrictComparison = false)
; ============================================================================================================================


;===============================================================================
;
; Function Name:    SemVerCompare()
; Description:      Compares 2 semantic version number strings.
; Parameter(s):     $sCurrentVersion - The current version number as a string
;									   Format should be w.x.y.z
;					$sTargetVersion - The target version number as a string
;									  Format should be w.x.y.z
;					$bStrictComparison - When set to True, the function will
;										 will evaluate all parts of the version
;										 number. By default, only the first 3
;										 levels are compared.
; Requirement(s):   None
; Return Value(s):  1 	= Target is higher than Current
;					-1 	= Target is lower than Current
;					0 	= Target is the same as Current
;					>1 	= An error occurred during testing.  Check console logs for specifics
; Author(s):        Aaron Salyer <aaron_salyer@yahoo.com>
;
;===============================================================================


Func SemVerCompare($sCurrentVersion, $sTargetVersion, $bStrictComparison = false)

	; Validate Parameters

	if IsString($sCurrentVersion) == False Then
		;TODO: Implement proper error handling
		ConsoleWrite("Parameter $sCurrentVersion must be a string using semantic version numbering where every version part is separated by a period." & @CRLF)
		Return 2
	EndIf

	if IsString($sTargetVersion)== False Then
		;TODO: Implement proper error handling
		ConsoleWrite("Parameter $sTargetVersion must be a string using semantic version numbering where every version part is separated by a period." & @CRLF)
		Return 3
	EndIf

	if IsBool($bStrictComparison) == False Then
		;TODO: Implement proper error handling
		ConsoleWrite("Parameter $bStrictComparison must be a boolean value." & @CRLF)
		Return 4
	EndIf



	; Break string versions in to comparable portions
	; Properly passed string values will become arrays.

	Local $aCurrent = StringSplit($sCurrentVersion, ".")
	Local $aTarget = StringSplit($sTargetVersion, ".")

	; Check to make sure both version strings converted to arrays
	if IsArray($aCurrent) == False Then
		;TODO: Implement proper error handling
		ConsoleWrite("Current version number of " & $sCurrentVersion & " does not appear to be formated correctly." & @CRLF)
		Return 5
	EndIf

	if IsArray($aTarget) == False Then
		;TODO: Implement proper error handling
		ConsoleWrite("Target version number of " & $sTargetVersion & " does not appear to be formated correctly." & @CRLF)
		Return 6
	EndIf


	; Set missing parts to 0
	Local $iOriginalCurrentMax = $aCurrent[0]
	Local $iOriginalTargetMax = $aTarget[0]
	If $iOriginalTargetMax > $iOriginalCurrentMax Then
		Local $iMissingParts = $aTarget[0] - $aCurrent[0]
		PadArray($aCurrent, $iMissingParts)
	EndIf
	If $iOriginalTargetMax < $iOriginalCurrentMax Then
		Local $iMissingParts = $iOriginalCurrentMax - $iOriginalTargetMax
		PadArray($aTarget, $iMissingParts)
	EndIf

	; Start version comparison
	For $i = 1 To UBound($aTarget)
		if $aTarget[$i] > $aCurrent[$i] Then
			Return 1
		ElseIf $aTarget[$i] < $aCurrent[$i] Then
			Return -1
		EndIf
		If Not $bStrictComparison Then
			If $i >= 3 Then
				Return 0
			EndIf
		EndIf
		If UBound($aTarget) = $i + 1 Then
			Return 0
		EndIf
	Next

	Return 0
EndFunc


; Private Function

Func PadArray(ByRef $aArrayToPad, $iNumberOfNewEntries)

	Local $bUpdateRequired = True
	Local $iOriginalArraySize = UBound($aArrayToPad)

	ReDim $aArrayToPad[$iOriginalArraySize + $iNumberOfNewEntries]
	$i = $iOriginalArraySize;
	While $bUpdateRequired
		$aArrayToPad[$i] = 0;
		$i+=1
		If $i >= UBound($aArrayToPad) Then
			$bUpdateRequired = False
		EndIf
	WEnd
	$aArrayToPad[0] = UBound($aArrayToPad) - 1
EndFunc
