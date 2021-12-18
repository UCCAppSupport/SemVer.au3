#include "SemVer.au3"
Global $iTestNumber = 0;
func OutputResults($sPrimeVersion, $sDeltaVersion, $bStrictCompare)
	$iTestNumber+=1
	Local $iResult = SemVerCompare($sPrimeVersion, $sDeltaVersion, $bStrictCompare)
	Local $sPhrase = Null

	Select
		Case $iResult == 1
			$sPhrase = "higher than"
		Case $iResult == 0
			$sPhrase = "the same as"
		Case $iResult == -1
			$sPhrase = "lower than"
		Case Else
			$sPhrase = "ERROR ERROR ERROR"
	EndSelect

	ConsoleWrite("===================================================" & @CRLF)
	ConsoleWrite("Test: " & $iTestNumber & @CRLF)
	ConsoleWrite("Target Version: " & $sDeltaVersion & @CRLF)
	ConsoleWrite("Current Version: " & $sPrimeVersion & @CRLF)
	ConsoleWrite($bStrictCompare ? "Comparison was strict." : "Comparison was NOT strict.")
	ConsoleWrite(@CRLF)
	ConsoleWrite("Target version is " & $sPhrase & " the current version." & @CRLF)
	ConsoleWrite("===================================================" & @CRLF & @CRLF)
EndFunc


$sVersion1 = "1.0"
$sVersion2 = "1.1"
$sVersion3 = "1.1.2"
$sVersion4 = "1.1.1.2"
$sVersion5 = "2.0.0.0.0"
$sVersion6 = "2.0.0.0.5"
$sVersion7 = "2.0.0.1"

OutputResults($sVersion1, $sVersion2, False)
OutputResults($sVersion2, $sVersion1, False)
OutputResults($sVersion1, $sVersion3, False)
OutputResults($sVersion2, $sVersion3, False)
OutputResults($sVersion3, $sVersion2, False)
OutputResults($sVersion4, $sVersion3, False)
OutputResults($sVersion4, $sVersion3, True)
OutputResults($sVersion4, $sVersion5, False)
OutputResults($sVersion5, $sVersion6, False)
OutputResults($sVersion5, $sVersion6, True)
OutputResults($sVersion7, $sVersion6, False)
OutputResults($sVersion7, $sVersion6, True)
OutputResults($sVersion2, $sVersion6, True)
OutputResults($sVersion6, $sVersion2, True)
OutputResults($sVersion6, $sVersion6, True)
