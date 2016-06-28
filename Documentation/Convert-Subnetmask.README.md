# Convert-Subnetmask

Convert a subnetmask to CIDR and vise versa.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Convert-Subnetmask.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Convert-Subnetmask.ps1)

## Description

Convert a subnetmask like 255.255.255 to CIDR (/24) and vise versa.

![Screenshot](Images/Convert-Subnetmask.png?raw=true "Convert-Subnetmask")

## Syntax

### Function

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

### Function

```powershell
PS> Convert-Subnetmask -CIDR 24

Mask           CIDR
----           ----
255.255.255.0    24
```

### Script

```powershell
PS> .\Convert-Subnetmask.ps1 -Mask 255.255.0.0

Mask        CIDR
----        ----
255.255.0.0   16
```
