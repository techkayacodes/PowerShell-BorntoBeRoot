# Get-ConsoleColor

Get all available console colors.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Get-ConsoleColor.ps1)

## Description

Get all available console colors. A preview how they look (foreground and background) can be displayed with the parameter "-Preview".

![Screenshot](Images/Get-ConsoleColor.png?raw=true)

## Syntax

```powershell
Get-ConsoleColor [[-Preview]] [<CommonParameters>]
```

## Example 1

```powershell
PS> Get-ConsoleColor

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

## Example 2

```powershell
PS> Get-ConsoleColor -Preview

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