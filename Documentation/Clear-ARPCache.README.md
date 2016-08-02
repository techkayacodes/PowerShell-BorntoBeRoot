# Clear-ARPCache

Clear the ARP cache.

* [view function](https://github.com/BornToBeRoot/PowerShell/blob/master/Module/LazyAdmin/Functions/Clear-ARPCache.ps1)
* [view script](https://github.com/BornToBeRoot/PowerShell/blob/master/Scripts/Clear-ARPCache.ps1)

## Description

Clear the Address Resolution Protocol (ARP) cache, which is used for resolution of internet layer addresses into link layer addresses.

![Screenshot](Images/Clear-ARPCache.png?raw=true)

## Syntax

### Function

```powershell
Clear-ARPCache [<CommonParameters>]
```

### Script

```powershell
.\Clear-ARPCache.ps1 [<CommonParameters>]
``` 

## Example

### Function

```powershell
PS> Clear-ARPCache
```

### Script

```powershell
PS> .\Clear-ARPCache.ps1
```

## Further information

* [Netsh commands for Interface IP - Technet](https://technet.microsoft.com/en-us/library/bb490943.aspx)
* [Address Resolution Protocol - Wikipedia](https://en.wikipedia.org/wiki/Address_Resolution_Protocol)