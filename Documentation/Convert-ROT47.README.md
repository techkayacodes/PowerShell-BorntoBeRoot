# Convert-ROT47

Rotate ascii chars by n places (Caesar cipher).

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Convert-ROT47.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Convert-ROT47.ps1)

## Description

Rotate ascii chars by n places (Caesar cipher). You can encrypt with the parameter `-Encrypt` or decrypt with the parameter `-Decrypt`, depens on what you need. Decryption is selected by default.

Try the parameter `-UseAllAsciiChars` if you have a string with umlauts which e.g. exist in the German language.

![Screenshot](Images/Convert-ROT47.png?raw=true "Convert-ROT47")

## Syntax

### Function

```powershell
Convert-ROT47 [-Text] <String> [[-Rot] <Int32[]>] [[-Decrypt]] [[-UseAllAsciiChars]] [<CommonParameters>]

Convert-ROT47 [-Text] <String> [[-Rot] <Int32[]>] [[-Encrypt]] [[-UseAllAsciiChars]] [<CommonParameters>]
```

### Script

```powershell
.\Convert-ROT47.ps1 [-Text] <String> [[-Rot] <Int32[]>] [[-Decrypt]] [[-UseAllAsciiChars]] [<CommonParameters>]

.\Convert-ROT47.ps1 [-Text] <String> [[-Rot] <Int32[]>] [[-Encrypt]] [[-UseAllAsciiChars]] [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> Convert-ROT47 -Text "This is an encrypted string!" -Rot 7

Rot Text
--- ----
  7 [opz pz hu lujy"w{lk z{ypun(

PS> Convert-ROT47 -Text '[opz pz hu lujy"w{lk z{ypun(' -Rot (1..10)

Rot Text
--- ----
  1 Znoy oy gt ktix!vzkj yzxotm'
  2 Ymnx nx fs jshw~uyji xywnsl&
  3 Xlmw mw er irgv}txih wxvmrk%
  4 Wklv lv dq hqfu|swhg vwulqj$
  5 Vjku ku cp gpet{rvgf uvtkpi#
  6 Uijt jt bo fodszqufe tusjoh"
  7 This is an encrypted string!
  8 Sghr hr `m dmbqxosdc rsqhmf~
  9 Rfgq gq _l clapwnrcb qrpgle}
 10 Qefp fp ^k bk`ovmqba pqofkd|
```

### Script

```powershell
PS> .\Convert-ROT47.ps1 -Text "Beispiel: Cäsar-Verschlüsselung - Sprache Deutsch!" -Rot 3 -Encrypt -UseAllAsciiChars

Rot Text
--- ----
  3 Ehlvslho= Fçvdu0Yhuvfkoÿvvhoxqj 0 Vsudfkh Ghxwvfk$

PS> Convert-ROT47 -Text "Ehlvslho= Fçvdu0Yhuvfkoÿvvhoxqj 0 Vsudfkh Ghxwvfk$" -Rot (1..10) -UseAllAsciiChars

Rot Text
--- ----
  1 Dgkurkgn< Eæuct/Xgtuejnþuugnwpi / Urtcejg Fgwvuej#
  2 Cfjtqjfm; Dåtbs.Wfstdimýttfmvoh . Tqsbdif Efvutdi"
  3 Beispiel: Cäsar-Verschlüsselung - Sprache Deutsch!
  4 Adhrohdk9 Bãr`q,Udqrbgkûrrdktmf , Roq`bgd Cdtsrbg
  5 @cgqngcj8 Aâq_p+Tcpqafjúqqcjsle + Qnp_afc Bcsrqaf▼
  6 ?bfpmfbi7 @áp^o*Sbop`eiùppbirkd * Pmo^`eb Abrqp`e▲
  7 >aeoleah6 ?ào]n)Rano_dhøooahqjc ) Oln]_da @aqpo_d↔
  8 =`dnkd`g5 >ßn\m(Q`mn^cg÷nn`gpib ( Nkm\^c` ?`pon^c∟
  9 <_cmjc_f4 =Þm[l'P_lm]bfömm_foha ' Mjl[]b_ >_onm]b←
  10 ;^blib^e3 <ÝlZk&O^kl\aeõll^eng` & LikZ\a^ =^nml\a→
```

## Further information

* [Caesar cipher (rotate by n places) - Wikipedia](https://en.wikipedia.org/wiki/Caesar_cipher)
