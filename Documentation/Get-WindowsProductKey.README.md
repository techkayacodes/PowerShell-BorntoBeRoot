# Get-WindowsProductKey.ps1 / Get-WindowsProductKey

Script/Function to get the Windows product key and some informations about the system

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Get-WindowsProductKey.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Get-WindowsProductKey.ps1)

## Description

Script/Function to  get the Windows product key from a local or remote system and some informations like Serialnumber, Windows version, Bit-Version etc. from one or more computers. Remote Computers need WinRM enabled. To do this use "winrm quickconfig".

## Syntax 

### Script

```powershell
.\Get-WindowsProductKey.ps1 [[-ComputerName] <String[]>] [[-Credentials] <PSCredential>] [<CommonParameters>]
```

### Function

```powershell
Get-WindowsProductKey [[-ComputerName] <String[]>] [[-Credentials] <PSCredential>] [<CommonParameters>]
```

## Example

### Script

```powershell
.\Get-WindowsProductKey.ps1

$Creds = Get-Credentials
.\Get-WindowsProductKey.ps1 -ComputerName TEST-PC-01,TEST-PC-02 -Credentials $Creds
```

### Function

```powershell
Get-WindowsProductKey -ComputerName TEST-PC-01
```

## Output
```
ComputerName   : TEST-PC-01
WindowsVersion : Microsoft Windows 10 Pro
CSDVersion     :
BitVersion     : 64-bit
BuildNumber    : 10586
ProductID      : 00000-00000-00000-00000
ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
```
