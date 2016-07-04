# New-IPv4Subnet

Calculate a subnet based on an IP-Address and the subnetmask or CIDR.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/New-IPv4Subnet.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/New-IPv4Subnet.ps1)

## Description

Calculate a subnet based on an IP-Address within the subnet and the subnetmask or CIDR. 
The result includes the NetworkID, Broadcast, total available IPs and usable IPs for hosts.

![Screenshot](Images/New-IPv4Subnet.png?raw=true "New-IPv4Subnet")

## Syntax

### Function

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

### Function

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
