# Update-StringInFiles.ps1 / Update-StringInFiles

Script/Function to replace a string in one or multiple files

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Update-StringInFiles.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Update-StringInFiles.ps1)

## Description

Script/Function to replace a string in one or multiple files.

Binary files (*.zip, *.exe, etc.) are not touched by this script to avoid errors 

## Syntax

### Script

```powershell
.\Update-StringInFiles.ps1 [-Path] <String> [-Search] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

### Function

```powershell
Update-StringInFiles [-Path] <String> [-Search] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
```

## Example

### Script

```powershell
PS> .\Update-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles\" -Search "Computer" -ReplaceWith "Notebook" -CaseSensitive -Verbose

VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 2
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_1.txt
VERBOSE: Count: 3
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_4.txt
VERBOSE: Count: 3
```

### Function

```powershell
PS> Update-StringInFiles -Path "C:\Scripts\FolderWithFiles\" -Search "Computer" -ReplaceWith "Notebook" -CaseSensitive -Verbose

VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 2
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_1.txt
VERBOSE: Count: 3
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_4.txt
VERBOSE: Count: 3
```
