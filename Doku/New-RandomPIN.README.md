# New-RandomPIN.ps1 | New-RandomPIN

Function to generate PINs with a freely definable number of numbers

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/New-RandomPIN.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/New-RandomPIN.ps1)

## Syntax 

### Module

```powershell
New-RandomPIN [[-Length] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-CopyToClipboard]] [<CommonParameters>]
```

### Script

```powershell
.\New-RandomPIN.ps1 [[-Length] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example

### Module

```powershell
New-RandomPIN -Length 6
```

### Script

```powershell
.\New-RandomPIN.ps1 -Length 6
```

## Output

```powershell 
698577
``` 