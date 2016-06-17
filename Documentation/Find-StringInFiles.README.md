# Find-StringInFiles.ps1 / Find-StringInFiles

Script/Function to find a string in one or multiple files

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Find-StringInFiles.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Find-StringInFiles.ps1)

## Syntax

### Script

```powershell
.\Find-StringInFiles.ps1 [-Path] <String> [-Find] <String> [[-CaseSensitive]] [<CommonParameters>]
```

### Function

```powershell
Find-StringInFiles [-Path] <String> [-Find] <String> [[-CaseSensitive]] [<CommonParameters>]
``` 

## Example

### Script

```powershell
.\Find-StringInFiles.ps1 -Path "C:\Scripts\FolderWithFiles\" -Find "Computer"
```

### Function

```powershell
Find-StringInFiles -Path "C:\Scripts\FolderWithFiles\" -Find "Computer"
```

## Output

```
Filename      Path                                     LineNumber Matches
--------      ----                                     ---------- -------
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          1 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          3 {Computer}
PC_List_1.txt C:\Scripts\FolderWithFiles\PC_List_1.txt          6 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          1 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          3 {Computer}
PC_List_4.txt C:\Scripts\FolderWithFiles\PC_List_4.txt          6 {Computer}
```
