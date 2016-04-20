# Test-IsFileBinary

Function to check if a file is binary 

* [view function](Test-IsFileBinary.ps1)

## Description

Function to check if a file is binary. Returns true for binary or false for text files.

This code is not from me. I found this code snippet on [Stackoverflow](https://stackoverflow.com/questions/1077634/powershell-search-script-that-ignores-binary-files).

# Syntax

```powershell
Test-IsFileBinary [-Path] <String> [<CommonParameters>]
``` 

## Example

```powershell
Test-IsFileBinary -Path "C:\Scripts\FolderWithFiles\Test.zip"
```