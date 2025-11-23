; Importation des bibliothèques nécessaires
#include <Constants.au3>
#include <Crypt.au3>
#include <String.au3>

; Déclaration et initialisation des variables
Local $URL, $Hash, $HeadHash, $TailHash, $PID, $TabResult, $Cpt, $NbOccurences, $TabTemp
$URL = "https://api.pwnedpasswords.com/range/"
$CURL = @ScriptDir & "\curl.exe"

; Inputbox affichant des '$' à la saisie, directement chiffré dans $Hash
$Hash = _Crypt_HashData(InputBox("Mot de passe", "Veuillez saisir le mot de passe à vérifier :", "", "*"), $CALG_SHA1)
; Suppression de "0x" au début du hash
$Hash = StringReplace($Hash, "0x", "")
; Split du hash en 2 chaines distinctes
$HeadHash = StringLeft($Hash, 5)
$TailHash = StringRight($Hash, 35)

; Interrogation du site et récupération du résultat dans un tableau
$PID = Run($CURL & " -s " & $URL & $HeadHash, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)
ProcessWaitClose($PID)
$TabResult = StringSplit(StringReplace(StdoutRead($PID), @CRLF, ";"), ";")

; Comparaison de chaque résultat reçu avec $TailHash, et si trouvé, récupération du nombre d'occurrence.s
For $Cpt = 1 To $TabResult[0]
	$TabTemp = StringSplit($TabResult[$Cpt], ":")
	If $TabTemp[1] = $TailHash Then	$NbOccurences = $TabTemp[2]
Next

; Mise en forme et affichage du nombre de récurrence.s dans la console de l'éditeur Scite et affichage d'une MsgBox
$NbOccurences = StringStripCR($NbOccurences)
If $NbOccurences = "" Or $NbOccurences = " " Then $NbOccurences = 0
ConsoleWrite("NB = " & $NbOccurences & @CRLF)
If $NbOccurences <> "" Then MsgBox(0, "Mot de passe vérifié", "Le mot de passe dont le hash est " & @CRLF & @CRLF & $HeadHash & "  " & $TailHash & @CRLF & @CRLF & " a " & $NbOccurences & " occurences !")
If $NbOccurences = "" Or $NbOccurences = 0 Then MsgBox(0, "Mot de passe vérifié", "Le mot de passe dont le hash est " & @CRLF & @CRLF & $HeadHash & "  " & $TailHash & @CRLF & @CRLF & "n'a pas été trouvé !")



