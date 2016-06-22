# Replace-StringInFiles.ps1 / Replace-StringInFiles

Script/Function to replace a string in one or multiple files

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Replace-StringInFiles.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Replace-StringInFiles.ps1)

## Description

Script/Function to replace a string in one or multiple files.

Binary files (*.zip, *.exe, etc.) are not touched by this script to avoid errors 

## Syntax

### Script

```powershell
.\Replace-StringInFiles.ps1 [-Path] <String> [-Find] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

### Function

```powershell
Replace-StringInFiles [-Path] <String> [-Find] <String> [-ReplaceWith] <String> [[-CaseSensitive]] [<CommonParameters>]
```

## Example

### Script

```powershell
PS> .\Replace-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles\" -Find "Computer" -ReplaceWith "Notebook" -CaseSensitive -Verbose

VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 2
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_1.txt
VERBOSE: Count: 3
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_4.txt
VERBOSE: Count: 3
```

### Function

```powershell
PS> Replace-StringInFiles -Path "C:\Scripts\FolderWithFiles\" -Find "Computer" -ReplaceWith "Notebook" -CaseSensitive -Verbose

VERBOSE: Binary files like (*.zip, *.exe, etc...) are ignored
VERBOSE: Files with string found: 2
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_1.txt
VERBOSE: Count: 3
VERBOSE: File: C:\Scripts\FolderWithFiles\PC_List_4.txt
VERBOSE: Count: 3
```