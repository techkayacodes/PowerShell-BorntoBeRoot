# New-IPv4Subnet.ps1 / New-IPv4Subnet

Script/Function to calculate a subnet based on an IP-Address within the subnet and the subnetmask/CIDR.

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Scriptname.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functioname.ps1)

## Description

Script/Function to calculate a subnet based on an IP-Address within the subnet and the subnetmask/CIDR.

The result will contain the NetworkIP, Broadcast, total IPs and the available host IPs.

![Screenshot](New-IPv4Subnet.png?raw=true)

## Syntax

### Module

```powershell
New-IPv4Subnet [[-IPv4Address] <IPAddress>] [[-CIDR] <Int32>] [<CommonParameters>]

New-IPv4Subnet [[-IPv4Address] <IPAddress>] [[-Mask] <IPAddress>] [<CommonParameters>]
```

### Script

```powershell
.\New-IPv4Subnet.ps1 [[-IPv4Address] <IPAddress>] [[-CIDR] <Int32>] [<CommonParameters>]

.\New-IPv4Subnet.ps1 [[-IPv4Address] <IPAddress>] [[-Mask] <IPAddress>] [<CommonParameters>]
``` 

## Example

### Module

```powershell
PS> New-IPv4Subnet -IPv4Address 192.168.24.96 -CIDR 27

NetworkID     Broadcast      IPs Hosts
---------     ---------      --- -----
192.168.24.96 192.168.24.127  32    30
```

### Script

```powershell
PS> .\New-IPv4Subnet.ps1 -IPv4Address 192.168.1.0 -Mask 255.255.255.0

NetworkID   Broadcast     IPs Hosts
---------   ---------     --- -----
192.168.1.0 192.168.1.255 256   254
```
