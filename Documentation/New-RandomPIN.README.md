# New-RandomPIN

Generate a PIN with a freely definable number of numbers.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-RandomPIN.ps1)

# Description

Generate a PIN with a freely definable number of numbers. You can also set the smallest and greatest possible number. 

![Screenshot](Images/New-RandomPIN.png?raw=true "New-RandomPIN")

## Syntax 

```powershell
New-RandomPIN [[-Length] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-CopyToClipboard]] [<CommonParameters>]
```

## Example 1

```powershell
PS> New-RandomPIN -Length 6

698577
```

## Example

```powershell
PS> New-RandomPIN -Length 8 -Minimum 4 -Maximum 8

56655574
```