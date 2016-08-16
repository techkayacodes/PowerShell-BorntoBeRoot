# New-RandomPIN

Generate a PIN with a freely definable number of numbers.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-RandomPIN.ps1)

# Description

Generate a PIN with a freely definable number of numbers. You can also set the smallest and greatest possible number. 

![Screenshot](Images/New-RandomPIN.png?raw=true "New-RandomPIN")

## Syntax 

```powershell
New-RandomPIN [[-Length] <Int32>] [[-Count] <Int32>] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [<CommonParameters>]

New-RandomPIN [[-Length] <Int32>] [[-CopyToClipboard]] [[-Minimum] <Int32>] [[-Maximum] <Int32>] [<CommonParameters>]
```

## Example 1

```powershell
PS> New-RandomPIN -Length 6

PIN
---
48762921

```

## Example 2

```powershell
PS> New-RandomPIN -Length 6 -Count 5 -Minimum 4 -Maximum 8

Count PIN
----- ---
    1 776467
    2 545574
    3 446465
    4 646464
    5 555646
```