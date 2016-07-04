# New-RandomPIN

Generate a PIN with a freely definable number of numbers.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-RandomPIN.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/New-RandomPIN.ps1)

# Description

Generate a PIN with a freely definable number of numbers. You can also set the smallest and greatest possible number. 

![Screenshot](Images/New-RandomPIN.png?raw=true "New-RandomPIN")

## Syntax 

### Function

```powershell
New-RandomPIN [[-Length] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-CopyToClipboard]] [<CommonParameters>]
```

### Script

```powershell
.\New-RandomPIN.ps1 [[-Length] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example

### Function

```powershell
PS> New-RandomPIN -Length 6

698577
```

### Script

```powershell
PS> .\New-RandomPIN.ps1 -Length 8 -Minimum 4 -Maximum 8

56655574
```