# Get-InstalledSoftware

Get all installed software with DisplayName, Publisher and UninstallString.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Get-InstalledSoftware.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Get-InstalledSoftware.ps1)

## Description

 Get all installed software with DisplayName, Publisher and UninstallString from a local or remote computer. The result will also include the InstallLocation and the InstallDate. To reduce the results, you can use the parameter "-Search *PRODUCTNAME*".

![Screenshot](Images/Get-InstalledSoftware.png?raw=true "Get-InstalledSoftware")

## Syntax 

### Function

```powershell
Get-InstalledSoftware [[-ComputerName] <String>] [[-Search] <String>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

### Script

```powershell
.\Get-InstalledSoftware.ps1 [[-ComputerName] <String>] [[-Search] <String>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## Example

### Function

```powershell
PS> Get-InstalledSoftware -Search "*chrome*"

DisplayName     : Google Chrome
Publisher       : Google Inc.
UninstallString : "C:\Program Files (x86)\Google\Chrome\Application\51.0.2704.103\Installer\setup.exe" --uninstall --multi-install --chrome --system-level
InstallLocation : C:\Program Files (x86)\Google\Chrome\Application
InstallDate     : 20160506
```

### Script

```powershell
PS> .\Get-InstalledSoftware.ps1 -ComputerName TEST-PC-01 -Search "*visual studio*" | Format-Table

DisplayName                        UninstallString                    InstallLocation                    InstallDate
-----------                        ---------------                    ---------------                    -----------
Microsoft Visual Studio Team Fo... MsiExec.exe /I{04B5C251-079F-31...                                    20151217
Visual Studio 2015 Prerequisite... MsiExec.exe /X{447A06BC-E1AC-4D...                                    20151217
Microsoft Visual Studio 2015-Le... MsiExec.exe /I{4F4AD505-AAA6-40...                                    20151217
Visual Studio 2010 Prerequisite... MsiExec.exe /X{53952792-BF16-30...                                    20150914
Microsoft Visual Studio 2015 Vs... MsiExec.exe /I{599702AA-91EB-38...                                    20151217
```
