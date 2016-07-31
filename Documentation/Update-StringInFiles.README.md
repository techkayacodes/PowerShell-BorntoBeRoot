# Update-StringInFiles

Replace a string in one or multiple files.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Update-StringInFiles.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Update-StringInFiles.ps1)

## Description

 Replace a string in one or multiple files.
 Binary files (*.zip, *.exe, etc.) are not touched by this script. 

![Screenshot](Images/Update-StringInFiles.png?raw=true "Update-StringInFiles")

## Syntax

### Function

```powershell
Update-StringInFiles [-Path] <String> [-Search] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
```

### Script

```powershell
.\Update-StringInFiles.ps1 [-Path] <String> [-Search] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> Update-StringInFiles -Path E:\Temp\Files\ -Search "Test1" -ReplaceWith "Test2" -Verbose
       
VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Total files with string to replace found: 3
VERBOSE: Current file: E:\Temp\Files\File_01.txt
VERBOSE: Number of strings to replace in current file: 1
VERBOSE: Current file: E:\Temp\Files\File_02.txt
VERBOSE: Number of strings to replace in current file: 1
VERBOSE: Current file: E:\Temp\Files\File_03.txt
VERBOSE: Number of strings to replace in current file: 2
```

### Script

```powershell
PS> .\Update-StringInFiles.ps1 -Path E:\Temp\Files\ -Search "Test1" -ReplaceWith "Test2" -Verbose
       
VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Total files with string to replace found: 3
VERBOSE: Current file: E:\Temp\Files\File_01.txt
VERBOSE: Number of strings to replace in current file: 1
VERBOSE: Current file: E:\Temp\Files\File_02.txt
VERBOSE: Number of strings to replace in current file: 1
VERBOSE: Current file: E:\Temp\Files\File_03.txt
VERBOSE: Number of strings to replace in current file: 2
```
