# Get-InstalledSoftware.ps1 / Get-InstalledSoftware

Script/Function to get the Windows product key and some informations about the system

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Get-WindowsProductKey.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Get-WindowsProductKey.ps1)

## Description

Script/Function to get the Windows product key and some informations about the system like Serialnumber, Windows version, Bit-Version etc. from one or more computers. Remote computers need WinRM enabled. To do this use `winrm quickconfig`. Both computer must be a member of the domain to authentificate each other.

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

 
```
