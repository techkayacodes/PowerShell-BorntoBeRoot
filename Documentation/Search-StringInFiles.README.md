# Search-StringInFiles.ps1 / Search-StringInFiles

Script/Function to find a string in one or multiple files

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Search-StringInFiles.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Search-StringInFiles.ps1)

## Syntax

### Script

```powershell
.\Search-StringInFiles.ps1 [-Path] <String> [-Search] <String> [[-CaseSensitive]] [<CommonParameters>]
```

### Function

```powershell
Search-StringInFiles [-Path] <String> [-Search] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

## Example

### Script

```powershell
PS> .\Search-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles\" -Search "Computer"

Filename      Path                                     LineNumber Matches
--------      ----                                     ---------- -------
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          1 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          3 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          6 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          1 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          3 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          6 {Computer}
```

### Function

```powershell
PS> Search-StringInFiles -Path "C:\Scripts\FolderWithFiles\" -Search "Computer"

Filename      Path                                     LineNumber Matches
--------      ----                                     ---------- -------
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          1 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          3 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          6 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          1 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          3 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          6 {Computer}
```
