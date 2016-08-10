# New-RandomPassword

Generate passwords with a freely definable number of characters.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-RandomPassword.ps1)

## Description

Generate passwords with a freely definable number of characters. You can also select which chars you want to use (upper case, lower case, numbers and special chars).

![Screenshot](Images/New-RandomPassword.png?raw=true "New-RandomPassword")

## Syntax 

```powershell
New-RandomPassword [[-Length] <Int32>] [[-DisableLowerCase]] [[-DisableUpperCase]] [[-DisableNumbers]] [[-DisableSpecialChars]] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example 1

```powershell
PS> New-RandomPassword -Length 8

NX58m2B$
```

## Example 2

```powershell
PS> New-RandomPassword -Length 10 -DisableSpecialChars

7UZE6pyyGM
```