# Search-StringInFiles

Find a string in one or multiple files.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Search-StringInFiles.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Search-StringInFiles.ps1)

# Description

Find a string in one or multiple files. The search is performed recursively from the start folder.

![Screenshot](Images/Search-StringInFiles.png?raw=true)

## Syntax

### Function

```powershell
Search-StringInFiles [-Path] <String> [-Search] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

### Script

```powershell
.\Search-StringInFiles.ps1 [-Path] <String> [-Search] <String> [[-CaseSensitive]] [<CommonParameters>]
```

## Example

### Function

```powershell
PS> Search-StringInFiles -Path "C:\Scripts\FolderWithFiles" -Search "Test01"
       
Filename    Path                      LineNumber Matches
--------    ----                      ---------- -------
File_01.txt E:\Temp\Files\File_01.txt          1 {Test01}
File_02.txt E:\Temp\Files\File_02.txt          1 {TEST01}
File_03.txt E:\Temp\Files\File_03.txt          1 {TeST01}
```

### Script

```powershell
PS> .\Search-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles" -Search "TEST01" -CaseSensitive

Filename    Path                      LineNumber Matches
--------    ----                      ---------- -------
File_02.txt E:\Temp\Files\File_02.txt          1 {TEST01}
```