# Get-ConsoleColors

Get all available console colors.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Get-ConsoleColors.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Get-ConsoleColors.ps1)

## Description

Get all available console colors. A preview how they look (foreground and background) can be displayed with the parameter "-Preview".

![Screenshot](Images/Get-ConsoleColors.png?raw=true)

## Syntax

### Function

```powershell
Get-ConsoleColors [[-Preview]] [<CommonParameters>]
```

### Script

```powershell
.\Get-ConsoleColors.ps1 [[-Preview]] [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> Get-ConsoleColors

ConsoleColor
------------
       Black
    DarkBlue
   DarkGreen
    DarkCyan
     DarkRed
 DarkMagenta
  DarkYellow
        Gray
    DarkGray
        Blue
       Green
        Cyan
         Red
     Magenta
      Yellow
       White
```

### Script

```powershell
PS> .\Get-ConsoleColors

Black --> Foreground, Background
DarkBlue --> Foreground, Background
DarkGreen --> Foreground, Background
DarkCyan --> Foreground, Background
DarkRed --> Foreground, Background
DarkMagenta --> Foreground, Background
DarkYellow --> Foreground, Background
Gray --> Foreground, Background
DarkGray --> Foreground, Background
Blue --> Foreground, Background
Green --> Foreground, Background
Cyan --> Foreground, Background
Red --> Foreground, Background
Magenta --> Foreground, Background
Yellow --> Foreground, Background
White --> Foreground, Background

ConsoleColor
------------
       Black
    DarkBlue
   DarkGreen
    DarkCyan
     DarkRed
 DarkMagenta
  DarkYellow
        Gray
    DarkGray
        Blue
       Green
        Cyan
         Red
     Magenta
      Yellow
       White
```