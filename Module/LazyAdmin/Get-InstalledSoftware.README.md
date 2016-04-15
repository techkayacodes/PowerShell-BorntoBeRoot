# Get-InstalledSoftware

Function to get all installed software with DisplayName, Publisher and UninstallString

* [view function](Get-InstalledSoftware.ps1)

## Description

Function to get all installed software with DisplayName, Publisher and UninstallString. It also returns the InstallLocation and InstallDate property. With the parameter "-Search" you can filter the results.

## Syntax 

```powershell
Get-InstalledSoftware [[-Search] <String>] [<CommonParameters>]
```

## Example

```powershell
Get-InstalledSoftware -Search "*visual studio*"
```

## Output

```powershell 
DisplayName                        UninstallString                    InstallLocation                    InstallDate
-----------                        ---------------                    ---------------                    -----------
Microsoft Visual Studio Team Fo... MsiExec.exe /I{04B5C251-079F-31...                                    20151217
Visual Studio 2015 Prerequisite... MsiExec.exe /X{447A06BC-E1AC-4D...                                    20151217
Microsoft Visual Studio 2015-Le... MsiExec.exe /I{4F4AD505-AAA6-40...                                    20151217
Visual Studio 2010 Prerequisite... MsiExec.exe /X{53952792-BF16-30...                                    20150914
Microsoft Visual Studio 2015 Vs... MsiExec.exe /I{599702AA-91EB-38...                                    20151217
``` 

```powershell
DisplayName                        UninstallString                    InstallLocation                    InstallDate
-----------                        ---------------                    ---------------                    -----------
Google Chrome                      "C:\Program Files (x86)\Google\... C:\Program Files (x86)\Google\C... 20150907
```
