# Update-StringInFiles

Replace a string in one or multiple files.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Update-StringInFiles.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Update-StringInFiles.ps1)

## Description

 Replace a string in one or multiple files.
 Binary files (*.zip, *.exe, etc.) are not touched by this script. 

![Screenshot](Update-StringInFiles.png?raw=true)

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
PS> Update-StringInFiles -Path E:\Temp\Files\ -Search "Test01" -ReplaceWith "Test02" -Verbose
       
VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 3
VERBOSE: File: E:\Temp\Files\File_01.txt
VERBOSE: Count: 1
VERBOSE: File: E:\Temp\Files\File_02.txt
VERBOSE: Count: 1
VERBOSE: File: E:\Temp\Files\File_03.txt
```

### Script

```powershell
PS> .\Update-StringInFiles.ps1 -Path E:\Temp\Files\ -Search "Test01" -ReplaceWith "Test02" -Verbose
       
VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 3
VERBOSE: File: E:\Temp\Files\File_01.txt
VERBOSE: Count: 1
VERBOSE: File: E:\Temp\Files\File_02.txt
VERBOSE: Count: 1
VERBOSE: File: E:\Temp\Files\File_03.txt
```
