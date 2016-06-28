# Test-IsFileBinary 

Test if a file is binary.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Test-IsFileBinary.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Test-IsFileBinary.ps1)

## Description

Test if a file is binary like .exe or .zip.

![Screenshot](Images/Test-IsFileBinary.png?raw=true "Test-IsFileBinary")

I found this code snippet on Stackoverflow: https://stackoverflow.com/questions/1077634/powershell-search-script-that-ignores-binary-files

## Syntax

### Function

```powershell
Test-IsFileBinary [-Path] <String> [<CommonParameters>]
``` 

### Script

```powershell
.\Test-IsFileBinary.ps1 [-Path] <String> [<CommonParameters>]
```

## Example

### Function

```powershell
Test-IsFileBinary -Path "E:\Temp\Files\File_04.zip"

True
```

### Script

```powershell
Test-IsFileBinary -Path "E:\Temp\Files\File_01.txt"

False
```