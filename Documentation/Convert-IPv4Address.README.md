# Convert-IPv4Address

Convert an IPv4-Address to Int64 and vise versa.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Convert-IPv4Address.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Convert-IPv4Address.ps1)

## Description

Convert an IPv4-Address to Int64 and vise versa. The result will contain the IPv4-Address as string and Tnt64.

![Screenshot](Images/Convert-IPv4Address.png?raw=true "Convert-IPv4Address")

## Syntax

### Function

```powershell
Convert-IPv4Address [-IPv4Address] <String> [<CommonParameters>]

Convert-IPv4Address [-Int64] <Int64> [<CommonParameters>]
```

### Script

```powershell
.\Convert-IPv4Address.ps1 [-IPv4Address] <String> [<CommonParameters>]

.\Convert-IPv4Address.ps1 [-Int64] <Int64> [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> Convert-IPv4Address -IPv4Address "192.168.0.1"   

IPv4Address      Int64
-----------      -----
192.168.0.1 3232235521
```

### Script

```powershell
PS> .\Convert-IPv4Address.ps1 -Int64 2886755428

IPv4Address         Int64
-----------         -----
172.16.100.100 2886755428
```