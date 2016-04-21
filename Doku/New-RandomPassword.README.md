# New-RandomPassword.ps1 / New-RandomPassword

Script/Function to generate a random PIN with a freely definable number of characters

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Get-InstalledSoftware.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/New-RandomPassword.ps1)

## Syntax 

### Module

```powershell
New-RandomPassword.ps1 [[-Length] <Int32>] [[-LowerCase]] [[-UpperCase]] [[-Numbers]] [[-SpecialChars]] [[-CopyToClipboard]] [<CommonParameters>]
```

### Script

```powershell
.\New-RandomPassword.ps1 [[-Length] <Int32>] [[-LowerCase]] [[-UpperCase]] [[-Numbers]] [[-SpecialChars]] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example

### Module

```powershell
New-RandomPassword -Length 10 -SpecialChars:$false
```

### Script 

```powershell
.\New-RandomPassword.ps1 -Length 10 -SpecialChars:$false
```

## Output

```powershell 
7UZE6pyyGM
``` 
