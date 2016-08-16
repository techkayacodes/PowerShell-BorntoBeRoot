# New-RandomPassword

Generate passwords with a freely definable number of characters.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-RandomPassword.ps1)

## Description

Generate passwords with a freely definable number of characters. You can also select which chars you want to use (upper case, lower case, numbers and special chars).

![Screenshot](Images/New-RandomPassword.png?raw=true "New-RandomPassword")

## Syntax 

```powershell
New-RandomPassword [[-Length] <Int32>] [[-Count] <Int32>] [[-DisableLowerCase]] [[-DisableUpperCase]] [[-DisableNumbers]] [[-DisableSpecialChars]] [<CommonParameters>]

New-RandomPassword [[-Length] <Int32>] [[-CopyToClipboard]] [[-DisableLowerCase]] [[-DisableUpperCase]] [[-DisableNumbers]] [[-DisableSpecialChars]] [<CommonParameters>]
```

## Example 1

```powershell
PS> New-RandomPassword -DisableSpecialChars

Password
--------
8uUtzddG  
```

## Example 2

```powershell
PS> New-RandomPassword -Length 6 -Count 10

Count Password
----- --------
    1 K5G+#E
    2 zXTpcr
    3 1A0D-3
    4 -eF*aR
    5 2GY]Hc
    6 eB-ukp
    7 &r54*h
    8 d%fz?=
    9 #lcEea
    10 4(Z$w*
```