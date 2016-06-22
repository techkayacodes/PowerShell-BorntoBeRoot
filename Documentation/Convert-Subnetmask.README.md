# Convert-Subnetmask.ps1 / Convert-Subnetmask

Convert a subnetmask (XXX.XXX.XXX.XXX) to CIDR (/XX) or vise versa

* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Convert-Subnetmask.ps1)
* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Convert-Subnetmask.ps1)

## Description

Convert a subnetmask (XXX.XXX.XXX.XXX) to CIDR (/XX) or vise versa

## Syntax

### Module

```powershell
Convert-Subnetmask [[-CIDR] <Int32>] [<CommonParameters>]

Convert-Subnetmask [[-Mask] <IPAddress>] [<CommonParameters>]
```

### Script

```powershell
.\Convert-Subnetmask.ps1 [[-CIDR] <Int32>] [<CommonParameters>]

.\Convert-Subnetmask.ps1 [[-Mask] <IPAddress>] [<CommonParameters>]
``` 

## Example

### Module

```powershell
PS> Convert-Subnetmask -CIDR 24

Mask           CIDR
----           ----
255.255.255.0  24
```

### Script

```powershell
PS> .\Convert-Subnetmask.ps1 -Mask 255.255.0.0

Mask        CIDR
----        ----
255.255.0.0   16
```