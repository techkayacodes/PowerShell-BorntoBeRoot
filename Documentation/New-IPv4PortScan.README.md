# New-IPv4PortScan

Powerful asynchronus IPv4 Port Scanner.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/New-IPv4PortScan.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/New-IPv4PortScan.ps1)

## Description

This powerful asynchronus IPv4 Port Scanner allows you to scan every Port-Range you want (500 to 2600 would work). Only TCP-Ports are scanned.

The result will contain the Port number, Protocol, Service name, Description and the Status.

![Screenshot](Images/New-IPv4PortScan.png?raw=true "New-IPv4PortScan")

To reach the best possible performance, this script uses a [RunspacePool](https://msdn.microsoft.com/en-US/library/system.management.automation.runspaces.runspacepool(v=vs.85).aspx). As you can see in the following screenshot, the individual tasks are distributed across all cpu cores:

![Screenshot](Images/New-IPv4PortScan_CPUusage.png?raw=true "CPU usage")

## Syntax

### Function

```powershell
New-IPv4PortScan [-ComputerName] <String> [[-StartPort] <Int32>] [[-EndPort] <Int32>] [[-Threads] <Int32>] [[-Force]] [[-UpdateList]] [<CommonParameters>]
```

### Script

```powershell
.\New-IPv4PortScan.ps1 [-ComputerName] <String> [[-StartPort] <Int32>] [[-EndPort] <Int32>] [[-Threads] <Int32>] [[-Force]] [[-UpdateList]] [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> New-IPv4PortScan -ComputerName fritz.box -StartPort 1 -EndPort 500

Port Protocol ServiceName ServiceDescription               Status
---- -------- ----------- ------------------               ------
  21 tcp      ftp         File Transfer Protocol [Control] Open
  53 tcp      domain      Domain Name Server               Open
  80 tcp      http        World Wide Web HTTP              Open
```

### Script

```powershell
PS> .\New-IPv4PortScan.ps1 -ComputerName TEST-PC-01 -StartPort 1 -EndPort 500
PS> TEST-PC-01 is not reachable!
PS> Would you like to continue? (perhaps only ICMP is blocked) [yes|no]: yes

Port Protocol ServiceName ServiceDescription               Status
---- -------- ----------- ------------------               ------
  80 tcp      http        World Wide Web HTTP              Open
```