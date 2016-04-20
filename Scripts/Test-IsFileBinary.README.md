# Test-IsFileBinary.ps1

Script to check if a file is binary 

* [view script](Test-IsFileBinary.ps1)

## Description

Script to check if a file is binary. Returns true for binary or false for text files.

This code is not from me. I found this code snippet on [Stackoverflow](https://stackoverflow.com/questions/1077634/powershell-search-script-that-ignores-binary-files).

# Syntax

```powershell
.\Test-IsFileBinary.ps1 [-Path] <String> [<CommonParameters>]
``` 

## Example

```powershell
.\Test-IsFileBinary.ps1 -Path "C:\Scripts\FolderWithFiles\Test.zip"
```