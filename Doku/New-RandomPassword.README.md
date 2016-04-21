# New-RandomPassword

Function to generate a random PIN with a freely definable number of characters

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/New-RandomPassword.ps1)

## Syntax 

```powershell
New-RandomPassword.ps1 [[-Length] <Int32>] [[-LowerCase]] [[-UpperCase]] [[-Numbers]] [[-SpecialChars]] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example

```powershell
New-RandomPassword.ps1 -Length 10 -SpecialChars:$false
```

## Output

```powershell 
7UZE6pyyGM
``` 
